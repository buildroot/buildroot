/*---------------------------------------------------------------
 * Copyright (c) 1999,2000,2001,2002,2003
 * The Board of Trustees of the University of Illinois
 * All Rights Reserved.
 *---------------------------------------------------------------
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software (Iperf) and associated
 * documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute,
 * sublicense, and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do
 * so, subject to the following conditions:
 *
 *
 * Redistributions of source code must retain the above
 * copyright notice, this list of conditions and
 * the following disclaimers.
 *
 *
 * Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimers in the documentation and/or other materials
 * provided with the distribution.
 *
 *
 * Neither the names of the University of Illinois, NCSA,
 * nor the names of its contributors may be used to endorse
 * or promote products derived from this Software without
 * specific prior written permission.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE CONTIBUTORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * ________________________________________________________________
 * National Laboratory for Applied Network Research
 * National Center for Supercomputing Applications
 * University of Illinois at Urbana-Champaign
 * http://www.ncsa.uiuc.edu
 * ________________________________________________________________
 *
 * Server.cpp
 * by Mark Gates <mgates@nlanr.net>
 *     Ajay Tirumala (tirumala@ncsa.uiuc.edu>.
 * -------------------------------------------------------------------
 * A server thread is initiated for each connection accept() returns.
 * Handles sending and receiving data, and then closes socket.
 * Changes to this version : The server can be run as a daemon
 * ------------------------------------------------------------------- */

#define HEADERS()

#include "headers.h"
#include "Server.hpp"
#include "active_hosts.h"
#include "Extractor.h"
#include "Reporter.h"
#include "Locale.h"
#include "delay.h"
#include "PerfSocket.hpp"
#include "SocketAddr.h"
#include "payloads.h"
#include <cmath>
#if defined(HAVE_LINUX_FILTER_H) && defined(HAVE_AF_PACKET)
#include "checksums.h"
#endif


/* -------------------------------------------------------------------
 * Stores connected socket and socket info.
 * ------------------------------------------------------------------- */

Server::Server (thread_Settings *inSettings) {
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Server constructor with thread=%p sum=%p (sock=%d)", (void *) inSettings, (void *)inSettings->mSumReport, inSettings->mSock);
#endif
    mSettings = inSettings;
    myJob = NULL;
    reportstruct = &scratchpad;
    memset(&scratchpad, 0, sizeof(struct ReportStruct));
    mySocket = inSettings->mSock;
    peerclose = false;
#if defined(HAVE_LINUX_FILTER_H) && defined(HAVE_AF_PACKET)
    myDropSocket = inSettings->mSockDrop;
    if (isL2LengthCheck(mSettings)) {
	// For L2 UDP make sure we can receive a full ethernet packet plus a bit more
	if (mSettings->mBufLen < (2 * ETHER_MAX_LEN)) {
	    mSettings->mBufLen = (2 * ETHER_MAX_LEN);
	}
    }
#endif
    // Enable kernel level timestamping if available
    InitKernelTimeStamping();
    int sorcvtimer = 0;
    // sorcvtimer units microseconds convert to that
    // minterval double, units seconds
    // mAmount integer, units 10 milliseconds
    // divide by two so timeout is 1/2 the interval
    if (mSettings->mInterval && (mSettings->mIntervalMode == kInterval_Time)) {
	sorcvtimer = static_cast<int>(round(mSettings->mInterval / 2.0));
    } else if (isServerModeTime(mSettings)) {
	sorcvtimer = static_cast<int>(round(mSettings->mAmount * 10000) / 2);
    }
    isburst = (isIsochronous(mSettings) || isPeriodicBurst(mSettings) || (isTripTime(mSettings) && !isUDP(mSettings)));
    if (isburst && (mSettings->mFPS > 0.0)) {
	sorcvtimer = static_cast<int>(round(2000000.0 / mSettings->mFPS));
    }
    if (sorcvtimer > 0) {
	SetSocketOptionsReceiveTimeout(mSettings, sorcvtimer);
    }
}

/* -------------------------------------------------------------------
 * Destructor close socket.
 * ------------------------------------------------------------------- */
Server::~Server () {
#if HAVE_THREAD_DEBUG
    thread_debug("Server destructor sock=%d fullduplex=%s", mySocket, (isFullDuplex(mSettings) ? "true" : "false"));
#endif
#if defined(HAVE_LINUX_FILTER_H) && defined(HAVE_AF_PACKET)
    if (myDropSocket != INVALID_SOCKET) {
	int rc = close(myDropSocket);
	WARN_errno(rc == SOCKET_ERROR, "server close drop");
	myDropSocket = INVALID_SOCKET;
    }
#endif
}

inline bool Server::InProgress () {
    return !(sInterupted || peerclose ||
	((isServerModeTime(mSettings) || (isModeTime(mSettings) && isReverse(mSettings))) && mEndTime.before(reportstruct->packetTime)));
}

/* -------------------------------------------------------------------
 * Receive TCP data from the (connected) socket.
 * Sends termination flag several times at the end.
 * Does not close the socket.
 * ------------------------------------------------------------------- */
