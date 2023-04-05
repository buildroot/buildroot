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
 * PerfSocket.cpp
 * by Mark Gates <mgates@nlanr.net>
 *    Ajay Tirumala <tirumala@ncsa.uiuc.edu>
 * -------------------------------------------------------------------
 * Has routines the Client and Server classes use in common for
 * performance testing the network.
 * Changes in version 1.2.0
 *     for extracting data from files
 * -------------------------------------------------------------------
 * headers
 * uses
 *   <stdlib.h>
 *   <stdio.h>
 *   <string.h>
 *
 *   <sys/types.h>
 *   <sys/socket.h>
 *   <unistd.h>
 *
 *   <arpa/inet.h>
 *   <netdb.h>
 *   <netinet/in.h>
 *   <sys/socket.h>
 * ------------------------------------------------------------------- */
#define HEADERS()

#include "headers.h"
#include "PerfSocket.hpp"
#include "SocketAddr.h"
#include "util.h"

/* -------------------------------------------------------------------
 * Set socket options before the listen() or connect() calls.
 * These are optional performance tuning factors.
 * ------------------------------------------------------------------- */
void SetSocketOptions (struct thread_Settings *inSettings) {
    // set the TCP window size (socket buffer sizes)
    // also the UDP buffer size
    // must occur before call to accept() for large window sizes
    setsock_tcp_windowsize(inSettings->mSock, inSettings->mTCPWin,
                            (inSettings->mThreadMode == kMode_Client ? 1 : 0));

    if (isCongestionControl(inSettings)) {
#ifdef TCP_CONGESTION
	Socklen_t len = strlen(inSettings->mCongestion) + 1;
	int rc = setsockopt(inSettings->mSock, IPPROTO_TCP, TCP_CONGESTION,
			     inSettings->mCongestion, len);
	if (rc == SOCKET_ERROR) {
	    fprintf(stderr, "Attempt to set '%s' congestion control failed: %s\n",
		    inSettings->mCongestion, strerror(errno));
	    unsetCongestionControl(inSettings);
	}
#else
	fprintf(stderr, "The -Z option is not available on this operating system\n");
#endif
    }


#if ((HAVE_TUNTAP_TAP) && (HAVE_TUNTAP_TUN))
    if (isTunDev(inSettings) || isTapDev(inSettings)) {
	char **device = (inSettings->mThreadMode == kMode_Client) ? &inSettings->mIfrnametx : &inSettings->mIfrname;
	struct ifreq ifr;
	struct sockaddr_ll saddr;
	memset(&ifr, 0, sizeof(ifr));
	if (*device) {
	    snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", *device);
//	    ifr.ifr_flags = IFF_MULTI_QUEUE;
	}
	inSettings->tuntapdev = open("/dev/net/tun", O_RDWR);
	FAIL_errno((inSettings->tuntapdev == -1), "open tun dev", inSettings);
	ifr.ifr_flags |= isTapDev(inSettings) ? IFF_TAP : IFF_TUN;
	ifr.ifr_flags |= IFF_NO_PI;
	int rc = ioctl(inSettings->tuntapdev, TUNSETIFF, (void*) &ifr);
	FAIL_errno((rc == -1), "tunsetiff", inSettings);
	if (!(*device)) {
	    int len = snprintf(NULL, 0, "tap%d", inSettings->tuntapdev);
	    len++;  // Trailing null byte + extra
	    (*device) = static_cast<char *>(calloc(0,len));
	    len = snprintf(*device, len, "tap%d", inSettings->tuntapdev);
	}
	memset(&saddr, 0, sizeof(saddr));
	saddr.sll_family = AF_PACKET;
	saddr.sll_protocol = htons(ETH_P_ALL);
	saddr.sll_ifindex = if_nametoindex(*device);
	if (!saddr.sll_ifindex) {
	    fprintf(stderr, "tuntap device of %s used for index lookup\n", (*device));
	    FAIL_errno(!saddr.sll_ifindex, "tuntap nametoindex", inSettings);
	}
	saddr.sll_pkttype = PACKET_HOST;
	rc = bind(inSettings->mSock, reinterpret_cast<sockaddr*>(&saddr), sizeof(saddr));
	FAIL_errno((rc == SOCKET_ERROR), "tap bind", inSettings);
#ifdef HAVE_THREAD_DEBUG
	thread_debug("tuntap device of %s configured", inSettings->mIfrname);
#endif
    } else
#endif
#if (HAVE_DECL_SO_BINDTODEVICE) && 0
    {
	char **device = (inSettings->mThreadMode == kMode_Client) ? &inSettings->mIfrnametx : &inSettings->mIfrname;
	if (*device) {
	    struct ifreq ifr;
	    memset(&ifr, 0, sizeof(ifr));
	    snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", *device);
	    if (setsockopt(inSettings->mSock, SOL_SOCKET, SO_BINDTODEVICE, (void *)&ifr, sizeof(ifr)) < 0) {
		char *buf;
		int len = snprintf(NULL, 0, "%s %s", "bind to device", *device);
		len++;  // Trailing null byte + extra
		buf = static_cast<char *>(malloc(len));
		len = snprintf(buf, len, "%s %s", "bind to device", *device);
		WARN_errno(1, buf);
		free(buf);
		free(*device);
		*device = NULL;
		FAIL(1, "setsockopt() SO_BINDTODEVICE", inSettings);
	    }
	}
    }
#endif

    // check if we're sending multicast
    if (isMulticast(inSettings)) {
#ifdef HAVE_MULTICAST
	if (!isUDP(inSettings)) {
	    FAIL(1, "Multicast requires -u option ", inSettings);
	    exit(1);
	}
	// check for default TTL, multicast is 1 and unicast is the system default
	if (inSettings->mTTL == -1) {
	    inSettings->mTTL = 1;
	}
	if (inSettings->mTTL > 0) {
	    // set TTL
	    if (!isIPV6(inSettings)) {
		unsigned char cval  = inSettings->mTTL;
		int rc = setsockopt(inSettings->mSock, IPPROTO_IP, IP_MULTICAST_TTL, \
				    reinterpret_cast<const char *>(&cval), sizeof(cval));
		WARN_errno(rc == SOCKET_ERROR, "multicast v4 ttl");
	    } else
#  ifdef HAVE_IPV6_MULTICAST
	    {
		int val  = inSettings->mTTL;
		int rc = setsockopt(inSettings->mSock, IPPROTO_IPV6, IPV6_MULTICAST_HOPS, \
				    reinterpret_cast<char *>(&val), static_cast<Socklen_t>(sizeof(val)));
		WARN_errno(rc == SOCKET_ERROR, "multicast v6 ttl");
	    }
#  else
	    FAIL_errno(1, "v6 multicast not supported", inSettings);
#  endif
	}
#endif
    } else if (inSettings->mTTL > 0) {
	int val = inSettings->mTTL;
	int rc = setsockopt(inSettings->mSock, IPPROTO_IP, IP_TTL, \
			    reinterpret_cast<char *>(&val), static_cast<Socklen_t>(sizeof(val)));
	WARN_errno(rc == SOCKET_ERROR, "v4 ttl");
    }

#if HAVE_DECL_IP_TOS
    SetSocketOptionsIPTos(inSettings, inSettings->mTOS);
#endif

    if (!isUDP(inSettings)) {
	if (isTCPMSS(inSettings)) {
	    // set the TCP maximum segment size
	    setsock_tcp_mss(inSettings->mSock, inSettings->mMSS);
	}
#if HAVE_DECL_TCP_NODELAY
	{
            int nodelay = 1;
            Socklen_t len = sizeof(nodelay);
	    int rc = 0;
	    // set TCP nodelay option
	    if (isNoDelay(inSettings)) {
		rc = setsockopt(inSettings->mSock, IPPROTO_TCP, TCP_NODELAY,
				reinterpret_cast<char*>(&nodelay), len);
		WARN_errno(rc == SOCKET_ERROR, "setsockopt TCP_NODELAY");
	    }
	    // Read the socket setting, could be set on by kernel
	    if (isEnhanced(inSettings) && (rc == 0)) {
		rc = getsockopt(inSettings->mSock, IPPROTO_TCP, TCP_NODELAY,
				reinterpret_cast<char*>(&nodelay), &len);
		WARN_errno(rc == SOCKET_ERROR, "getsockopt TCP_NODELAY");
		if (rc == 0) {
		    if (nodelay)
			setNoDelay(inSettings);
		    else
			unsetNoDelay(inSettings);
		}
	    }
	}
#endif
#if HAVE_DECL_TCP_WINDOW_CLAMP
        // set TCP clamp option
        if (isRxClamp(inSettings)) {
            int clamp = inSettings->mClampSize;
            Socklen_t len = sizeof(clamp);
            int rc = setsockopt(inSettings->mSock, IPPROTO_TCP, TCP_WINDOW_CLAMP,
                                 reinterpret_cast<char*>(&clamp), len);
            WARN_errno(rc == SOCKET_ERROR, "setsockopt TCP_WINDOW_CLAMP");
        }
#endif
#if HAVE_DECL_TCP_NOTSENT_LOWAT
        // set TCP not sent low watermark
        if (isWritePrefetch(inSettings)) {
            int bytecnt = inSettings->mWritePrefetch;
            Socklen_t len = sizeof(bytecnt);
            int rc = setsockopt(inSettings->mSock, IPPROTO_TCP, TCP_NOTSENT_LOWAT,
                                 reinterpret_cast<char*>(&bytecnt), len);
            WARN_errno(rc == SOCKET_ERROR, "setsockopt TCP_NOTSENT_LOWAT");
        }
#endif
    }

#if HAVE_DECL_SO_MAX_PACING_RATE
    /* If socket pacing is specified try to enable it. */
    if (isFQPacing(inSettings) && inSettings->mFQPacingRate > 0) {
	int rc = setsockopt(inSettings->mSock, SOL_SOCKET, SO_MAX_PACING_RATE, &inSettings->mFQPacingRate, sizeof(inSettings->mFQPacingRate));
        WARN_errno(rc == SOCKET_ERROR, "setsockopt SO_MAX_PACING_RATE");
    }
#endif /* HAVE_SO_MAX_PACING_RATE */
#if HAVE_DECL_SO_DONTROUTE
    /* If socket pacing is specified try to enable it. */
    if (isDontRoute(inSettings)) {
	int option = 1;
	Socklen_t len = sizeof(option);
	int rc = setsockopt(inSettings->mSock, SOL_SOCKET, SO_DONTROUTE, reinterpret_cast<char*>(&option), len);
        WARN_errno(rc == SOCKET_ERROR, "setsockopt SO_DONTROUTE");
    }
#endif /* HAVE_DECL_SO_DONTROUTE */
}

