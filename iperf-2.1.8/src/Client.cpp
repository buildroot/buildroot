/*---------------------------------------------------------------
 * Copyright (c) 1999,2000,2001,2002,2003
 * The Board ofraTrustees of the University of Illinois
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
 * Client.cpp
 * by Mark Gates <mgates@nlanr.net>
 * -------------------------------------------------------------------
 * A client thread initiates a connect to the server and handles
 * sending and receiving data, then closes the socket.
 * ------------------------------------------------------------------- */
#include <ctime>
#include <cmath>
#include "headers.h"
#include "Client.hpp"
#include "Thread.h"
#include "SocketAddr.h"
#include "PerfSocket.hpp"
#include "Extractor.h"
#include "delay.h"
#include "util.h"
#include "Locale.h"
#include "isochronous.hpp"
#include "pdfs.h"
#include "version.h"
#include "payloads.h"
#include "active_hosts.h"
#include "gettcpinfo.h"

// const double kSecs_to_usecs = 1e6;
const double kSecs_to_nsecs = 1e9;
const int    kBytes_to_Bits = 8;

#define VARYLOAD_PERIOD 0.1 // recompute the variable load every n seconds
#define MAXUDPBUF 1470

Client::Client (thread_Settings *inSettings) {
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Client constructor with thread %p sum=%p (flags=%x)", (void *) inSettings, (void *)inSettings->mSumReport, inSettings->flags);
#endif
    mSettings = inSettings;
    myJob = NULL;
    myReport = NULL;
    framecounter = NULL;
    one_report = false;
    udp_payload_minimum = 1;
    apply_first_udppkt_delay = false;

    memset(&scratchpad, 0, sizeof(struct ReportStruct));
    reportstruct = &scratchpad;
    reportstruct->packetID = 1;
    mySocket = isServerReverse(mSettings) ? mSettings->mSock : INVALID_SOCKET;
    connected = isServerReverse(mSettings);
    if (isCompat(mSettings) && isPeerVerDetect(mSettings)) {
	fprintf(stderr, "%s", warn_compat_and_peer_exchange);
	unsetPeerVerDetect(mSettings);
    }

    pattern(mSettings->mBuf, mSettings->mBufLen);
    if (isIsochronous(mSettings)) {
	FAIL_errno(!(mSettings->mFPS > 0.0), "Invalid value for frames per second in the isochronous settings\n", mSettings);
    }
    if (isFileInput(mSettings)) {
        if (!isSTDIN(mSettings))
            Extractor_Initialize(mSettings->mFileName, mSettings->mBufLen, mSettings);
        else
            Extractor_InitializeFile(stdin, mSettings->mBufLen, mSettings);

        if (!Extractor_canRead(mSettings)) {
            unsetFileInput(mSettings);
        }
    }
    peerclose = false;
    isburst = (isIsochronous(mSettings) || isPeriodicBurst(mSettings) || (isTripTime(mSettings) && !isUDP(mSettings)));
} // end Client

/* -------------------------------------------------------------------
 * Destructor
 * ------------------------------------------------------------------- */
Client::~Client () {
#if HAVE_THREAD_DEBUG
    thread_debug("Client destructor sock=%d report=%p server-reverse=%s fullduplex=%s", \
		 mySocket, (void *) mSettings->reporthdr, \
		 (isServerReverse(mSettings) ? "true" : "false"), (isFullDuplex(mSettings) ? "true" : "false"));
#endif
    DELETE_PTR(framecounter);
} // end ~Client


/* -------------------------------------------------------------------
 * Setup a socket connected to a server.
 * If inLocalhost is not null, bind to that address, specifying
 * which outgoing interface to use.
 * ------------------------------------------------------------------- */
bool Client::my_connect (bool close_on_fail) {
    int rc;
    // create an internet socket
    int type = (isUDP(mSettings) ? SOCK_DGRAM : SOCK_STREAM);
    int domain = (SockAddr_isIPv6(&mSettings->peer) ?
#if HAVE_IPV6
                  AF_INET6
#else
                  AF_INET
#endif
                  : AF_INET);

    mySocket = socket(domain, type, 0);
    WARN_errno(mySocket == INVALID_SOCKET, "socket");
    // Socket is carried both by the object and the thread
    mSettings->mSock=mySocket;
    SetSocketOptions(mSettings);
    SockAddr_localAddr(mSettings);
    SockAddr_remoteAddr(mSettings);
    if (mSettings->mLocalhost != NULL) {
        // bind socket to local address
        rc = bind(mySocket, reinterpret_cast<sockaddr*>(&mSettings->local),
		  SockAddr_get_sizeof_sockaddr(&mSettings->local));
        WARN_errno(rc == SOCKET_ERROR, "bind");
    }

    if (!isUDP(mSettings) && isReport(mSettings) && isSettingsReport(mSettings)) {
	struct ReportHeader *tmp = InitSettingsReport(mSettings);
	assert(tmp!=NULL);
	PostReport(tmp);
	setNoSettReport(mSettings);
    }

    // connect socket
    connected = false;
    mSettings->tcpinitstats.connecttime = -1;
    if (!isUDP(mSettings)) {
	int trycnt = mSettings->mConnectRetries + 1;
	while (trycnt > 0) {
	    connect_start.setnow();
	    rc = connect(mySocket, reinterpret_cast<sockaddr*>(&mSettings->peer),
			 SockAddr_get_sizeof_sockaddr(&mSettings->peer));
	    WARN_errno((rc == SOCKET_ERROR), "tcp connect");
	    if (rc == SOCKET_ERROR) {
		if ((--trycnt) <= 0) {
		    if (close_on_fail) {
			close(mySocket);
			mySocket = INVALID_SOCKET;
		    }
		} else {
		    delay_loop(200000);
		}
	    } else {
		connect_done.setnow();
		mSettings->tcpinitstats.connecttime = 1e3 * connect_done.subSec(connect_start);
		connected = true;
		break;
	    }
	}
    } else {
	rc = connect(mySocket, reinterpret_cast<sockaddr*>(&mSettings->peer),
		     SockAddr_get_sizeof_sockaddr(&mSettings->peer));
	mSettings->tcpinitstats.connecttime = 0.0; // UDP doesn't have a 3WHS
        WARN_errno((rc == SOCKET_ERROR), "udp connect");
	if (rc != SOCKET_ERROR)
	    connected = true;
    }
    if (connected) {
#if HAVE_TCP_STATS
        assert(reportstruct);
	if (!isUDP(mSettings)) {
	    gettcpinfo(mySocket, &mSettings->tcpinitstats);
	}
#endif
	// Set the send timeout for the very first write which has the test exchange
	int sosndtimer = TESTEXCHANGETIMEOUT; // 4 sec in usecs
	SetSocketOptionsSendTimeout(mSettings, sosndtimer);
	getsockname(mySocket, reinterpret_cast<sockaddr*>(&mSettings->local), &mSettings->size_local);
	getpeername(mySocket, reinterpret_cast<sockaddr*>(&mSettings->peer), &mSettings->size_peer);
	SockAddr_Ifrname(mSettings);
#ifdef DEFAULT_PAYLOAD_LEN_PER_MTU_DISCOVERY
	if (isUDP(mSettings) && !isBuflenSet(mSettings)) {
	    checksock_max_udp_payload(mSettings);
	}
#endif
	if (isUDP(mSettings) && !isIsochronous(mSettings) && !isIPG(mSettings)) {
	    mSettings->mBurstIPG = get_delay_target() / 1e3; // this is being set for the settings report only
	}
	if (isReport(mSettings) && isSettingsReport(mSettings)) {
	    struct ReportHeader *tmp = InitSettingsReport(mSettings);
	    assert(tmp!=NULL);
	    PostReport(tmp);
	    setNoSettReport(mSettings);
	}
    } else {
	if (mySocket != INVALID_SOCKET) {
	    int rc = close(mySocket);
	    WARN_errno(rc == SOCKET_ERROR, "client connect close");
	    mySocket = INVALID_SOCKET;
	}
    }
    // Post the connect report unless peer version exchange is set
    if (isConnectionReport(mSettings) && !isSumOnly(mSettings)) {
	if (connected) {
	    struct ReportHeader *reporthdr = InitConnectionReport(mSettings);
	    struct ConnectionInfo *cr = static_cast<struct ConnectionInfo *>(reporthdr->this_report);
	    cr->connect_timestamp.tv_sec = connect_start.getSecs();
	    cr->connect_timestamp.tv_usec = connect_start.getUsecs();
	    assert(reporthdr);
	    PostReport(reporthdr);
	} else {
	    PostReport(InitConnectionReport(mSettings));
	}
    }
    return connected;
} // end Connect

bool Client::isConnected () const {
#ifdef HAVE_THREAD_DEBUG
  // thread_debug("Client is connected %d", connected);
#endif
    return connected;
}

void Client::TxDelay () {
    if (isTxHoldback(mSettings)) {
	clock_usleep(&mSettings->txholdback_timer);
    }
}

inline void Client::myReportPacket (void) {
    ReportPacket(myReport, reportstruct);
    reportstruct->packetLen = 0;
}