void Server::RunTCP () {
    long currLen;
    intmax_t totLen = 0;
    struct TCP_burst_payload burst_info; // used to store burst header and report in last packet of burst
    Timestamp time1, time2;
    double tokens=0.000004;

    if (!InitTrafficLoop())
	return;
    myReport->info.ts.prevsendTime = myReport->info.ts.startTime;

    int burst_nleft = 0;
    burst_info.burst_id = 0;
    burst_info.burst_period_us = 0;
    burst_info.send_tt.write_tv_sec = 0;
    burst_info.send_tt.write_tv_usec = 0;
    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    while (InProgress()) {
//	printf("***** bid expect = %u\n", burstid_expect);
	reportstruct->emptyreport=1;
	currLen = 0;
	// perform read
	if (isBWSet(mSettings)) {
	    time2.setnow();
	    tokens += time2.subSec(time1) * (mSettings->mAppRate / 8.0);
	    time1 = time2;
	}
	reportstruct->transit_ready = 0;
	if (tokens >= 0.0) {
	    int n = 0;
	    int readLen = mSettings->mBufLen;
	    if (burst_nleft > 0)
		readLen = (mSettings->mBufLen < burst_nleft) ? mSettings->mBufLen : burst_nleft;
	    reportstruct->emptyreport=1;
#if HAVE_DECL_TCP_QUICKACK
		if (isTcpQuickAck(mSettings)) {
		    int opt = 1;
		    Socklen_t len = sizeof(opt);
		    int rc = setsockopt(mySocket, IPPROTO_TCP, TCP_QUICKACK,
					reinterpret_cast<char*>(&opt), len);
		    WARN_errno(rc == SOCKET_ERROR, "setsockopt TCP_QUICKACK");
		}
#endif
	    if (isburst && (burst_nleft == 0)) {
		if ((n = recvn(mSettings->mSock, reinterpret_cast<char *>(&burst_info), sizeof(struct TCP_burst_payload), 0)) == sizeof(struct TCP_burst_payload)) {
		    // burst_info.typelen.type = ntohl(burst_info.typelen.type);
		    // burst_info.typelen.length = ntohl(burst_info.typelen.length);
		    // This is the first stamp of the burst
		    burst_info.flags = ntohl(burst_info.flags);
		    burst_info.burst_size = ntohl(burst_info.burst_size);
		    assert(burst_info.burst_size > 0);
		    reportstruct->burstsize = burst_info.burst_size;
		    burst_info.burst_id = ntohl(burst_info.burst_id);
		    reportstruct->frameID = burst_info.burst_id;
		    if (isTripTime(mSettings)) {
			burst_info.send_tt.write_tv_sec = ntohl(burst_info.send_tt.write_tv_sec);
			burst_info.send_tt.write_tv_usec = ntohl(burst_info.send_tt.write_tv_usec);
		    } else if (isIsochronous(mSettings)) {
			burst_info.send_tt.write_tv_sec = (uint32_t)myReport->info.ts.startTime.tv_sec;
			burst_info.send_tt.write_tv_usec = (uint32_t)myReport->info.ts.startTime.tv_usec;
			burst_info.burst_period_us = ntohl(burst_info.burst_period_us);
		    } else {
			fprintf(stderr, "Program error in server per burst");
		    }
		    reportstruct->sentTime.tv_sec = burst_info.send_tt.write_tv_sec;
		    reportstruct->sentTime.tv_usec = burst_info.send_tt.write_tv_usec;
		    myReport->info.ts.prevsendTime = reportstruct->sentTime;
		    burst_nleft = burst_info.burst_size - n;
		    if (burst_nleft == 0) {
			reportstruct->prevSentTime = myReport->info.ts.prevsendTime;
			reportstruct->transit_ready = 1;
			reportstruct->burstperiod = burst_info.burst_period_us;
		    }
		    currLen += n;
		    readLen = (mSettings->mBufLen < burst_nleft) ? mSettings->mBufLen : burst_nleft;
		    WARN(burst_nleft <= 0, "invalid burst read req size");
		    // thread_debug("***read burst header size %d id=%d", burst_info.burst_size, burst_info.burst_id);
		} else {
		    if (n > 0) {
		        WARN(1, "partial readn");
#ifdef HAVE_THREAD_DEBUG
		        thread_debug("TCP burst partial read of %d wanted %d", n, sizeof(struct TCP_burst_payload));
		    } else {
		        thread_debug("Detected peer close");
#endif
		    }
		    goto Done;
		}
	    }
	    if (!reportstruct->transit_ready) {
		n = recv(mSettings->mSock, mSettings->mBuf, readLen, 0);
		if (n > 0) {
		    reportstruct->emptyreport = 0;
		    if (isburst) {
			burst_nleft -= n;
			if (burst_nleft == 0) {
			    reportstruct->sentTime = myReport->info.ts.prevsendTime;
			    if (isTripTime(mSettings) || isIsochronous(mSettings)) {
				reportstruct->isochStartTime.tv_sec = burst_info.send_tt.write_tv_sec;
				reportstruct->isochStartTime.tv_usec = burst_info.send_tt.write_tv_usec;
				reportstruct->burstperiod = burst_info.burst_period_us;
			    }
			    reportstruct->transit_ready = 1;
			}
		    }
		} else if (n == 0) {
		    peerclose = true;
#ifdef HAVE_THREAD_DEBUG
		    thread_debug("Server thread detected EOF on socket %d", mSettings->mSock);
#endif
		} else if ((n < 0) && (FATALTCPREADERR(errno))) {
		    WARN_errno(1, "recv");
		    peerclose = true;
		    n = 0;
		}
		currLen += n;
	    }
	    now.setnow();
	    reportstruct->packetTime.tv_sec = now.getSecs();
	    reportstruct->packetTime.tv_usec = now.getUsecs();
	    totLen += currLen;
	    if (isBWSet(mSettings))
		tokens -= currLen;

	    reportstruct->packetLen = currLen;
	    ReportPacket(myReport, reportstruct);
	    // Check for reverse and amount where
	    // the server stops after receiving
	    // the expected byte count
	    if (isReverse(mSettings) && !isModeTime(mSettings) && (totLen >= static_cast<intmax_t>(mSettings->mAmount))) {
	        break;
	    }
	} else {
	    // Use a 4 usec delay to fill tokens
	    delay_loop(4);
	}
    }
  Done:
    disarm_itimer();
    // stop timing
    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    reportstruct->packetLen = 0;
    if (EndJob(myJob, reportstruct)) {
#if HAVE_THREAD_DEBUG
	thread_debug("tcp close sock=%d", mySocket);
#endif
	int rc = close(mySocket);
	WARN_errno(rc == SOCKET_ERROR, "server close");
    }
    Iperf_remove_host(mSettings);
    FreeReport(myJob);
}