// Note that timer units are microseconds, be careful
void SetSocketOptionsSendTimeout (struct thread_Settings *mSettings, int timer) {
    assert (timer > 0);
#ifdef WIN32
    // Windows SO_SNDTIMEO uses ms
    DWORD timeout = (double) timer / 1e3;
#else
    struct timeval timeout;
    timeout.tv_sec = timer / 1000000;
    timeout.tv_usec = timer % 1000000;
#endif
    if (setsockopt(mSettings->mSock, SOL_SOCKET, SO_SNDTIMEO, reinterpret_cast<char *>(&timeout), sizeof(timeout)) < 0) {
	WARN_errno(mSettings->mSock == SO_SNDTIMEO, "socket");
    }
//    fprintf(stderr,"**** tx timeout %d usecs\n", timer);
}

void SetSocketOptionsReceiveTimeout (struct thread_Settings *mSettings, int timer) {
    assert(timer>0);
#ifdef WIN32
    // Windows SO_RCVTIMEO uses ms
    DWORD timeout = (double) timer / 1e3;
#else
    struct timeval timeout;
    timeout.tv_sec = timer / 1000000;
    timeout.tv_usec = timer % 1000000;
#endif
    if (setsockopt(mSettings->mSock, SOL_SOCKET, SO_RCVTIMEO, reinterpret_cast<char *>(&timeout), sizeof(timeout)) < 0) {
	WARN_errno(mSettings->mSock == SO_RCVTIMEO, "socket");
    }
//    fprintf(stderr,"**** rx timeout %d usecs\n", timer);
}