// There are multiple startup synchronizations, this code
// handles them all. The caller decides to apply them
// either before connect() or after connect() and before writes()
int Client::StartSynch () {
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Client start sync enterred");
#endif

    myJob = InitIndividualReport(mSettings);
    myReport = static_cast<struct ReporterData *>(myJob->this_report);
    myReport->info.common->socket=mySocket;
    myReport->info.isEnableTcpInfo = false; // default here, set in init traffic actions

    // Perform delays, usually between connect() and data xfer though before connect
    // Two delays are supported:
    // o First is an absolute start time per unix epoch format
    // o Second is a holdback, a relative amount of seconds between the connect and data xfers
    // check for an epoch based start time
    reportstruct->packetLen = 0;
    if (!isServerReverse(mSettings)) {
	if (!isCompat(mSettings) && !isBounceBack(mSettings)) {
	    reportstruct->packetLen = SendFirstPayload();
	    // Reverse UDP tests need to retry "first sends" a few times
	    // before going to server or read mode
	    if (isReverse(mSettings) && isUDP(mSettings)) {
		reportstruct->packetLen = 0;
		fd_set set;
		struct timeval timeout;
		int resend_udp = 100;
		while (--resend_udp > 0) {
		    FD_ZERO(&set);
		    FD_SET(mySocket, &set);
		    timeout.tv_sec = 0;
		    timeout.tv_usec = rand() % 20000; // randomize IPG a bit
		    if (select(mySocket + 1, &set, NULL, NULL, &timeout) == 0) {
			reportstruct->packetLen = SendFirstPayload();
			// printf("**** resend sock=%d count=%d\n", mySocket, resend_udp);
		    } else {
			break;
		    }
		}
	    }
	}
	if (isTxStartTime(mSettings)) {
	    clock_usleep_abstime(&mSettings->txstart_epoch);
	} else if (isTxHoldback(mSettings)) {
	    TxDelay();
	}
	// Server side client
    } else if (isTripTime(mSettings) || isPeriodicBurst(mSettings)) {
	reportstruct->packetLen = SendFirstPayload();
    }
    if (isIsochronous(mSettings) || isPeriodicBurst(mSettings)) {
        Timestamp tmp;
        tmp.set(mSettings->txstart_epoch.tv_sec, mSettings->txstart_epoch.tv_usec);
        framecounter = new Isochronous::FrameCounter(mSettings->mFPS, tmp);
	// set the mbuf valid for burst period ahead of time. The same value will be set for all burst writes
	if (!isUDP(mSettings) && framecounter) {
	    struct TCP_burst_payload * mBuf_burst = reinterpret_cast<struct TCP_burst_payload *>(mSettings->mBuf);
	    mBuf_burst->burst_period_us  = htonl(framecounter->period_us());
	}
    }
    int setfullduplexflag = 0;
    if (isFullDuplex(mSettings) && !isServerReverse(mSettings)) {
	assert(mSettings->mFullDuplexReport != NULL);
	if ((setfullduplexflag = fullduplex_start_barrier(&mSettings->mFullDuplexReport->fullduplex_barrier)) < 0)
	    return -1;
    }
    SetReportStartTime();
#if HAVE_TCP_STATS
    if (!isUDP(mSettings)) {
	// Near congestion and peridiodic need sampling on every report packet
	if (isNearCongest(mSettings) || isPeriodicBurst(mSettings)) {
	    myReport->info.isEnableTcpInfo = true;
	    myReport->info.ts.nextTCPSampleTime.tv_sec = 0;
	    myReport->info.ts.nextTCPSampleTime.tv_usec = 0;
	} else if (isEnhanced(mSettings) || isBounceBack(mSettings)) {
	    myReport->info.isEnableTcpInfo = true;
	    myReport->info.ts.nextTCPSampleTime = myReport->info.ts.nextTime;
	}
    }
#endif

    if (reportstruct->packetLen > 0) {
	reportstruct->packetTime = myReport->info.ts.startTime;
	reportstruct->sentTime = reportstruct->packetTime;
	reportstruct->prevSentTime = reportstruct->packetTime;
	reportstruct->prevPacketTime = myReport->info.ts.prevpacketTime;
	if (isModeAmount(mSettings)) {
	    mSettings->mAmount -= reportstruct->packetLen;
	}
	myReportPacket();
	myReport->info.ts.prevpacketTime = reportstruct->packetTime;
	reportstruct->packetID++;
    }
    if (setfullduplexflag) {
	SetFullDuplexReportStartTime();
    }
    // Full duplex sockets need to be syncronized
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Client start sync exited");
#endif
    return 0;
}

inline void Client::SetFullDuplexReportStartTime () {
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
    thread_debug("Client fullduplex report start=%ld.%ld next=%ld.%ld", fullduplexstats->ts.startTime.tv_sec, fullduplexstats->ts.startTime.tv_usec, fullduplexstats->ts.nextTime.tv_sec, fullduplexstats->ts.nextTime.tv_usec);
#endif
}
inline void Client::SetReportStartTime () {
    assert(myReport!=NULL);
    now.setnow();
    myReport->info.ts.startTime.tv_sec = now.getSecs();
    myReport->info.ts.startTime.tv_usec = now.getUsecs();
    myReport->info.ts.IPGstart = myReport->info.ts.startTime;
    myReport->info.ts.prevpacketTime = myReport->info.ts.startTime;
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
#ifdef HAVE_THREAD_DEBUG
	    thread_debug("Client group sum report start=%ld.%ld next=%ld.%ld", sumstats->ts.startTime.tv_sec, sumstats->ts.startTime.tv_usec, sumstats->ts.nextTime.tv_sec, sumstats->ts.nextTime.tv_usec);
#endif
	}
	Mutex_Unlock(&myReport->GroupSumReport->reference.lock);
    }
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Client(%d) report start/ipg=%ld.%ld next=%ld.%ld", mSettings->mSock, myReport->info.ts.startTime.tv_sec, myReport->info.ts.startTime.tv_usec, myReport->info.ts.nextTime.tv_sec, myReport->info.ts.nextTime.tv_usec);
#endif
}

void Client::ConnectPeriodic () {
    Timestamp end;
    Timestamp next;
    unsigned int amount_usec = 1000000;
    if (isModeTime(mSettings)) {
	amount_usec = (mSettings->mAmount * 10000);
	end.add(amount_usec); // add in micro seconds
    }
    setNoConnectSync(mSettings);
    int num_connects = -1;
    if (!(mSettings->mInterval > 0)) {
	if (mSettings->connectonly_count < 0)
	    num_connects = 10;
	else if (mSettings->connectonly_count > 0)
	    num_connects = mSettings->connectonly_count;
    }

    do {
	if (my_connect(false)){
	    int rc = close(mySocket);
	    WARN_errno(rc == SOCKET_ERROR, "client close");
	    mySocket = INVALID_SOCKET;
	}
	if (mSettings->mInterval > 0) {
	    now.setnow();
	    do {
		next.add(mSettings->mInterval);
	    } while (next.before(now));
	    if (next.before(end)) {
		struct timeval tmp;
		tmp.tv_sec = next.getSecs();
		tmp.tv_usec = next.getUsecs();
		clock_usleep_abstime(&tmp);
	    }
	}
	if (num_connects > 0) {
	    --num_connects;
	}
    } while (num_connects && !sInterupted && (next.before(end) || (isModeTime(mSettings) && !(mSettings->mInterval > 0))));
}
/* -------------------------------------------------------------------
 * Common traffic loop intializations
 * ------------------------------------------------------------------- */
void Client::InitTrafficLoop () {
    //  Enable socket write timeouts for responsive reporting
    //  Do this after the connection establishment
    //  and after Client::InitiateServer as during these
    //  default socket timeouts are preferred.
    int sosndtimer = 0;
    // sosndtimer units microseconds
    // mInterval units are microseconds, mAmount units is 10 ms
    // SetSocketOptionsSendTimeout takes microseconds
    // Set the timeout value to 1/2 the interval (per -i) or 1/2 the -t value
    if (isPeriodicBurst(mSettings) && (mSettings->mFPS > 0.0)) {
	sosndtimer = static_cast<int>(round(250000.0 / mSettings->mFPS));
    } else if (mSettings->mInterval > 0) {
        sosndtimer = static_cast<int>(round(0.5 * mSettings->mInterval));
    } else {
	sosndtimer = static_cast<int>(mSettings->mAmount * 5e3);
    }
    SetSocketOptionsSendTimeout(mSettings, sosndtimer);
    // set the lower bounds delay based of the socket timeout timer
    // units needs to be in nanoseconds
    delay_lower_bounds = static_cast<double>(sosndtimer) * -1e3;

    if (isIsochronous(mSettings))
	myReport->info.matchframeID = 1;

    // set the total bytes sent to zero
    totLen = 0;
    if (isModeTime(mSettings)) {
        mEndTime.setnow();
        mEndTime.add(mSettings->mAmount / 100.0);
	// now.setnow(); fprintf(stderr, "DEBUG: end time set to %ld.%ld now is %ld.%ld\n", mEndTime.getSecs(), mEndTime.getUsecs(), now.getSecs(), now.getUsecs());
    }
    readAt = mSettings->mBuf;
    lastPacketTime.set(myReport->info.ts.startTime.tv_sec, myReport->info.ts.startTime.tv_usec);
    reportstruct->errwrite=WriteNoErr;
    reportstruct->emptyreport=0;
    reportstruct->packetLen = 0;
    // Finally, post this thread's "job report" which the reporter thread
    // will continuously process as long as there are packets flowing
    // right now the ring is empty
    if (!isReverse(mSettings) && !isSingleUDP(mSettings) && isDataReport(mSettings)) {
        assert(myJob!=NULL);
        assert(myReport!=NULL);
        PostReport(myJob);
    }
    one_report = (!isUDP(mSettings) && !isEnhanced(mSettings) && (mSettings->mIntervalMode != kInterval_Time) \
		   && !isIsochronous(mSettings) && !isPeriodicBurst(mSettings) && !isTripTime(mSettings) && !isReverse(mSettings));
}