void Server::PostNullEvent () {
    assert(myReport!=NULL);
    // push a nonevent into the packet ring
    // this will cause the reporter to process
    // up to this event
    memset(reportstruct, 0, sizeof(struct ReportStruct));
    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    reportstruct->emptyreport=1;
    ReportPacket(myReport, reportstruct);
}

inline bool Server::ReadBBWithRXTimestamp () {
    bool rc = false;
    int n;
    while (1) {
	if ((n = recvn(mySocket, mSettings->mBuf, mSettings->mBounceBackBytes, 0)) == mSettings->mBounceBackBytes) {
	    struct bounceback_hdr *bbhdr = reinterpret_cast<struct bounceback_hdr *>(mSettings->mBuf);
	    uint16_t bbflags = ntohs(bbhdr->bbflags);
	    if (!(bbflags & HEADER_BBSTOP)) {
		now.setnow();
		reportstruct->packetTime.tv_sec = now.getSecs();
		reportstruct->packetTime.tv_usec = now.getUsecs();
		reportstruct->emptyreport=0;
		reportstruct->packetLen = mSettings->mBounceBackBytes;
		// write the rx timestamp back into the payload
		bbhdr->bbserverRx_ts.sec = htonl(reportstruct->packetTime.tv_sec);
		bbhdr->bbserverRx_ts.usec = htonl(reportstruct->packetTime.tv_usec);
		ReportPacket(myReport, reportstruct);
		rc = true;
	    } else {
		peerclose = true;
	    }
	    break;
	} else if (n==0) {
	    peerclose = true;
	    break;
	} else if (n == -2){
	    PostNullEvent();
	} else {
	    break;
	}
    }
    return rc;
}

void Server::RunBounceBackTCP () {
    if (!InitTrafficLoop())
	return;
#if HAVE_DECL_TCP_NODELAY
    {
	int nodelay = 1;
	// set TCP nodelay option
	int rc = setsockopt(mySocket, IPPROTO_TCP, TCP_NODELAY,
			    reinterpret_cast<char*>(&nodelay), sizeof(nodelay));
	WARN_errno(rc == SOCKET_ERROR, "setsockopt BB TCP_NODELAY");
	setNoDelay(mSettings);
    }
#endif
    if (mSettings->mInterval && (mSettings->mIntervalMode == kInterval_Time)) {
	int sotimer = static_cast<int>(round(mSettings->mInterval / 2.0));
	SetSocketOptionsSendTimeout(mSettings, sotimer);
	SetSocketOptionsReceiveTimeout(mSettings, sotimer);
    } else if (isModeTime(mSettings)) {
	int sotimer = static_cast<int>(round(mSettings->mAmount * 10000) / 2);
	SetSocketOptionsSendTimeout(mSettings, sotimer);
	SetSocketOptionsReceiveTimeout(mSettings, sotimer);
    }
    myReport->info.ts.prevsendTime = myReport->info.ts.startTime;
    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    reportstruct->packetLen = mSettings->mBounceBackBytes;
    reportstruct->emptyreport=0;
    ReportPacket(myReport, reportstruct);

    while (InProgress()) {
	int n;
	reportstruct->emptyreport=1;
	do {
	    struct bounceback_hdr *bbhdr = reinterpret_cast<struct bounceback_hdr *>(mSettings->mBuf);
	    if (mSettings->mBounceBackHold) {
#if HAVE_DECL_TCP_QUICKACK
		if (isTcpQuickAck(mSettings)) {
		    int opt = 1;
		    Socklen_t len = sizeof(opt);
		    int rc = setsockopt(mySocket, IPPROTO_TCP, TCP_QUICKACK,
					reinterpret_cast<char*>(&opt), len);
		    WARN_errno(rc == SOCKET_ERROR, "setsockopt TCP_QUICKACK");
		}
#endif
		delay_loop(mSettings->mBounceBackHold);
	    }
	    now.setnow();
	    bbhdr->bbserverTx_ts.sec = htonl(now.getSecs());
	    bbhdr->bbserverTx_ts.usec = htonl(now.getUsecs());
	    if (mSettings->mTOS) {
	        bbhdr->tos = htons((uint16_t)(mSettings->mTOS & 0xFF));
	    }
	    if ((n = writen(mySocket, mSettings->mBuf, mSettings->mBounceBackBytes, &reportstruct->writecnt)) == mSettings->mBounceBackBytes) {
		reportstruct->emptyreport=0;
		reportstruct->packetLen = n;
		ReportPacket(myReport, reportstruct);
	    } else {
		break;
	    }
	} while (ReadBBWithRXTimestamp());
    }
    disarm_itimer();
    // stop timing
    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    reportstruct->packetLen = 0;
    if (EndJob(myJob, reportstruct)) {
#if HAVE_THREAD_DEBUG
	thread_debug("tcp close sock=%d", mySocket);
#endif
	int rc = close(mySocket);
	WARN_errno(rc == SOCKET_ERROR, "server close");
    }
    Iperf_remove_host(mSettings);
    FreeReport(myJob);
}