void SetSocketOptionsIPTos (struct thread_Settings *mSettings, int tos) {
#if  HAVE_DECL_IP_TOS
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Set socket IP_TOS to 0x%x", tos);
#endif
#if HAVE_DECL_IPV6_TCLASS && ! defined HAVE_WINSOCK2_H
    // IPV6_TCLASS is defined on Windows but not implemented.
    if (isIPV6(mSettings)) {
	const int dscp = tos;
	int rc = setsockopt(mSettings->mSock, IPPROTO_IPV6, IPV6_TCLASS, (char*) &dscp, sizeof(dscp));
        WARN_errno(rc == SOCKET_ERROR, "setsockopt IPV6_TCLASS");
    } else
#endif
	// set IP TOS (type-of-service) field
	if (isOverrideTOS(mSettings) || (tos > 0)) {
	    int reqtos = tos;
	    Socklen_t len = sizeof(reqtos);
	    int rc = setsockopt(mSettings->mSock, IPPROTO_IP, IP_TOS,
				reinterpret_cast<char*>(&reqtos), len);
	    WARN_errno(rc == SOCKET_ERROR, "setsockopt IP_TOS");
	    rc = getsockopt(mSettings->mSock, IPPROTO_IP, IP_TOS,
				reinterpret_cast<char*>(&reqtos), &len);
	    WARN_errno(rc == SOCKET_ERROR, "getsockopt IP_TOS");
	    WARN((reqtos != tos), "IP_TOS setting failed");
	}
#endif
}