/* -------------------------------------------------------------------
 * Run the appropriate send loop between
 *
 * 1) TCP without rate limiting
 * 2) TCP with rate limiting
 * 3) UDP
 * 4) UDP isochronous w/vbr
 *
 * ------------------------------------------------------------------- */
void Client::Run () {
    // Initialize the report struct scratch pad
    // Peform common traffic setup
    InitTrafficLoop();
    /*
     * UDP
     */
    if (isUDP(mSettings)) {
	if (isFileInput(mSettings)) {
	    // Due to the UDP timestamps etc, included
	    // reduce the read size by an amount
	    // equal to the header size
	    Extractor_reduceReadSize(sizeof(struct UDP_datagram), mSettings);
	    readAt += sizeof(struct UDP_datagram);
	}
	// Launch the approprate UDP traffic loop
	if (isIsochronous(mSettings)) {
	    RunUDPIsochronous();
	} else {
	    RunUDP();
	}
    } else {
	// Launch the approprate TCP traffic loop
	if (isBounceBack(mSettings)) {
	    RunBounceBackTCP();
	} else if (mSettings->mAppRate > 0) {
	    RunRateLimitedTCP();
	} else if (isNearCongest(mSettings)) {
	    RunNearCongestionTCP();
#if HAVE_DECL_TCP_NOTSENT_LOWAT
	} else if (isWritePrefetch(mSettings) && \
		   !isIsochronous(mSettings) && !isPeriodicBurst(mSettings)) {
	    RunWriteEventsTCP();
#endif
	} else {
	    RunTCP();
	}
    }
}

/*
 * TCP send loop
 */
void Client::RunTCP () {
    int burst_remaining = 0;
    uint32_t burst_id = 1;
    int writelen = mSettings->mBufLen;

    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    reportstruct->write_time = 0;
    while (InProgress()) {
	reportstruct->writecnt = 0;
        if (isModeAmount(mSettings)) {
	    writelen = ((mSettings->mAmount < static_cast<unsigned>(mSettings->mBufLen)) ? mSettings->mAmount : mSettings->mBufLen);
	}
	if (isburst && !(burst_remaining > 0)) {
	    if (isIsochronous(mSettings)) {
		assert(mSettings->mMean);
		burst_remaining = static_cast<int>(lognormal(mSettings->mMean,mSettings->mVariance)) / (mSettings->mFPS * 8);
	    } else if (isPeriodicBurst(mSettings)){
		assert(mSettings->mBurstSize);
		burst_remaining = mSettings->mBurstSize;
	    } else {
		burst_remaining = mSettings->mBufLen;
	    }
	    // check for TCP minimum payload
	    if (burst_remaining < static_cast<int>(sizeof(struct TCP_burst_payload)))
		burst_remaining = static_cast<int>(sizeof(struct TCP_burst_payload));
	    // apply scheduling if needed
	    if (framecounter) {
		burst_id = framecounter->wait_tick();
		if (isPeriodicBurst(mSettings)) {
		    // low duty cycle traffic needs special event handling
		    now.setnow();
		    myReport->info.ts.prevsendTime = reportstruct->packetTime;
		    reportstruct->packetTime.tv_sec = now.getSecs();
		    reportstruct->packetTime.tv_usec = now.getUsecs();
		    if (!InProgress()) {
			reportstruct->packetLen = 0;
			reportstruct->emptyreport = 1;
			// wait may have crossed the termination boundry
			break;
		    } else {
			//time interval crossings may have occurred during the wait
			//post a null event to cause the report to flush the packet ring
			PostNullEvent();
		    }
		}
#if HAVE_DECL_TCP_NOTSENT_LOWAT
		if (isWritePrefetch(mSettings)) {
		    AwaitWriteSelectEventTCP();
		}
#endif
	    }
	    now.setnow();
	    reportstruct->packetTime.tv_sec = now.getSecs();
	    reportstruct->packetTime.tv_usec = now.getUsecs();
	    WriteTcpTxHdr(reportstruct, burst_remaining, burst_id++);
	    reportstruct->sentTime = reportstruct->packetTime;
	    myReport->info.ts.prevsendTime = reportstruct->packetTime;
	    writelen = (mSettings->mBufLen > burst_remaining) ? burst_remaining : mSettings->mBufLen;
	    // perform write, full header must succeed
	    if (isTcpWriteTimes(mSettings)) {
		write_start.setnow();
	    }
	    reportstruct->packetLen = writen(mySocket, mSettings->mBuf, writelen, &reportstruct->writecnt);
	    FAIL_errno(reportstruct->packetLen < (intmax_t) sizeof(struct TCP_burst_payload), "burst written", mSettings);
	    if (isTcpWriteTimes(mSettings)) {
		now.setnow();
		reportstruct->write_time = now.subUsec(write_start);
	    }
	} else {
	    // printf("pl=%ld\n",reportstruct->packetLen);
	    // perform write
	    if (isburst)
		writelen = (mSettings->mBufLen > burst_remaining) ? burst_remaining : mSettings->mBufLen;
	    if (isTcpWriteTimes(mSettings)) {
		write_start.setnow();
	    }
#if HAVE_DECL_TCP_NOTSENT_LOWAT
	    if (isWritePrefetch(mSettings)) {
		AwaitWriteSelectEventTCP();
	    }
#endif
	    reportstruct->packetLen = write(mySocket, mSettings->mBuf, writelen);
	    now.setnow();
	    reportstruct->writecnt++;
	    reportstruct->packetTime.tv_sec = now.getSecs();
	    reportstruct->packetTime.tv_usec = now.getUsecs();
	    if (isTcpWriteTimes(mSettings)) {
		reportstruct->write_time = now.subUsec(write_start);
	    }
	    reportstruct->sentTime = reportstruct->packetTime;
	}
	if (reportstruct->packetLen <= 0) {
	    if (reportstruct->packetLen == 0) {
		peerclose = true;
	    } else if (NONFATALTCPWRITERR(errno)) {
		reportstruct->errwrite=WriteErrAccount;
	    } else if (FATALTCPWRITERR(errno)) {
		reportstruct->errwrite=WriteErrFatal;
		WARN_errno(1, "tcp write");
		break;
	    } else {
		reportstruct->errwrite=WriteErrNoAccount;
	    }
	    reportstruct->packetLen = 0;
	    reportstruct->emptyreport = 1;
	} else {
	    reportstruct->emptyreport = 0;
	    totLen += reportstruct->packetLen;
	    reportstruct->errwrite=WriteNoErr;
	    if (isburst) {
		burst_remaining -= reportstruct->packetLen;
		if (burst_remaining > 0) {
		    reportstruct->transit_ready = 0;
		} else {
		    reportstruct->transit_ready = 1;
		    reportstruct->prevSentTime = myReport->info.ts.prevsendTime;
		}
	    }
	}
	if (isModeAmount(mSettings) && !reportstruct->emptyreport) {
	    /* mAmount may be unsigned, so don't let it underflow! */
	    if (mSettings->mAmount >= static_cast<unsigned long>(reportstruct->packetLen)) {
		mSettings->mAmount -= static_cast<unsigned long>(reportstruct->packetLen);
	    } else {
		mSettings->mAmount = 0;
	    }
	}
	if (!one_report) {
	    myReportPacket();
	}
    }
    FinishTrafficActions();
}

/*
 * TCP send loop
 */