void Server::InitKernelTimeStamping () {
#if HAVE_DECL_SO_TIMESTAMP
    iov[0].iov_base=mSettings->mBuf;
    iov[0].iov_len=mSettings->mBufLen;

    message.msg_iov=iov;
    message.msg_iovlen=1;
    message.msg_name=&srcaddr;
    message.msg_namelen=sizeof(srcaddr);

    message.msg_control = (char *) ctrl;
    message.msg_controllen = sizeof(ctrl);

    int timestampOn = 1;
    if (setsockopt(mSettings->mSock, SOL_SOCKET, SO_TIMESTAMP, &timestampOn, sizeof(timestampOn)) < 0) {
	WARN_errno(mSettings->mSock == SO_TIMESTAMP, "socket");
    }
#endif
}

//
// Set the report start times and next report times, options
// are now, the accept time or the first write time
//
inline void Server::SetFullDuplexReportStartTime () {
    assert(myReport->FullDuplexReport != NULL);
    struct TransferInfo *fullduplexstats = &myReport->FullDuplexReport->info;
    assert(fullduplexstats != NULL);
    if (TimeZero(fullduplexstats->ts.startTime)) {
	fullduplexstats->ts.startTime = myReport->info.ts.startTime;
	if (isModeTime(mSettings)) {
	    fullduplexstats->ts.nextTime = myReport->info.ts.nextTime;
	}
    }
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Server fullduplex report start=%ld.%ld next=%ld.%ld", fullduplexstats->ts.startTime.tv_sec, fullduplexstats->ts.startTime.tv_usec, fullduplexstats->ts.nextTime.tv_sec, fullduplexstats->ts.nextTime.tv_usec);
#endif
}

inline void Server::SetReportStartTime () {
    if (TimeZero(myReport->info.ts.startTime)) {
	if (!TimeZero(mSettings->sent_time) && !isTxStartTime(mSettings)) {
	    // Servers that aren't full duplex use the accept timestamp for start
	    myReport->info.ts.startTime.tv_sec = mSettings->sent_time.tv_sec;
	    myReport->info.ts.startTime.tv_usec = mSettings->sent_time.tv_usec;
	} else if (!TimeZero(mSettings->accept_time) && !isTxStartTime(mSettings)) {
	    // Servers that aren't full duplex use the accept timestamp for start
	    myReport->info.ts.startTime.tv_sec = mSettings->accept_time.tv_sec;
	    myReport->info.ts.startTime.tv_usec = mSettings->accept_time.tv_usec;
	} else {
	    now.setnow();
	    myReport->info.ts.startTime.tv_sec = now.getSecs();
	    myReport->info.ts.startTime.tv_usec = now.getUsecs();
	}
    }
    myReport->info.ts.IPGstart = myReport->info.ts.startTime;

    if (!TimeZero(myReport->info.ts.intervalTime)) {
	myReport->info.ts.nextTime = myReport->info.ts.startTime;
	TimeAdd(myReport->info.ts.nextTime, myReport->info.ts.intervalTime);
    }
    if (myReport->GroupSumReport) {
	struct TransferInfo *sumstats = &myReport->GroupSumReport->info;
	assert(sumstats != NULL);
	Mutex_Lock(&myReport->GroupSumReport->reference.lock);
	if (TimeZero(sumstats->ts.startTime)) {
	    sumstats->ts.startTime = myReport->info.ts.startTime;
	    if (isModeTime(mSettings) || isModeInfinite(mSettings)) {
		sumstats->ts.nextTime = myReport->info.ts.nextTime;
	    }
	}
	Mutex_Unlock(&myReport->GroupSumReport->reference.lock);
    }
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Server(%d) report start=%ld.%ld next=%ld.%ld", mSettings->mSock, myReport->info.ts.startTime.tv_sec, myReport->info.ts.startTime.tv_usec, myReport->info.ts.nextTime.tv_sec, myReport->info.ts.nextTime.tv_usec);
#endif
}