/*
 * Set a socket to blocking or non-blocking
*
 * Returns true on success, or false if there was an error
*/
bool setsock_blocking (int fd, bool blocking) {
   if (fd < 0) return false;
#ifdef WIN32
   unsigned long mode = blocking ? 0 : 1;
   return (ioctlsocket(fd, FIONBIO, &mode) == 0) ? true : false;
#else
   int flags = fcntl(fd, F_GETFL, 0);
   if (flags < 0) return false;
   flags = blocking ? (flags&~O_NONBLOCK) : (flags|O_NONBLOCK);
   return (fcntl(fd, F_SETFL, flags) == 0) ? true : false;
#endif
}

/* -------------------------------------------------------------------
 * If inMSS > 0, set the TCP maximum segment size  for inSock.
 * Otherwise leave it as the system default.
 * ------------------------------------------------------------------- */

const char warn_mss_fail[] = "\
WARNING: attempt to set TCP maxmimum segment size to %d failed\n";

void setsock_tcp_mss (int inSock, int inMSS) {
#if HAVE_DECL_TCP_MAXSEG
    int rc;
    int newMSS;
    Socklen_t len;

    assert(inSock != INVALID_SOCKET);

    if (inMSS > 0) {
        /* set */
        newMSS = inMSS;
        len = sizeof(newMSS);
        rc = setsockopt(inSock, IPPROTO_TCP, TCP_MAXSEG, (char*) &newMSS,  len);
        if (rc == SOCKET_ERROR) {
            fprintf(stderr, warn_mss_fail, newMSS);
            return;
        }
    }
#endif
} /* end setsock_tcp_mss */

/* -------------------------------------------------------------------
 * returns the TCP maximum segment size
 * ------------------------------------------------------------------- */

int getsock_tcp_mss  (int inSock) {
    int theMSS = -1;
#if HAVE_DECL_TCP_MAXSEG
    int rc;
    Socklen_t len;
    assert(inSock >= 0);

    /* query for MSS */
    len = sizeof(theMSS);
    rc = getsockopt(inSock, IPPROTO_TCP, TCP_MAXSEG, (char*)&theMSS, &len);
    WARN_errno(rc == SOCKET_ERROR, "getsockopt TCP_MAXSEG");
#endif
    return theMSS;
} /* end getsock_tcp_mss */

#ifdef DEFAULT_PAYLOAD_LEN_PER_MTU_DISCOVERY
#define UDPMAXSIZE ((1024 * 64) - 64) // 16 bit field for UDP
void checksock_max_udp_payload (struct thread_Settings *inSettings) {
#if HAVE_DECL_SIOCGIFMTU
    struct ifreq ifr;
    if (!isBuflenSet(inSettings) && inSettings->mIfrname) {
	strncpy(ifr.ifr_name, inSettings->mIfrname, (size_t) (IFNAMSIZ - 1));
	if (!ioctl(inSettings->mSock, SIOCGIFMTU, &ifr)) {
	    int max;
	    if (!isIPV6(inSettings)) {
		max = ifr.ifr_mtu - IPV4HDRLEN - UDPHDRLEN;
	    } else {
		max = ifr.ifr_mtu - IPV6HDRLEN - UDPHDRLEN;
	    }
	    if ((max > 0) && (max != inSettings->mBufLen)) {
		if (max > UDPMAXSIZE) {
		    max = UDPMAXSIZE;
		}
		if (max > inSettings->mBufLen) {
		    char *tmp = new char[max];
		    assert(tmp!=NULL);
		    if (tmp) {
			pattern(tmp, max);
			memcpy(tmp, inSettings->mBuf, inSettings->mBufLen);
			DELETE_ARRAY(inSettings->mBuf);
			inSettings->mBuf = tmp;
			inSettings->mBufLen = max;
		    }
		} else {
		    inSettings->mBufLen = max;
		}
	    }
	}
    }
#endif
}
#endif

// end SetSocketOptions