void Client::RunNearCongestionTCP () {
    int burst_remaining = 0;
    int burst_id = 1;
    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    while (InProgress()) {
	reportstruct->writecnt = 0;
        if (isModeAmount(mSettings)) {
	    reportstruct->packetLen = ((mSettings->mAmount < static_cast<unsigned>(mSettings->mBufLen)) ? mSettings->mAmount : mSettings->mBufLen);
	} else {
	    reportstruct->packetLen = mSettings->mBufLen;
	}
	if (!burst_remaining) {
	    burst_remaining = mSettings->mBufLen;
	    // mAmount check
	    now.setnow();
	    reportstruct->packetTime.tv_sec = now.getSecs();
	    reportstruct->packetTime.tv_usec = now.getUsecs();
	    WriteTcpTxHdr(reportstruct, burst_remaining, burst_id++);
	    reportstruct->sentTime = reportstruct->packetTime;
	    myReport->info.ts.prevsendTime = reportstruct->packetTime;
	    // perform write
	    int writelen = (mSettings->mBufLen > burst_remaining) ? burst_remaining : mSettings->mBufLen;
	    reportstruct->packetLen = write(mySocket, mSettings->mBuf, writelen);
	    reportstruct->writecnt++;
	    assert(reportstruct->packetLen >= (intmax_t) sizeof(struct TCP_burst_payload));
	    goto ReportNow;
	}
	if (reportstruct->packetLen > burst_remaining) {
	    reportstruct->packetLen = burst_remaining;
	}
	// printf("pl=%ld\n",reportstruct->packetLen);
	// perform write
	reportstruct->packetLen = write(mySocket, mSettings->mBuf, reportstruct->packetLen);
	now.setnow();
	reportstruct->writecnt++;
	reportstruct->packetTime.tv_sec = now.getSecs();
	reportstruct->packetTime.tv_usec = now.getUsecs();
	reportstruct->sentTime = reportstruct->packetTime;
      ReportNow:
	reportstruct->transit_ready = 0;
	if (reportstruct->packetLen < 0) {
	    if (NONFATALTCPWRITERR(errno)) {
		reportstruct->errwrite=WriteErrAccount;
	    } else if (FATALTCPWRITERR(errno)) {
		reportstruct->errwrite=WriteErrFatal;
		WARN_errno(1, "tcp write");
		break;
	    } else {
		reportstruct->errwrite=WriteErrNoAccount;
	    }
	    reportstruct->packetLen = 0;
	    reportstruct->emptyreport = 1;
	} else {
	    reportstruct->emptyreport = 0;
	    totLen += reportstruct->packetLen;
	    reportstruct->errwrite=WriteNoErr;
	    burst_remaining -= reportstruct->packetLen;
	    if (burst_remaining <= 0) {
		reportstruct->transit_ready = 1;
	    }
	}
	if (isModeAmount(mSettings) && !reportstruct->emptyreport) {
	    /* mAmount may be unsigned, so don't let it underflow! */
	    if (mSettings->mAmount >= static_cast<unsigned long>(reportstruct->packetLen)) {
		mSettings->mAmount -= static_cast<unsigned long>(reportstruct->packetLen);
	    } else {
		mSettings->mAmount = 0;
	    }
	}
	// apply placing after write burst completes
	if (reportstruct->transit_ready) {
	    myReportPacket(); // this will set the tcpstats in the report struct
	    // pacing timer is weighted by the RTT (set to 1 when RTT is not supported)
	    int pacing_timer = 0;
#if HAVE_TCP_STATS
	    pacing_timer = static_cast<int>(std::ceil(static_cast<double>(reportstruct->tcpstats.rtt) * mSettings->rtt_nearcongest_weight_factor));
#else
	    pacing_timer = static_cast<int>(100 * mSettings->rtt_nearcongest_weight_factor);
#endif
	    if (pacing_timer)
		delay_loop(pacing_timer);
	}
    }
    FinishTrafficActions();
}

/*
 * A version of the transmit loop that supports TCP rate limiting using a token bucket
 */
void Client::RunRateLimitedTCP () {
    double tokens = 0;
    Timestamp time1, time2;
    int burst_size = mSettings->mBufLen;
    int burst_remaining = 0;
    int burst_id = 1;

    long var_rate = mSettings->mAppRate;
    int fatalwrite_err = 0;

    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    while (InProgress() && !fatalwrite_err) {
	reportstruct->writecnt = 0;
	// Add tokens per the loop time
	time2.setnow();
        if (isVaryLoad(mSettings)) {
	    static Timestamp time3;
	    if (time2.subSec(time3) >= VARYLOAD_PERIOD) {
		var_rate = lognormal(mSettings->mAppRate,mSettings->mVariance);
		time3 = time2;
		if (var_rate < 0)
		    var_rate = 0;
	    }
	}
	tokens += time2.subSec(time1) * (var_rate / 8.0);
	time1 = time2;
	if (tokens >= 0.0) {
	    if (isModeAmount(mSettings)) {
	        reportstruct->packetLen = ((mSettings->mAmount < static_cast<unsigned>(mSettings->mBufLen)) ? mSettings->mAmount : mSettings->mBufLen);
	    } else {
	        reportstruct->packetLen = mSettings->mBufLen;
	    }
	    // perform write
	    int n = 0;
	    if (isTripTime(mSettings)) {
		if (burst_remaining == 0) {
		    now.setnow();
		    reportstruct->packetTime.tv_sec = now.getSecs();
		    reportstruct->packetTime.tv_usec = now.getUsecs();
		    WriteTcpTxHdr(reportstruct, burst_size, burst_id++);
		    reportstruct->sentTime = reportstruct->packetTime;
		    burst_remaining = burst_size;
		    // perform write
		    n = writen(mySocket, mSettings->mBuf, sizeof(struct TCP_burst_payload), &reportstruct->writecnt);
		    WARN(n != sizeof(struct TCP_burst_payload), "burst hdr write failed");
		    burst_remaining -= n;
		    reportstruct->packetLen -= n;
		    // thread_debug("***write burst header %d id=%d", burst_size, (burst_id - 1));
		} else if (reportstruct->packetLen > burst_remaining) {
		    reportstruct->packetLen = burst_remaining;
		}
	    }
	    int len = write(mySocket, mSettings->mBuf, reportstruct->packetLen);
	    reportstruct->writecnt++;
	    if (len < 0) {
	        if (NONFATALTCPWRITERR(errno)) {
		    reportstruct->errwrite=WriteErrAccount;
		} else if (FATALTCPWRITERR(errno)) {
		    reportstruct->errwrite=WriteErrFatal;
		    WARN_errno(1, "write");
		    fatalwrite_err = 1;
		    break;
		} else {
		    reportstruct->errwrite=WriteErrNoAccount;
	        }
		len = 0;
	    } else {
		// Consume tokens per the transmit
	        tokens -= (len + n);
	        totLen += (len + n);;
		reportstruct->errwrite=WriteNoErr;
	    }
	    if (isTripTime(mSettings))
		burst_remaining -= len;

	    time2.setnow();
	    reportstruct->packetLen = len + n;
	    reportstruct->packetTime.tv_sec = time2.getSecs();
	    reportstruct->packetTime.tv_usec = time2.getUsecs();
	    reportstruct->sentTime = reportstruct->packetTime;
	    if (isModeAmount(mSettings)) {
		/* mAmount may be unsigned, so don't let it underflow! */
		if (mSettings->mAmount >= static_cast<unsigned long>(reportstruct->packetLen)) {
		    mSettings->mAmount -= static_cast<unsigned long>(reportstruct->packetLen);
		} else {
		    mSettings->mAmount = 0;
		}
	    }
	    if (!one_report) {
		myReportPacket();
	    }
        } else {
	    // Use a 4 usec delay to fill tokens
	    delay_loop(4);
	}
    }
    FinishTrafficActions();
}

#if HAVE_DECL_TCP_NOTSENT_LOWAT
inline bool Client::AwaitWriteSelectEventTCP (void) {
    int rc;
    struct timeval timeout;
    fd_set writeset;
    FD_ZERO(&writeset);
    FD_SET(mySocket, &writeset);
    if (isModeTime(mSettings)) {
        Timestamp write_event_timeout(0,0);
	if (mSettings->mInterval && (mSettings->mIntervalMode == kInterval_Time)) {
	    write_event_timeout.add((double) mSettings->mInterval / 1e6 * 2.0);
	} else {
	    write_event_timeout.add((double) mSettings->mAmount / 1e2 * 4.0);
	}
	timeout.tv_sec = write_event_timeout.getSecs();
        timeout.tv_usec = write_event_timeout.getUsecs();
    } else {
	timeout.tv_sec = 10; // longest is 10 seconds
	timeout.tv_usec = 0;
    }

    if ((rc = select(mySocket + 1, NULL, &writeset, NULL, &timeout)) <= 0) {
	WARN_errno((rc < 0), "select");
#ifdef HAVE_THREAD_DEBUG
	if (rc == 0)
	    thread_debug("AwaitWrite timeout");
#endif
	return false;
    }
    return true;
}