void Server::ClientReverseFirstRead (void) {
    // Handle the case when the client spawns a server (no listener) and need the initial header
    // Case of --trip-times and --reverse or --fullduplex, listener handles normal case
    // Handle the case when the client spawns a server (no listener) and need the initial header
    // Case of --trip-times and --reverse or --fullduplex, listener handles normal case
    if (isReverse(mSettings) && (isTripTime(mSettings) || isPeriodicBurst(mSettings) || isIsochronous(mSettings))) {
        int nread = 0;
	uint32_t flags = 0;
	int readlen = 0;
	if (isUDP(mSettings)) {
	    nread = recvn(mSettings->mSock, mSettings->mBuf, mSettings->mBufLen, 0);
	    switch (nread) {
	    case 0:
		//peer closed the socket, with no writes e.g. a connect-only test
		peerclose = true;
		break;
	    case -1 :
		FAIL_errno(1, "recvn-reverse", mSettings);
		break;
	    default :
		struct client_udp_testhdr *udp_pkt = reinterpret_cast<struct client_udp_testhdr *>(mSettings->mBuf);
		flags = ntohl(udp_pkt->base.flags);
		if (isTripTime(mSettings)) {
		    mSettings->sent_time.tv_sec = ntohl(udp_pkt->start_fq.start_tv_sec);
		    mSettings->sent_time.tv_usec = ntohl(udp_pkt->start_fq.start_tv_usec);
		} else {
		    now.setnow();
		    mSettings->sent_time.tv_sec = now.getSecs();
		    mSettings->sent_time.tv_usec = now.getUsecs();
		}
		reportstruct->packetLen = nread;
		reportstruct->packetID = 1;
		break;
	    }
	} else {
	    nread = recvn(mSettings->mSock, mSettings->mBuf, sizeof(uint32_t), 0);
	    if (nread == 0) {
		fprintf(stderr, "WARN: zero read on header flags\n");
		//peer closed the socket, with no writes e.g. a connect-only test
		peerclose = true;
	    }
	    FAIL_errno((nread < (int) sizeof(uint32_t)), "client read tcp flags", mSettings);
	    reportstruct->packetID = 1;
	    struct client_tcp_testhdr *tcp_pkt = reinterpret_cast<struct client_tcp_testhdr *>(mSettings->mBuf);
	    flags = ntohl(tcp_pkt->base.flags);
	    // figure out the length of the test header
	    if ((readlen = Settings_ClientTestHdrLen(flags, mSettings)) > 0) {
		// read the test settings passed to the mSettings by the client
	        int adj = (readlen - sizeof(uint32_t));
	        nread = recvn(mSettings->mSock, (mSettings->mBuf + sizeof(uint32_t)), adj, 0);
		if (nread == 0) {
		    peerclose = true;
		}
		FAIL_errno((nread < adj), "client read tcp test info", mSettings);
		if (nread > 0) {
		    if (isTripTime(mSettings)) {
			struct client_tcp_testhdr *tcp_pkt = reinterpret_cast<struct client_tcp_testhdr *>(mSettings->mBuf);
			mSettings->sent_time.tv_sec = ntohl(tcp_pkt->start_fq.start_tv_sec);
			mSettings->sent_time.tv_usec = ntohl(tcp_pkt->start_fq.start_tv_usec);
		    } else {
			now.setnow();
			mSettings->sent_time.tv_sec = now.getSecs();
			mSettings->sent_time.tv_sec = now.getUsecs();
		    }
		}
		mSettings->firstreadbytes = readlen;
	    }
	}
    }
}

bool Server::InitTrafficLoop (void) {
    bool UDPReady = true;
    myJob = InitIndividualReport(mSettings);
    myReport = static_cast<struct ReporterData *>(myJob->this_report);
    assert(myJob != NULL);
    //  copy the thread drop socket to this object such
    //  that the destructor can close it if needed
#if defined(HAVE_LINUX_FILTER_H) && defined(HAVE_AF_PACKET)
    if (mSettings->mSockDrop > 0)
        myDropSocket = mSettings->mSockDrop;
#endif
    // Initialze the reportstruct scratchpad
    reportstruct = &scratchpad;
    reportstruct->packetID = 0;
    reportstruct->l2len = 0;
    reportstruct->l2errors = 0x0;

    int setfullduplexflag = 0;
    if (isFullDuplex(mSettings) && !isServerReverse(mSettings)) {
	assert(mSettings->mFullDuplexReport != NULL);
	if ((setfullduplexflag = fullduplex_start_barrier(&mSettings->mFullDuplexReport->fullduplex_barrier)) < 0)
	    exit(-1);
    }
    Timestamp now;
    if (isReverse(mSettings)) {
	mSettings->accept_time.tv_sec = now.getSecs();
	mSettings->accept_time.tv_usec = now.getUsecs();
	ClientReverseFirstRead();
    }
    if (isTripTime(mSettings)) {
	if ((abs(now.getSecs() - mSettings->sent_time.tv_sec)) > MAXDIFFTIMESTAMPSECS) {
	    unsetTripTime(mSettings);
	    fprintf(stdout,"WARN: ignore --trip-times because client didn't provide valid start timestamp within %d seconds of now\n", MAXDIFFTIMESTAMPSECS);
	    mSettings->accept_time.tv_sec = now.getSecs();
	    mSettings->accept_time.tv_usec = now.getUsecs();
	}
    }
    SetReportStartTime();
    reportstruct->prevPacketTime = myReport->info.ts.startTime;

    if (setfullduplexflag)
	SetFullDuplexReportStartTime();

    if (isServerModeTime(mSettings) || (isModeTime(mSettings) && (isBounceBack(mSettings) || isServerReverse(mSettings) || isFullDuplex(mSettings) || isReverse(mSettings)))) {

	if (isServerReverse(mSettings) || isFullDuplex(mSettings) || isReverse(mSettings))
	   mSettings->mAmount += (SLOPSECS * 100);  // add 2 sec for slop on reverse, units are 10 ms

	int end_usecs  (mSettings->mAmount * 10000); //amount units is 10 ms
	if (int err = set_itimer(end_usecs))
	    FAIL_errno(err != 0, "setitimer", mSettings);
        mEndTime.setnow();
        mEndTime.add(mSettings->mAmount / 100.0);
    }
    if (!isSingleUDP(mSettings))
	PostReport(myJob);
    // The first payload is different for TCP so read it and report it
    // before entering the main loop
    if (mSettings->firstreadbytes > 0) {
	reportstruct->frameID = 0;
	reportstruct->packetLen = mSettings->firstreadbytes;
	if (isUDP(mSettings)) {
	    int offset = 0;
	    UDPReady = !ReadPacketID(offset);
	    reportstruct->packetTime = mSettings->accept_time;
	} else {
	    reportstruct->sentTime.tv_sec = myReport->info.ts.startTime.tv_sec;
	    reportstruct->sentTime.tv_usec = myReport->info.ts.startTime.tv_usec;
	    reportstruct->packetTime = reportstruct->sentTime;
	}
	ReportPacket(myReport, reportstruct);
    }
    return UDPReady;
}

inline int Server::ReadWithRxTimestamp () {
    long currLen;
    int tsdone = 0;

#if HAVE_DECL_SO_TIMESTAMP
    cmsg = reinterpret_cast<struct cmsghdr *>(&ctrl);
    currLen = recvmsg(mSettings->mSock, &message, mSettings->recvflags);
    if (currLen > 0) {
	if (cmsg->cmsg_level == SOL_SOCKET &&
	    cmsg->cmsg_type  == SCM_TIMESTAMP &&
	    cmsg->cmsg_len   == CMSG_LEN(sizeof(struct timeval))) {
	    memcpy(&(reportstruct->packetTime), CMSG_DATA(cmsg), sizeof(struct timeval));
	    tsdone = 1;
	}
    }
#else
    currLen = recv(mSettings->mSock, mSettings->mBuf, mSettings->mBufLen, mSettings->recvflags);
#endif
    if (currLen <=0) {
	// Socket read timeout or read error
	reportstruct->emptyreport=1;
	if (currLen == 0) {
	    peerclose = true;
	} else if (FATALUDPREADERR(errno)) {
	    WARN_errno(1, "recvmsg");
	    currLen = 0;
	    peerclose = true;
	}
    } else if (TimeZero(myReport->info.ts.prevpacketTime)) {
	myReport->info.ts.prevpacketTime = reportstruct->packetTime;
    }
    if (!tsdone) {
	now.setnow();
	reportstruct->packetTime.tv_sec = now.getSecs();
	reportstruct->packetTime.tv_usec = now.getUsecs();
    }
    return currLen;
}

// Returns true if the client has indicated this is the final packet
inline bool Server::ReadPacketID (int offset_adjust) {
    bool terminate = false;
    struct UDP_datagram* mBuf_UDP  = reinterpret_cast<struct UDP_datagram*>(mSettings->mBuf + offset_adjust);
    // terminate when datagram begins with negative index
    // the datagram ID should be correct, just negated

    if (isSeqNo64b(mSettings)) {
      // New client - Signed PacketID packed into unsigned id2,id
      reportstruct->packetID = (static_cast<uint32_t>(ntohl(mBuf_UDP->id))) | (static_cast<uintmax_t>(ntohl(mBuf_UDP->id2)) << 32);

#ifdef HAVE_PACKET_DEBUG
      printf("id 0x%x, 0x%x -> %" PRIdMAX " (0x%" PRIxMAX ")\n",
	     ntohl(mBuf_UDP->id), ntohl(mBuf_UDP->id2), reportstruct->packetID, reportstruct->packetID);
#endif
    } else {
      // Old client - Signed PacketID in Signed id
      reportstruct->packetID = static_cast<int32_t>(ntohl(mBuf_UDP->id));
#ifdef HAVE_PACKET_DEBUG
      printf("id 0x%x -> %" PRIdMAX " (0x%" PRIxMAX ")\n",
	     ntohl(mBuf_UDP->id), reportstruct->packetID, reportstruct->packetID);
#endif
    }
    if (reportstruct->packetID < 0) {
      reportstruct->packetID = - reportstruct->packetID;
      terminate = true;
    }
    // read the sent timestamp from the rx packet
    reportstruct->sentTime.tv_sec = ntohl(mBuf_UDP->tv_sec);
    reportstruct->sentTime.tv_usec = ntohl(mBuf_UDP->tv_usec);
    return terminate;
}