void Client::RunWriteEventsTCP () {
    int burst_id = 0;
    int writelen = mSettings->mBufLen;
    Timestamp write_end;

    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    while (InProgress()) {
        if (isModeAmount(mSettings)) {
	    writelen = ((mSettings->mAmount < static_cast<unsigned>(mSettings->mBufLen)) ? mSettings->mAmount : mSettings->mBufLen);
	}
	now.setnow();
	reportstruct->write_time = 0;
	if (isTcpWriteTimes(mSettings)) {
	    write_start = now;
	}
	bool rc = AwaitWriteSelectEventTCP();
	reportstruct->emptyreport = (rc == false) ? 1 : 0;
        if (rc) {
	    now.setnow();
	    reportstruct->packetTime.tv_sec = now.getSecs();
	    reportstruct->packetTime.tv_usec = now.getUsecs();
	    WriteTcpTxHdr(reportstruct, writelen, ++burst_id);
	    reportstruct->sentTime = reportstruct->packetTime;
	    reportstruct->packetLen = writen(mySocket, mSettings->mBuf, writelen, &reportstruct->writecnt);
	    if (reportstruct->packetLen <= 0) {
		WARN_errno((reportstruct->packetLen < 0), "event writen()");
		if (reportstruct->packetLen == 0) {
		    peerclose = true;
		}
		reportstruct->packetLen = 0;
		reportstruct->emptyreport = 1;
	    } else if (isTcpWriteTimes(mSettings)) {
		write_end.setnow();
		reportstruct->write_time = write_end.subUsec(write_start);
	    }
	}
	if (isModeAmount(mSettings) && !reportstruct->emptyreport) {
	    /* mAmount may be unsigned, so don't let it underflow! */
	    if (mSettings->mAmount >= static_cast<unsigned long>(reportstruct->packetLen)) {
		mSettings->mAmount -= static_cast<unsigned long>(reportstruct->packetLen);
	    } else {
		mSettings->mAmount = 0;
	    }
	}
	if (!one_report) {
	    myReportPacket();
	}
    }
    FinishTrafficActions();
}
#endif
void Client::RunBounceBackTCP () {
    int burst_id = 0;
    int writelen = mSettings->mBufLen;
    memset(mSettings->mBuf, 0x5A, sizeof(struct bounceback_hdr));
    if (mSettings->mInterval && (mSettings->mIntervalMode == kInterval_Time)) {
	int sotimer = static_cast<int>(round(mSettings->mInterval / 2.0));
	SetSocketOptionsReceiveTimeout(mSettings, sotimer);
	SetSocketOptionsSendTimeout(mSettings, sotimer);
    } else if (isModeTime(mSettings)) {
	int sotimer = static_cast<int>(round(mSettings->mAmount * 10000) / 2);
	SetSocketOptionsReceiveTimeout(mSettings, sotimer);
	SetSocketOptionsSendTimeout(mSettings, sotimer);
    }
    if (isModeTime(mSettings)) {
	int end_usecs = (mSettings->mAmount * 10000);
	if (int err = set_itimer(end_usecs)) {
	    FAIL_errno(err != 0, "setitimer", mSettings);
	}
    }
    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    while (InProgress()) {
	int n;
	reportstruct->writecnt = 0;
	bool isFirst;
	if (framecounter) {
	    burst_id = framecounter->wait_tick();
	    PostNullEvent(); // this will set the now timestamp
	    reportstruct->sentTime.tv_sec = now.getSecs();
	    reportstruct->sentTime.tv_usec = now.getUsecs();
	    isFirst = true;
	} else {
	    burst_id++;
	    isFirst = false;
	}
	int bb_burst = (mSettings->mBounceBackBurst > 0) ? mSettings->mBounceBackBurst : 1;
	while (bb_burst > 0) {
	    bb_burst--;
	    if (isFirst) {
		isFirst = false;
	    } else {
		now.setnow();
		reportstruct->sentTime.tv_sec = now.getSecs();
		reportstruct->sentTime.tv_usec = now.getUsecs();
	    }
	    WriteTcpTxBBHdr(reportstruct, burst_id, 0);
	    reportstruct->packetLen = writen(mySocket, mSettings->mBuf, writelen, &reportstruct->writecnt);
	    if (reportstruct->packetLen <= 0) {
		peerclose = true;
		reportstruct->errwrite=WriteErrFatal;
		// WARN_errno(1, "tcp bounce-back write");
		break;
	    }
	    if (reportstruct->packetLen == writelen) {
		reportstruct->emptyreport = 0;
		totLen += reportstruct->packetLen;
		reportstruct->errwrite=WriteNoErr;
#if HAVE_DECL_TCP_QUICKACK
		if (isTcpQuickAck(mSettings)) {
		    int opt = 1;
		    Socklen_t len = sizeof(opt);
		    int rc = setsockopt(mySocket, IPPROTO_TCP, TCP_QUICKACK,
					reinterpret_cast<char*>(&opt), len);
		    WARN_errno(rc == SOCKET_ERROR, "setsockopt TCP_QUICKACK");
		}
#endif
		if ((n = recvn(mySocket, mSettings->mBuf, mSettings->mBounceBackBytes, 0)) == mSettings->mBounceBackBytes) {
		    struct bounceback_hdr *bbhdr = reinterpret_cast<struct bounceback_hdr *>(mSettings->mBuf);
		    now.setnow();
		    reportstruct->sentTimeRX.tv_sec = ntohl(bbhdr->bbserverRx_ts.sec);
		    reportstruct->sentTimeRX.tv_usec = ntohl(bbhdr->bbserverRx_ts.usec);
		    reportstruct->sentTimeTX.tv_sec = ntohl(bbhdr->bbserverTx_ts.sec);
		    reportstruct->sentTimeTX.tv_usec = ntohl(bbhdr->bbserverTx_ts.usec);
		    reportstruct->packetTime.tv_sec = now.getSecs();
		    reportstruct->packetTime.tv_usec = now.getUsecs();
		    reportstruct->packetLen += n;
		    reportstruct->emptyreport = 0;
		    myReportPacket();
		} else if (n == 0) {
		    peerclose = true;
		} else {
		    FAIL_errno(1, "tcp bounce-back read", mSettings);
		}
	    } else if ((reportstruct->packetLen < 0 ) && NONFATALTCPWRITERR(errno)) {
		reportstruct->packetLen = 0;
		reportstruct->emptyreport = 1;
		reportstruct->errwrite=WriteErrNoAccount;
		myReportPacket();
	    } else {
		reportstruct->errwrite=WriteErrFatal;
		reportstruct->packetLen = -1;
		FAIL_errno(1, "tcp bounce-back write", mSettings);
	    }
	}
    }
    WriteTcpTxBBHdr(reportstruct, 0x0, 1);
    disarm_itimer();
    FinishTrafficActions();
}
/*
 * UDP send loop
 */
double Client::get_delay_target () {
    double delay_target;
    if (isIPG(mSettings)) {
	delay_target = mSettings->mBurstIPG * 1000000;  // convert from milliseconds to nanoseconds
    } else {
	// compute delay target in units of nanoseconds
	if (mSettings->mAppRateUnits == kRate_BW) {
	    // compute delay for bandwidth restriction, constrained to [0,1] seconds
	    delay_target = (mSettings->mBufLen * ((kSecs_to_nsecs * kBytes_to_Bits)
							   / mSettings->mAppRate));
	} else {
	    delay_target = 1e9 / mSettings->mAppRate;
	}
    }
    return delay_target;
}

void Client::RunUDP () {
    struct UDP_datagram* mBuf_UDP = reinterpret_cast<struct UDP_datagram*>(mSettings->mBuf);
    int currLen;

    double delay_target = get_delay_target();
    double delay = 0;
    double adjust = 0;

    // Set this to > 0 so first loop iteration will delay the IPG
    currLen = 1;
    double variance = mSettings->mVariance;
    if (apply_first_udppkt_delay && (delay_target > 100000)) {
	//the case when a UDP first packet went out in SendFirstPayload
	delay_loop(static_cast<unsigned long>(delay_target / 1000));
    }

    while (InProgress()) {
        // Test case: drop 17 packets and send 2 out-of-order:
        // sequence 51, 52, 70, 53, 54, 71, 72
        //switch(datagramID) {
        //  case 53: datagramID = 70; break;
        //  case 71: datagramID = 53; break;
        //  case 55: datagramID = 71; break;
        //  default: break;
        //}
	now.setnow();
	reportstruct->writecnt = 1;
	reportstruct->packetTime.tv_sec = now.getSecs();
	reportstruct->packetTime.tv_usec = now.getUsecs();
	reportstruct->sentTime = reportstruct->packetTime;
        if (isVaryLoad(mSettings) && mSettings->mAppRateUnits == kRate_BW) {
	    static Timestamp time3;
	    if (now.subSec(time3) >= VARYLOAD_PERIOD) {
		long var_rate = lognormal(mSettings->mAppRate,variance);
		if (var_rate < 0)
		    var_rate = 0;
		delay_target = (mSettings->mBufLen * ((kSecs_to_nsecs * kBytes_to_Bits) / var_rate));
		time3 = now;
	    }
	}
	// store datagram ID into buffer
	WritePacketID(reportstruct->packetID);
	mBuf_UDP->tv_sec  = htonl(reportstruct->packetTime.tv_sec);
	mBuf_UDP->tv_usec = htonl(reportstruct->packetTime.tv_usec);

	// Adjustment for the running delay
	// o measure how long the last loop iteration took
	// o calculate the delay adjust
	//   - If write succeeded, adjust = target IPG - the loop time
	//   - If write failed, adjust = the loop time
	// o then adjust the overall running delay
	// Note: adjust units are nanoseconds,
	//       packet timestamps are microseconds
	if (currLen > 0)
	    adjust = delay_target + \
		(1000.0 * lastPacketTime.subUsec(reportstruct->packetTime));
	else
	    adjust = 1000.0 * lastPacketTime.subUsec(reportstruct->packetTime);

	lastPacketTime.set(reportstruct->packetTime.tv_sec, reportstruct->packetTime.tv_usec);
	// Since linux nanosleep/busyloop can exceed delay
	// there are two possible equilibriums
	//  1)  Try to perserve inter packet gap
	//  2)  Try to perserve requested transmit rate
	// The latter seems preferred, hence use a running delay
	// that spans the life of the thread and constantly adjust.
	// A negative delay means the iperf app is behind.
	delay += adjust;
	// Don't let delay grow unbounded
	if (delay < delay_lower_bounds) {
	    delay = delay_target;
	}

	reportstruct->errwrite = WriteNoErr;
	reportstruct->emptyreport = 0;
	// perform write
	if (isModeAmount(mSettings)) {
	    currLen = write(mySocket, mSettings->mBuf, (mSettings->mAmount < static_cast<unsigned>(mSettings->mBufLen)) ? mSettings->mAmount : mSettings->mBufLen);
	} else {
	    currLen = write(mySocket, mSettings->mBuf, mSettings->mBufLen);
	}
	if (currLen < 0) {
	    reportstruct->packetID--;
	    if (FATALUDPWRITERR(errno)) {
	        reportstruct->errwrite = WriteErrFatal;
	        WARN_errno(1, "write");
		break;
	    } else {
	        reportstruct->errwrite = WriteErrAccount;
	        currLen = 0;
	    }
	    reportstruct->emptyreport = 1;
	}

	if (isModeAmount(mSettings)) {
	    /* mAmount may be unsigned, so don't let it underflow! */
	    if (mSettings->mAmount >= static_cast<unsigned long>(currLen)) {
	        mSettings->mAmount -= static_cast<unsigned long>(currLen);
	    } else {
	        mSettings->mAmount = 0;
	    }
	}

	// report packets
	reportstruct->packetLen = static_cast<unsigned long>(currLen);
	reportstruct->prevPacketTime = myReport->info.ts.prevpacketTime;
	myReportPacket();
	reportstruct->packetID++;
	myReport->info.ts.prevpacketTime = reportstruct->packetTime;
	// Insert delay here only if the running delay is greater than 100 usec,
	// otherwise don't delay and immediately continue with the next tx.
	if (delay >= 100000) {
	    // Convert from nanoseconds to microseconds
	    // and invoke the microsecond delay
	    delay_loop(static_cast<unsigned long>(delay / 1000));
	}
    }
    FinishTrafficActions();
}