void Server::L2_processing () {
#if (HAVE_LINUX_FILTER_H) && (HAVE_AF_PACKET)
    eth_hdr = reinterpret_cast<struct ether_header *>(mSettings->mBuf);
    ip_hdr = reinterpret_cast<struct iphdr *>(mSettings->mBuf + sizeof(struct ether_header));
    // L4 offest is set by the listener and depends upon IPv4 or IPv6
    udp_hdr = reinterpret_cast<struct udphdr *>(mSettings->mBuf + mSettings->l4offset);
    // Read the packet to get the UDP length
    int udplen = ntohs(udp_hdr->len);
    //
    // in the event of an L2 error, double check the packet before passing it to the reporter,
    // i.e. no reason to run iperf accounting on a packet that has no reasonable L3 or L4 headers
    //
    reportstruct->packetLen = udplen - sizeof(struct udphdr);
    reportstruct->expected_l2len = reportstruct->packetLen + mSettings->l4offset + sizeof(struct udphdr);
    if (reportstruct->l2len != reportstruct->expected_l2len) {
	reportstruct->l2errors |= L2LENERR;
	if (L2_quintuple_filter() != 0) {
	    reportstruct->l2errors |= L2UNKNOWN;
	    reportstruct->l2errors |= L2CSUMERR;
	    reportstruct->emptyreport = 1;
	}
    }
    if (!(reportstruct->l2errors & L2UNKNOWN)) {
	// perform UDP checksum test, returns zero on success
	int rc;
	rc = udpchecksum((void *)ip_hdr, (void *)udp_hdr, udplen, (isIPV6(mSettings) ? 1 : 0));
	if (rc) {
	    reportstruct->l2errors |= L2CSUMERR;
	    if ((!(reportstruct->l2errors & L2LENERR)) && (L2_quintuple_filter() != 0)) {
		reportstruct->emptyreport = 1;
		reportstruct->l2errors |= L2UNKNOWN;
	    }
	}
    }
#endif // HAVE_AF_PACKET
}

// Run the L2 packet through a quintuple check, i.e. proto/ip src/ip dst/src port/src dst
// and return zero is there is a match, otherwize return nonzero
int Server::L2_quintuple_filter () {
#if defined(HAVE_LINUX_FILTER_H) && defined(HAVE_AF_PACKET)

#define IPV4SRCOFFSET 12  // the ipv4 source address offset from the l3 pdu
#define IPV6SRCOFFSET 8 // the ipv6 source address offset

    // Get the expected values from the sockaddr structures
    // Note: it's expected the initiating socket has aready "connected"
    // and the sockaddr structs have been populated
    // 2nd Note:  sockaddr structs are in network byte order
    struct sockaddr *p = reinterpret_cast<sockaddr *>(&mSettings->peer);
    struct sockaddr *l = reinterpret_cast<sockaddr *>(&mSettings->local);
    // make sure sa_family is coherent for both src and dst
    if (!(((l->sa_family == AF_INET) && (p->sa_family == AF_INET)) || ((l->sa_family == AF_INET6) && (p->sa_family == AF_INET6)))) {
	return -1;
    }

    // check the L2 ethertype
    struct ether_header *l2hdr = reinterpret_cast<struct ether_header *>(mSettings->mBuf);

    if (!isIPV6(mSettings)) {
	if (ntohs(l2hdr->ether_type) != ETHERTYPE_IP)
	    return -1;
    } else {
	if (ntohs(l2hdr->ether_type) != ETHERTYPE_IPV6)
	    return -1;
    }
    // check the ip src/dst
    const uint32_t *data;
    udp_hdr = reinterpret_cast<struct udphdr *>(mSettings->mBuf + mSettings->l4offset);

    // Check plain old v4 using v4 addr structs
    if (l->sa_family == AF_INET) {
	data = reinterpret_cast<const uint32_t *>(mSettings->mBuf + sizeof(struct ether_header) + IPV4SRCOFFSET);
	if ((reinterpret_cast<struct sockaddr_in *>(p))->sin_addr.s_addr != *data++)
	    return -1;
	if ((reinterpret_cast<struct sockaddr_in *>(l))->sin_addr.s_addr != *data)
	    return -1;
	if (udp_hdr->source != (reinterpret_cast<struct sockaddr_in *>(p))->sin_port)
	    return -1;
	if (udp_hdr->dest != (reinterpret_cast<struct sockaddr_in *>(l))->sin_port)
	    return -1;
    } else {
	// Using the v6 addr structures
#  if HAVE_IPV6
	struct in6_addr *v6peer = SockAddr_get_in6_addr(&mSettings->peer);
	struct in6_addr *v6local = SockAddr_get_in6_addr(&mSettings->local);
	if (isIPV6(mSettings)) {
	    int i;
	    data = reinterpret_cast<const uint32_t *>(mSettings->mBuf + sizeof(struct ether_header) + IPV6SRCOFFSET);
	    // check for v6 src/dst address match
	    for (i = 0; i < 4; i++) {
		if (v6peer->s6_addr32[i] != *data++)
		    return -1;
	    }
	    for (i = 0; i < 4; i++) {
		if (v6local->s6_addr32[i] != *data++)
		    return -1;
	    }
	} else { // v4 addr in v6 family struct
	    data = reinterpret_cast<const uint32_t *>(mSettings->mBuf + sizeof(struct ether_header) + IPV4SRCOFFSET);
	    if (v6peer->s6_addr32[3] != *data++)
		return -1;
	    if (v6peer->s6_addr32[3] != *data)
		return -1;
	}
	// check udp ports
	if (udp_hdr->source != (reinterpret_cast<struct sockaddr_in6 *>(p))->sin6_port)
	    return -1;
	if (udp_hdr->dest != (reinterpret_cast<struct sockaddr_in6 *>(l))->sin6_port)
	    return -1;
#  endif // HAVE_IPV6
    }
#endif // HAVE_AF_PACKET
    // made it through all the checks
    return 0;
}