/*
 * UDP isochronous send loop
 */
void Client::RunUDPIsochronous () {
    struct UDP_datagram* mBuf_UDP = reinterpret_cast<struct UDP_datagram*>(mSettings->mBuf);
    // skip over the UDP datagram (seq no, timestamp) to reach the isoch fields
    struct client_udp_testhdr *udp_payload = reinterpret_cast<client_udp_testhdr *>(mSettings->mBuf);

    double delay_target = mSettings->mBurstIPG * 1000000;  // convert from milliseconds to nanoseconds
    double delay = 0;
    double adjust = 0;
    int currLen = 1;
    int frameid=0;
    Timestamp t1;

    // make sure the packet can carry the isoch payload
    if (!framecounter) {
	framecounter = new Isochronous::FrameCounter(mSettings->mFPS);
    }
    udp_payload->isoch.burstperiod = htonl(framecounter->period_us());

    int initdone = 0;
    int fatalwrite_err = 0;
    while (InProgress() && !fatalwrite_err) {
	int bytecnt = static_cast<int>(lognormal(mSettings->mMean,mSettings->mVariance)) / (mSettings->mFPS * 8);
	if (bytecnt < udp_payload_minimum)
	    bytecnt = udp_payload_minimum;
	delay = 0;

	// printf("bits=%d\n", (int) (mSettings->mFPS * bytecnt * 8));
	udp_payload->isoch.burstsize  = htonl(bytecnt);
	udp_payload->isoch.prevframeid  = htonl(frameid);
	reportstruct->burstsize=bytecnt;
	frameid =  framecounter->wait_tick();
	udp_payload->isoch.frameid  = htonl(frameid);
	lastPacketTime.setnow();
	if (!initdone) {
	    initdone = 1;
	    udp_payload->isoch.start_tv_sec = htonl(lastPacketTime.getSecs());
	    udp_payload->isoch.start_tv_usec = htonl(lastPacketTime.getUsecs());
	}
	while ((bytecnt > 0) && InProgress()) {
	    t1.setnow();
	    reportstruct->packetTime.tv_sec = t1.getSecs();
	    reportstruct->packetTime.tv_usec = t1.getUsecs();
	    reportstruct->sentTime = reportstruct->packetTime;
	    mBuf_UDP->tv_sec  = htonl(reportstruct->packetTime.tv_sec);
	    mBuf_UDP->tv_usec = htonl(reportstruct->packetTime.tv_usec);
	    WritePacketID(reportstruct->packetID);

	    // Adjustment for the running delay
	    // o measure how long the last loop iteration took
	    // o calculate the delay adjust
	    //   - If write succeeded, adjust = target IPG - the loop time
	    //   - If write failed, adjust = the loop time
	    // o then adjust the overall running delay
	    // Note: adjust units are nanoseconds,
	    //       packet timestamps are microseconds
	    if (currLen > 0)
		adjust = delay_target + \
		    (1000.0 * lastPacketTime.subUsec(reportstruct->packetTime));
	    else
		adjust = 1000.0 * lastPacketTime.subUsec(reportstruct->packetTime);

	    lastPacketTime.set(reportstruct->packetTime.tv_sec, reportstruct->packetTime.tv_usec);
	    // Since linux nanosleep/busyloop can exceed delay
	    // there are two possible equilibriums
	    //  1)  Try to perserve inter packet gap
	    //  2)  Try to perserve requested transmit rate
	    // The latter seems preferred, hence use a running delay
	    // that spans the life of the thread and constantly adjust.
	    // A negative delay means the iperf app is behind.
	    delay += adjust;
	    // Don't let delay grow unbounded
	    // if (delay < delay_lower_bounds) {
	    //	  delay = delay_target;
	    // }

	    reportstruct->errwrite = WriteNoErr;
	    reportstruct->emptyreport = 0;

	    // perform write
	    if (isModeAmount(mSettings) && (mSettings->mAmount < static_cast<unsigned>(mSettings->mBufLen))) {
	        udp_payload->isoch.remaining = htonl(mSettings->mAmount);
		reportstruct->remaining=mSettings->mAmount;
	        currLen = write(mySocket, mSettings->mBuf, mSettings->mAmount);
	    } else {
	        udp_payload->isoch.remaining = htonl(bytecnt);
		reportstruct->remaining=bytecnt;
	        currLen = write(mySocket, mSettings->mBuf, (bytecnt < mSettings->mBufLen) ? bytecnt : mSettings->mBufLen);
	    }

	    if (currLen < 0) {
	        reportstruct->packetID--;
		reportstruct->emptyreport = 1;
		currLen = 0;
		if (FATALUDPWRITERR(errno)) {
	            reportstruct->errwrite = WriteErrFatal;
	            WARN_errno(1, "write");
		    fatalwrite_err = 1;
	        } else {
		    reportstruct->errwrite = WriteErrAccount;
		}
	    } else {
		bytecnt -= currLen;
		if (!bytecnt)
		    reportstruct->transit_ready = 1;
		else
		    reportstruct->transit_ready = 0;
		// adjust bytecnt so last packet of burst is greater or equal to min packet
		if ((bytecnt > 0) && (bytecnt < udp_payload_minimum)) {
		    bytecnt = udp_payload_minimum;
		    udp_payload->isoch.burstsize  = htonl(bytecnt);
		    reportstruct->burstsize=bytecnt;
		}
	    }
	    if (isModeAmount(mSettings)) {
	        /* mAmount may be unsigned, so don't let it underflow! */
	        if (mSettings->mAmount >= static_cast<unsigned long>(currLen)) {
		    mSettings->mAmount -= static_cast<unsigned long>(currLen);
		} else {
		    mSettings->mAmount = 0;
		}
	    }
	    // report packets

	    reportstruct->frameID=frameid;
	    reportstruct->packetLen = static_cast<unsigned long>(currLen);
	    reportstruct->prevPacketTime = myReport->info.ts.prevpacketTime;
	    myReportPacket();
	    reportstruct->packetID++;
	    myReport->info.ts.prevpacketTime = reportstruct->packetTime;
	    // Insert delay here only if the running delay is greater than 1 usec,
	    // otherwise don't delay and immediately continue with the next tx.
	    if (delay >= 1000) {
		// Convert from nanoseconds to microseconds
		// and invoke the microsecond delay
		delay_loop(static_cast<unsigned long>(delay / 1000));
	    }
	}
    }
    FinishTrafficActions();
}
// end RunUDPIsoch

inline void Client::WritePacketID (intmax_t packetID) {
    struct UDP_datagram * mBuf_UDP = reinterpret_cast<struct UDP_datagram *>(mSettings->mBuf);
    // store datagram ID into buffer
#ifdef HAVE_INT64_T
    // Pack signed 64bit packetID into unsigned 32bit id1 + unsigned
    // 32bit id2.  A legacy server reading only id1 will still be able
    // to reconstruct a valid signed packet ID number up to 2^31.
    uint32_t id1, id2;
    id1 = packetID & 0xFFFFFFFFLL;
    id2 = (packetID  & 0xFFFFFFFF00000000LL) >> 32;

    mBuf_UDP->id = htonl(id1);
    mBuf_UDP->id2 = htonl(id2);

#ifdef HAVE_PACKET_DEBUG
    printf("id %" PRIdMAX " (0x%" PRIxMAX ") -> 0x%x, 0x%x\n",
	   packetID, packetID, id1, id2);
#endif
#else
    mBuf_UDP->id = htonl((reportstruct->packetID));
#endif
}

inline void Client::WriteTcpTxHdr (struct ReportStruct *reportstruct, int burst_size, int burst_id) {
    struct TCP_burst_payload * mBuf_burst = reinterpret_cast<struct TCP_burst_payload *>(mSettings->mBuf);
    // store packet ID into buffer
    reportstruct->packetID += burst_size;
    mBuf_burst->start_tv_sec = htonl(myReport->info.ts.startTime.tv_sec);
    mBuf_burst->start_tv_usec = htonl(myReport->info.ts.startTime.tv_usec);

#ifdef HAVE_INT64_T
    // Pack signed 64bit packetID into unsigned 32bit id1 + unsigned
    // 32bit id2.  A legacy server reading only id1 will still be able
    // to reconstruct a valid signed packet ID number up to 2^31.
    uint32_t id1, id2;
    id1 = reportstruct->packetID & 0xFFFFFFFFLL;
    id2 = (reportstruct->packetID  & 0xFFFFFFFF00000000LL) >> 32;

    mBuf_burst->seqno_lower = htonl(id1);
    mBuf_burst->seqno_upper = htonl(id2);

#ifdef HAVE_PACKET_DEBUG
    printf("id %" PRIdMAX " (0x%" PRIxMAX ") -> 0x%x, 0x%x\n",
	   reportstruct->packetID, reportstruct->packetID, id1, id2);
#endif
#else
    mBuf_burst->seqno_lower = htonl((reportstruct->packetID));
    mBuf_burst->seqno_upper = htonl(0x0);
#endif
    mBuf_burst->send_tt.write_tv_sec  = htonl(reportstruct->packetTime.tv_sec);
    mBuf_burst->send_tt.write_tv_usec  = htonl(reportstruct->packetTime.tv_usec);
    mBuf_burst->burst_id  = htonl((uint32_t)burst_id);
    mBuf_burst->burst_size  = htonl((uint32_t)burst_size);
    reportstruct->frameID=burst_id;
    reportstruct->burstsize=burst_size;
//    printf("**** Write tcp burst header size= %d id = %d\n", burst_size, burst_id);
}

// See payloads.h
void Client::WriteTcpTxBBHdr (struct ReportStruct *reportstruct, uint32_t bbid, int final) {
    struct bounceback_hdr * mBuf_bb = reinterpret_cast<struct bounceback_hdr *>(mSettings->mBuf);
    // store packet ID into buffer
    uint32_t flags = HEADER_BOUNCEBACK;
    uint32_t bbflags = 0x0;
    mBuf_bb->flags = htonl(flags);
    if (isTripTime(mSettings)) {
	bbflags |= HEADER_BBCLOCKSYNCED;
    }
    if (mSettings->mTOS) {
	bbflags |= HEADER_BBTOS;
	mBuf_bb->tos = htons((mSettings->mTOS & 0xFF));
    }
    if (isTcpQuickAck(mSettings)) {
	bbflags |= HEADER_BBQUICKACK;
    }
    mBuf_bb->bbRunTime = 0x0;
    if (final) {
	bbflags |= HEADER_BBSTOP;
    }
    mBuf_bb->bbflags = htons(bbflags);
    mBuf_bb->bbsize = htonl(mSettings->mBufLen);
    mBuf_bb->bbid = htonl(bbid);
    mBuf_bb->bbclientTx_ts.sec = htonl(reportstruct->packetTime.tv_sec);
    mBuf_bb->bbclientTx_ts.usec = htonl(reportstruct->packetTime.tv_usec);
    mBuf_bb->bbserverRx_ts.sec = -1;
    mBuf_bb->bbserverRx_ts.usec = -1;
    mBuf_bb->bbserverTx_ts.sec = -1;
    mBuf_bb->bbserverTx_ts.usec = -1;
    mBuf_bb->bbhold = htonl(mSettings->mBounceBackHold);
}

inline bool Client::InProgress (void) {
    // Read the next data block from
    // the file if it's file input
    if (isFileInput(mSettings)) {
	Extractor_getNextDataBlock(readAt, mSettings);
        return Extractor_canRead(mSettings) != 0;
    }
    // fprintf(stderr, "DEBUG: SI=%d PC=%d T=%d A=%d\n", sInterupted, peerclose, (isModeTime(mSettings) && mEndTime.before(reportstruct->packetTime)), (isModeAmount(mSettings) && (mSettings->mAmount <= 0)));
    return !(sInterupted || peerclose || \
	(isModeTime(mSettings) && mEndTime.before(reportstruct->packetTime))  ||
	(isModeAmount(mSettings) && (mSettings->mAmount <= 0)));
}

inline void Client::tcp_shutdown (void) {
    if ((mySocket != INVALID_SOCKET) && isConnected()) {
	int rc = shutdown(mySocket, SHUT_WR);
#ifdef HAVE_THREAD_DEBUG
	thread_debug("Client calls shutdown() SHUTW_WR on tcp socket %d", mySocket);
#endif
	WARN_errno(rc == SOCKET_ERROR, "shutdown");
	if (!rc && !isFullDuplex(mSettings))
	    AwaitServerCloseEvent();
    }
}

/*
 * Common things to do to finish a traffic thread
 *
 * Notes on the negative packet count or seq no:
 * A negative packet id is used to tell the server
 * this UDP stream is terminating.  The server will remove
 * the sign.  So a decrement will be seen as increments by
 * the server (e.g, -1000, -1001, -1002 as 1000, 1001, 1002)
 * If the retries weren't decrement here the server can get out
 * of order packets per these retries actually being received
 * by the server (e.g. -1000, -1000, -1000)
 */
void Client::FinishTrafficActions () {
    disarm_itimer();
    // Shutdown the TCP socket's writes as the event for the server to end its traffic loop
    if (!isUDP(mSettings)) {
	tcp_shutdown();
	now.setnow();
	reportstruct->packetTime.tv_sec = now.getSecs();
	reportstruct->packetTime.tv_usec = now.getUsecs();
	if (one_report) {
	    /*
	     *  For TCP and if not doing interval or enhanced reporting (needed for write accounting),
	     *  then report the entire transfer as one big packet
	     *
	     */
	    reportstruct->packetLen = totLen;
	}
    } else {
	// stop timing
	now.setnow();
	reportstruct->packetTime.tv_sec = now.getSecs();
	reportstruct->packetTime.tv_usec = now.getUsecs();
	reportstruct->sentTime = reportstruct->packetTime;
	// send a final terminating datagram
	// Don't count in the mTotalLen. The server counts this one,
	// but didn't count our first datagram, so we're even now.
	// The negative datagram ID signifies termination to the server.
	WritePacketID(-reportstruct->packetID);
	struct UDP_datagram * mBuf_UDP = reinterpret_cast<struct UDP_datagram *>(mSettings->mBuf);
	mBuf_UDP->tv_sec = htonl(reportstruct->packetTime.tv_sec);
	mBuf_UDP->tv_usec = htonl(reportstruct->packetTime.tv_usec);
	int len = write(mySocket, mSettings->mBuf, mSettings->mBufLen);
#ifdef HAVE_THREAD_DEBUG
	thread_debug("UDP client sent final packet per negative seqno %ld", -reportstruct->packetID);
#endif
	if (len > 0) {
	    reportstruct->packetLen = len;
	    myReportPacket();
	}
	reportstruct->packetLen = 0;
    }
    int do_close = EndJob(myJob, reportstruct);
    if (isUDP(mSettings) && !isMulticast(mSettings) && !isNoUDPfin(mSettings)) {
	/*
	 *  For UDP, there is a final handshake between the client and the server,
	 *  do that now (unless requested no to)
	 */
	AwaitServerFinPacket();
    }
    if (do_close) {
#if HAVE_THREAD_DEBUG
	thread_debug("client close sock=%d", mySocket);
#endif
	int rc = close(mySocket);
	WARN_errno(rc == SOCKET_ERROR, "client close");
    }
    Iperf_remove_host(mSettings);
    FreeReport(myJob);
    if (framecounter)
	DELETE_PTR(framecounter);
}

/* -------------------------------------------------------------------
 * Await for the server's fin packet which also has the server
 * stats to displayed on the client.  Attempt to re-transmit
 * until the fin is received
 * ------------------------------------------------------------------- */
#define RETRYTIMER 10000 //units of us
#define RETRYCOUNT (2 * 1000000 / RETRYTIMER) // 2 seconds worth of retries
void Client::AwaitServerFinPacket () {
    int rc;
    fd_set readSet;
    struct timeval timeout;
    int ack_success = 0;
    int count = RETRYCOUNT;
    while (--count >= 0) {
        // wait until the socket is readable, or our timeout expires
        FD_ZERO(&readSet);
        FD_SET(mySocket, &readSet);
        timeout.tv_sec  = 0;
        timeout.tv_usec = RETRYTIMER;
        rc = select(mySocket+1, &readSet, NULL, NULL, &timeout);
        FAIL_errno(rc == SOCKET_ERROR, "select", mSettings);
        // rc= zero means select's read timed out
	if (rc == 0) {
	    // try to trigger another FIN by resending a negative seq no
	    WritePacketID(-(++reportstruct->packetID));
	    // write data
	    rc = write(mySocket, mSettings->mBuf, mSettings->mBufLen);
	    WARN_errno(rc < 0, "write-fin");
#ifdef HAVE_THREAD_DEBUG
	    thread_debug("UDP client retransmit final packet per negative seqno %ld", -reportstruct->packetID);
#endif
	} else {
            // socket ready to read, this packet size
	    // is set by the server.  Assume it's large enough
	    // to contain the final server packet
	    rc = read(mySocket, mSettings->mBuf, MAXUDPBUF);

	    // dump any 2.0.13 client acks sent at the start of traffic
	    if (rc == sizeof(client_hdr_ack)) {
		struct client_hdr_ack *ack =  reinterpret_cast<struct client_hdr_ack *>(mSettings->mBuf);
		if (ntohl(ack->typelen.type) == CLIENTHDRACK) {
		    // printf("**** dump stale ack \n");
		    continue;
		}
	    }

	    WARN_errno(rc < 0, "read");
	    if (rc > 0) {
		ack_success = 1;
#ifdef HAVE_THREAD_DEBUG
		thread_debug("UDP client received server relay report ack (%d)", -reportstruct->packetID);
#endif
		if (mSettings->mReportMode != kReport_CSV) {
		    PostReport(InitServerRelayUDPReport(mSettings, reinterpret_cast<server_hdr*>(reinterpret_cast<UDP_datagram*>(mSettings->mBuf) + 1)));
		}
		break;
	    }
        }
    }
    if ((!ack_success) && (mSettings->mReportMode != kReport_CSV))
	fprintf(stderr, warn_no_ack, mySocket, (isModeTime(mSettings) ? 10 : 1));
}