inline void Server::udp_isoch_processing (int rxlen) {
    reportstruct->transit_ready = 0;
    // Ignore runt sized isoch packets
    if (rxlen < static_cast<int>(sizeof(struct UDP_datagram) +  sizeof(struct client_hdr_v1) + sizeof(struct client_hdrext) + sizeof(struct isoch_payload))) {
	reportstruct->burstsize = 0;
	reportstruct->remaining = 0;
	reportstruct->frameID = 0;
    } else {
	struct client_udp_testhdr *udp_pkt = reinterpret_cast<struct client_udp_testhdr *>(mSettings->mBuf);
	reportstruct->isochStartTime.tv_sec = ntohl(udp_pkt->isoch.start_tv_sec);
	reportstruct->isochStartTime.tv_usec = ntohl(udp_pkt->isoch.start_tv_usec);
	reportstruct->frameID = ntohl(udp_pkt->isoch.frameid);
	reportstruct->prevframeID = ntohl(udp_pkt->isoch.prevframeid);
	reportstruct->burstsize = ntohl(udp_pkt->isoch.burstsize);
	assert(reportstruct->burstsize > 0);
	reportstruct->burstperiod = ntohl(udp_pkt->isoch.burstperiod);
	reportstruct->remaining = ntohl(udp_pkt->isoch.remaining);
	if ((reportstruct->remaining == rxlen) && ((reportstruct->frameID - reportstruct->prevframeID) == 1)) {
	    reportstruct->transit_ready = 1;
	}
    }
}

/* -------------------------------------------------------------------
 * Receive UDP data from the (connected) socket.
 * Sends termination flag several times at the end.
 * Does not close the socket.
 * ------------------------------------------------------------------- */
void Server::RunUDP () {
    int rxlen;
    bool isLastPacket = false;

    if (InitTrafficLoop()) {
        // Exit loop on three conditions
        // 1) Fatal read error
        // 2) Last packet of traffic flow sent by client
        // 3) -t timer expires
        while (InProgress() && !isLastPacket) {
	    // The emptyreport flag can be set
	    // by any of the packet processing routines
	    // If it's set the iperf reporter won't do
	    // bandwidth accounting, basically it's indicating
	    // that the reportstruct itself couldn't be
	    // completely filled out.
	    reportstruct->emptyreport=1;
	    reportstruct->packetLen=0;
	    // read the next packet with timestamp
	    // will also set empty report or not
	    rxlen=ReadWithRxTimestamp();
	    if (!peerclose && (rxlen > 0)) {
	        reportstruct->emptyreport = 0;
	        reportstruct->packetLen = rxlen;
	        if (isL2LengthCheck(mSettings)) {
	            reportstruct->l2len = rxlen;
	            // L2 processing will set the reportstruct packet length with the length found in the udp header
	            // and also set the expected length in the report struct.  The reporter thread
	            // will do the compare and account and print l2 errors
	            reportstruct->l2errors = 0x0;
	            L2_processing();
	        }
	        if (!(reportstruct->l2errors & L2UNKNOWN)) {
	            // ReadPacketID returns true if this is the last UDP packet sent by the client
	            // also sets the packet rx time in the reportstruct
	            reportstruct->prevSentTime = myReport->info.ts.prevsendTime;
	            reportstruct->prevPacketTime = myReport->info.ts.prevpacketTime;
	            isLastPacket = ReadPacketID(mSettings->l4payloadoffset);
	            myReport->info.ts.prevsendTime = reportstruct->sentTime;
	            myReport->info.ts.prevpacketTime = reportstruct->packetTime;
	            if (isIsochronous(mSettings)) {
	                udp_isoch_processing(rxlen);
	            }
	        }
	    }
	    ReportPacket(myReport, reportstruct);
        }
    }
    disarm_itimer();
    int do_close = EndJob(myJob, reportstruct);
    if (!isMulticast(mSettings) && !isNoUDPfin(mSettings)) {
	// send a UDP acknowledgement back except when:
	// 1) we're NOT receiving multicast
	// 2) the user requested no final exchange
	// 3) this is a full duplex test
	write_UDP_AckFIN(&myReport->info, mSettings->mBufLen);
    }
    if (do_close) {
#if HAVE_THREAD_DEBUG
	thread_debug("udp close sock=%d", mySocket);
#endif
	int rc = close(mySocket);
	WARN_errno(rc == SOCKET_ERROR, "server close");
    }
    Iperf_remove_host(mSettings);
    FreeReport(myJob);
}

// end Recv