void Client::PostNullEvent () {
    assert(myReport!=NULL);
    // push a nonevent into the packet ring
    // this will cause the reporter to process
    // up to this event
    memset(reportstruct, 0, sizeof(struct ReportStruct));
    now.setnow();
    reportstruct->packetTime.tv_sec = now.getSecs();
    reportstruct->packetTime.tv_usec = now.getUsecs();
    reportstruct->emptyreport=1;
    myReportPacket();
}

// The client end timer is based upon the final fin, fin-ack w/the server
// A way to detect this is to hang a recv and wait for the zero byte
// return indicating the socket is closed for recv per the server
// closing it's socket
#define MINAWAITCLOSEUSECS 2000000
void Client::AwaitServerCloseEvent () {
    // the await detection can take awhile so post a non event ahead of it
    PostNullEvent();
    unsigned int amount_usec = \
	(isModeTime(mSettings) ? static_cast<int>(mSettings->mAmount * 10000) : MINAWAITCLOSEUSECS);
    if (amount_usec < MINAWAITCLOSEUSECS)
	amount_usec = MINAWAITCLOSEUSECS;
    SetSocketOptionsReceiveTimeout(mSettings, amount_usec);
    int rc;
    while ((rc = recv(mySocket, mSettings->mBuf, mSettings->mBufLen, 0) > 0)) {};
    if (rc < 0)
	WARN_errno(1, "client await server close");

    if (rc==0) {
	connected = false;
#ifdef HAVE_THREAD_DEBUG
	thread_debug("Client detected server close %d", mySocket);
#endif
    }
}

int Client::SendFirstPayload () {
    int pktlen = 0;
    if (!isConnectOnly(mSettings)) {
	if (myReport && !TimeZero(myReport->info.ts.startTime) && !(mSettings->mMode == kTest_TradeOff)) {
	    reportstruct->packetTime = myReport->info.ts.startTime;
	} else {
	    now.setnow();
	    reportstruct->packetTime.tv_sec = now.getSecs();
	    reportstruct->packetTime.tv_usec = now.getUsecs();
	}
	pattern(mSettings->mBuf, mSettings->mBufLen);
	if (isTxStartTime(mSettings)) {
	    pktlen = Settings_GenerateClientHdr(mSettings, (void *) mSettings->mBuf, mSettings->txstart_epoch);
	} else {
	    pktlen = Settings_GenerateClientHdr(mSettings, (void *) mSettings->mBuf, reportstruct->packetTime);
	}
	if (pktlen > 0) {
	    if (isUDP(mSettings)) {
		struct client_udp_testhdr *tmphdr = reinterpret_cast<struct client_udp_testhdr *>(mSettings->mBuf);
		WritePacketID(reportstruct->packetID);
		tmphdr->seqno_ts.tv_sec  = htonl(reportstruct->packetTime.tv_sec);
		tmphdr->seqno_ts.tv_usec = htonl(reportstruct->packetTime.tv_usec);
		udp_payload_minimum = pktlen;
#if HAVE_DECL_MSG_DONTWAIT
		pktlen = send(mySocket, mSettings->mBuf, (pktlen > mSettings->mBufLen) ? pktlen : mSettings->mBufLen, MSG_DONTWAIT);
#else
		pktlen = send(mySocket, mSettings->mBuf, (pktlen > mSettings->mBufLen) ? pktlen : mSettings->mBufLen, 0);
#endif
		apply_first_udppkt_delay = true;
	    } else {
#if HAVE_DECL_TCP_NODELAY
		if (!isNoDelay(mSettings) && isPeerVerDetect(mSettings) && isTripTime(mSettings)) {
		    int optflag=1;
		    int rc;
		    // Disable Nagle to reduce latency of this intial message
		    if ((rc = setsockopt(mSettings->mSock, IPPROTO_TCP, TCP_NODELAY, reinterpret_cast<char *>(&optflag), sizeof(int))) < 0) {
			WARN_errno(rc < 0, "tcpnodelay");
		    }
		}
#endif
#if HAVE_DECL_MSG_DONTWAIT
		pktlen = send(mySocket, mSettings->mBuf, pktlen, MSG_DONTWAIT);
#else
		pktlen = send(mySocket, mSettings->mBuf, pktlen, 0);
#endif
		if (isPeerVerDetect(mSettings) && !isServerReverse(mSettings)) {
		    PeerXchange();
		}
#if HAVE_DECL_TCP_NODELAY
		if (!isNoDelay(mSettings) && isPeerVerDetect(mSettings) && isTripTime(mSettings)) {
		    int optflag=0;
		    int rc;
		    // Disable Nagle to reduce latency of this intial message
		    if ((rc = setsockopt(mSettings->mSock, IPPROTO_TCP, TCP_NODELAY, reinterpret_cast<char *>(&optflag), sizeof(int))) < 0) {
			WARN_errno(rc < 0, "tcpnodelay");
		    }
		}
#endif
	    }
	    WARN_errno(pktlen < 0, "send_hdr");
	}
    }
    return pktlen;
}

void Client::PeerXchange () {
    int n;
    client_hdr_ack ack;
    /*
     * Hang read and see if this is a header ack message
     */
    int readlen = isTripTime(mSettings) ? sizeof(struct client_hdr_ack) : (sizeof(struct client_hdr_ack) - sizeof(struct client_hdr_ack_ts));
    if ((n = recvn(mySocket, reinterpret_cast<char *>(&ack), readlen, 0)) == readlen) {
	if (ntohl(ack.typelen.type) == CLIENTHDRACK) {
	    mSettings->peer_version_u = ntohl(ack.version_u);
	    mSettings->peer_version_l = ntohl(ack.version_l);
	    if (isTripTime(mSettings)) {
		Timestamp now;
		Timestamp senttx(ntohl(ack.ts.sent_tv_sec), ntohl(ack.ts.sent_tv_usec));
		Timestamp sentrx(ntohl(ack.ts.sentrx_tv_sec), ntohl(ack.ts.sentrx_tv_usec));
		Timestamp acktx(ntohl(ack.ts.ack_tv_sec), ntohl(ack.ts.ack_tv_usec));
		Timestamp ackrx(now.getSecs(), now.getUsecs());
		double str = (sentrx.get() - senttx.get()) * 1e3;
		double atr = (now.get() - acktx.get()) * 1e3;
		double rtt = str + atr;
		double halfrtt = rtt / 2.0;
		fprintf(stderr,"%sClock sync check (ms): RTT/Half=(%0.3f/%0.3f) OWD-send/ack/asym=(%0.3f/%0.3f/%0.3f)\n",mSettings->mTransferIDStr, rtt, halfrtt, str, atr, (str-atr));
	    }
	}
    } else {
	WARN_errno(1, "recvack");
    }
}

/*
 * BarrierClient allows for multiple stream clients to be syncronized
 */
int Client::BarrierClient (struct BarrierMutex *barrier) {
    int last = 0;
#ifdef HAVE_THREAD
    assert(barrier != NULL);
    Condition_Lock(barrier->await);
    if (--barrier->count <= 0) {
	// store the barrier release timer
#ifdef HAVE_CLOCK_GETTIME
	struct timespec t1;
	clock_gettime(CLOCK_REALTIME, &t1);
	barrier->release_time.tv_sec  = t1.tv_sec;
	barrier->release_time.tv_usec = t1.tv_nsec / 1000;
#else
	gettimeofday(&barrier->release_time, NULL);
#endif
	last = 1;
	// last one wake's up everyone else
	Condition_Broadcast(&barrier->await);
#ifdef HAVE_THREAD_DEBUG
	thread_debug("Barrier BROADCAST on condition %p", (void *)&barrier->await);
#endif
    } else {
#ifdef HAVE_THREAD_DEBUG
        thread_debug("Barrier WAIT on condition %p count=%d", (void *)&barrier->await, barrier->count);
#endif
        Condition_Wait(&barrier->await);
    }
    Condition_Unlock(barrier->await);
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Barrier EXIT on condition %p", (void *)&barrier->await);
#endif
#else
    last = 1;
#endif // HAVE_THREAD
    return last;
}
