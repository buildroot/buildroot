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
 * Settings.hpp
 * by Mark Gates <mgates@nlanr.net>
 * &  Ajay Tirumala <tirumala@ncsa.uiuc.edu>
 * -------------------------------------------------------------------
 * Stores and parses the initial values for all the global variables.
 * -------------------------------------------------------------------
 * headers
 * uses
 *   <stdlib.h>
 *   <assert.h>
 * ------------------------------------------------------------------- */

#ifndef SETTINGS_H
#define SETTINGS_H

#include "headers.h"
#include "Thread.h"
#include "Condition.h"
#include "packet_ring.h"

/* -------------------------------------------------------------------
 * constants
 * ------------------------------------------------------------------- */
#ifdef __cplusplus
extern "C" {
#endif

/* Smallest report interval supported. Units is microseconds */
#ifndef HAVE_FASTSAMPLING
#define SMALLEST_INTERVAL 5000 // 5ms
#define SMALLEST_INTERVAL_SEC 0.005 // 5ms
#else
#define SMALLEST_INTERVAL 100 // 100 usec
#define SMALLEST_INTERVAL_SEC 0.0001 // 5ms
#endif

#define SLOPSECS 2
// maximum  difference allowed between the tx (client) start time and the
// the first receive time (units seconds, requires --trip-times on client)
#define MAXDIFFTIMESTAMPSECS 600
// maximum difference in seconds to bound --txstart-time
#define MAXDIFFTXSTART 3600
// maximum difference in seconds to bound --txdelay-time,
// if this is too large and w/o keep-alives the connect may drop
#define MAXDIFFTXDELAY 3600
// maximum inter packet gap (or write delay) for UDP packets
#define MAXIPGSECS 60
#define CSVPEERLIMIT ((REPORT_ADDRLEN * 2) + 40)
#define NEARCONGEST_DEFAULT 0.5
#define DEFAULT_PERMITKEY_LIFE 20.0 // units is seconds
#define TESTEXCHANGETIMEOUT (4 * 1000000) // 4 secs, units is microseconds
#ifndef MAXTTL
#define MAXTTL 255
#endif
#define DEFAULT_BOUNCEBACK_BYTES 100

// server/client mode
enum ThreadMode {
    kMode_Unknown = 0,
    kMode_Server,
    kMode_Client,
    kMode_Reporter,
    kMode_ReporterClient,
    kMode_WriteAckServer,
    kMode_WriteAckClient,
    kMode_Listener
};

// report mode
enum ReportMode {
    kReport_Default = 0,
    kReport_CSV
};

// test mode
enum TestMode {
    kTest_Normal = 0,
    kTest_DualTest,
    kTest_TradeOff,
    kTest_Unknown
};

// interval reporting mode
enum IntervalMode {
    kInterval_None = 0,
    kInterval_Time,
    kInterval_Frames
};

// rate request units
enum RateUnits {
    kRate_BW = 0,
    kRate_PPS
};

#include "Reporter.h"
#include "payloads.h"

/*
 * The thread_Settings is a structure that holds all
 * options for a given execution of either a client
 * or server. By using this structure rather than
 * a global structure or class we can have multiple
 * clients or servers running with different settings.
 * In version 2.0 and above this structure contains
 * all the information needed for a thread to execute
 * and contains only C elements so it can be manipulated
 * by either C or C++.
 */
struct thread_Settings {
    // Pointers
    char*  mFileName;               // -F
    char*  mHost;                   // -c
    char*  mHideHost;
    char*  mLocalhost;              // -B
    char*  mOutputFileName;         // -o
    char*  mIfrname;                // %<device> name (for rx)
    char*  mIfrnametx;              // %<device> name (for tx)
    char*  mSSMMulticastStr;        // --ssm-host
    char*  mIsochronousStr;         // --isochronous
    char*  mHistogramStr;         // --histograms (packets)
    char*  mTransferIDStr;          //
    char*  mBuf;
    FILE*  Extractor_file;

    struct ReportHeader* reporthdr;
    struct SumReport* mSumReport;
    struct SumReport* mFullDuplexReport;
    struct thread_Settings *runNow;
    struct thread_Settings *runNext;
    // int's
    int mThreads;                   // -P
    int mTOS;                       // -S
    int mRTOS;                      // reflected TOS
    int mTransferID;
    int mConnectRetries;
#if WIN32
    SOCKET mSock;
#else
    int mSock;
#endif
#if defined(HAVE_LINUX_FILTER_H) && defined(HAVE_AF_PACKET)
    int mSockDrop;
#endif
    int Extractor_size;
    int mBufLen;                    // -l
    int mWriteAckLen;               // --write-ack
    int mMSS;                       // -M
    int mTCPWin;                    // -w
    /*   flags is a BitMask of old bools
        bool   mBufLenSet;              // -l
        bool   mCompat;                 // -C
        bool   mDaemon;                 // -D
        bool   mDomain;                 // -V
        bool   mFileInput;              // -F or -I
        bool   mNodelay;                // -N
        bool   mPrintMSS;               // -m
        bool   mRemoveService;          // -R
        bool   mStdin;                  // -I
        bool   mStdout;                 // -o
        bool   mSuggestWin;             // -W
        bool   mUDP;                    // -u
        bool   mMode_time;
        bool   mReportSettings;
        bool   mMulticast;
        bool   mNoSettingsReport;       // -x s
        bool   mNoConnectionReport;     // -x c
        bool   mNoDataReport;           // -x d
        bool   mNoServerReport;         // -x
        bool   mNoMultReport;           // -x m
        bool   mSinlgeClient;           // -1 */
    int flags;
    int flags_extend;
    int flags_extend2;
    // enums (which should be special int's)
    enum ThreadMode mThreadMode;         // -s or -c
    enum ReportMode mReportMode;
    enum TestMode mMode;              // -r or -d
    bool clientListener;              // set to True if client mode listener per -r or -d
    // Hopefully int64_t's
    uintmax_t mAppRate;            // -b or -u
    char mAppRateUnits;            // -b is either bw or pps
    uintmax_t mAmount;             // -n or -t time unit is 10 ms
    unsigned int mInterval;               // -i integer time units is usec
    enum IntervalMode mIntervalMode;
    // shorts
    unsigned short mListenPort;     // -L
    unsigned short mPort;           // -p
    unsigned short mPortLast;       // -p last port, e.g. when -p 6001-6010
    unsigned short mBindPort;      // -B
    // chars
    char   mFormat;                 // -f
    int mTTL;                    // -T
    char pad1[2];
    // structs or miscellaneous
    iperf_sockaddr peer;
    Socklen_t size_peer;
    iperf_sockaddr local;
    Socklen_t size_local;
    nthread_t mTID;
    int incrdstip;
    int incrsrcip;
    int incrsrcport;
    int connectonly_count;
    char* mCongestion;
    int mHistBins;
    int mHistBinsize;
    int mHistUnits;
    double mHistci_lower;
    double mHistci_upper;
#if defined(HAVE_WIN32_THREAD)
    HANDLE mHandle;
#endif
    double mFPS; //frames per second
    double mMean; //variable bit rate mean
    uint32_t mBurstSize; //number of bytes in a burst
    int mJitterBufSize; //Server jitter buffer size, units is frames
    double mBurstIPG; //Interpacket gap
    int l4offset; // used in l2 mode to offset the raw packet
    int l4payloadoffset;
    int recvflags; // used to set recv flags,e.g. MSG_TRUNC with L
    double mVariance; //vbr variance
    uintmax_t mFQPacingRate;
    struct timeval txholdback_timer;
    struct timeval txstart_epoch;
    struct timeval accept_time;
    struct timeval sent_time;
    struct Condition awake_me;
    struct PacketRing *ackring;
    struct BarrierMutex *connects_done;
    int numreportstructs;
    int32_t peer_version_u;
    int32_t peer_version_l;
    double connecttime;
    double rtt_nearcongest_weight_factor;
    char mPermitKey[MAX_PERMITKEY_LEN + 1]; //add some space for timestamp
    struct timeval mPermitKeyTime;
    bool mKeyCheck;
    double mListenerTimeout;
    int tuntapdev;
    int firstreadbytes;
    int mBounceBackBytes;
    int mBounceBackBurst;
    int mBounceBackCongestThreads; // number of congest threads
    uint32_t mBounceBackHold; // units of usecs
    struct iperf_tcpstats tcpinitstats;
#if HAVE_DECL_TCP_WINDOW_CLAMP
    int mClampSize;
#endif
#if HAVE_DECL_TCP_NOTSENT_LOWAT
    int mWritePrefetch;
#endif
};

/*
 * Thread based flags
 *
 * Due to the use of thread_Settings in C and C++
 * we are unable to use bool values. To provide
 * the functionality of bools we use the following
 * bitmask over an assumed 32 bit int. This will
 * work fine on 64bit machines we will just be ignoring
 * the upper 32bits.
 *
 * To add a flag simply define it as the next bit then
 * add the 3 support functions below.
 */
#define FLAG_BUFLENSET      0x00000001
#define FLAG_COMPAT         0x00000002
#define FLAG_DAEMON         0x00000004
#define FLAG_DOMAINV6       0x00000008
#define FLAG_FILEINPUT      0x00000010
#define FLAG_NODELAY        0x00000020
#define FLAG_PRINTMSS       0x00000040
#define FLAG_REMOVESERVICE  0x00000080
#define FLAG_STDIN          0x00000100
#define FLAG_STDOUT         0x00000200
#define FLAG_SUGGESTWIN     0x00000400
#define FLAG_UDP            0x00000800
#define FLAG_MODETIME       0x00001000
#define FLAG_REPORTSETTINGS 0x00002000
#define FLAG_MULTICAST      0x00004000
#define FLAG_NOSETTREPORT   0x00008000
#define FLAG_NOCONNREPORT   0x00010000
#define FLAG_NODATAREPORT   0x00020000
#define FLAG_NOSERVREPORT   0x00040000
#define FLAG_NOMULTREPORT   0x00080000
#define FLAG_SINGLECLIENT   0x00100000
#define FLAG_SINGLEUDP      0x00200000
#define FLAG_CONGESTION     0x00400000
#define FLAG_REALTIME       0x00800000
#define FLAG_BWSET          0x01000000
#define FLAG_ENHANCEDREPORT 0x02000000
#define FLAG_SERVERMODETIME 0x04000000
#define FLAG_SSM_MULTICAST  0x08000000
/*
 * Extended flags
 */
#define FLAG_PEERVER        0x00000001
#define FLAG_SEQNO64        0x00000002
#define FLAG_REVERSE        0x00000004
#define FLAG_ISOCHRONOUS    0x00000008
#define FLAG_UDPUNUSED      0x00000010
#define FLAG_HISTOGRAM      0x00000020
#define FLAG_L2LENGTHCHECK  0x00000100
#define FLAG_TXSTARTTIME    0x00000200
#define FLAG_INCRDSTIP      0x00000400
#define FLAG_VARYLOAD       0x00000800
#define FLAG_FQPACING       0x00001000
#define FLAG_TRIPTIME       0x00002000
#define FLAG_TXHOLDBACK     0x00004000
#define FLAG_UNUSED         0x00008000
#define FLAG_MODEINFINITE   0x00010000
#define FLAG_CONNECTONLY    0x00020000
#define FLAG_SERVERREVERSE  0x00040000
#define FLAG_FULLDUPLEX     0x00080000
#define FLAG_WRITEACK       0x00100000
#define FLAG_NOUDPFIN       0x00200000
#define FLAG_NOCONNECTSYNC  0x00400000
#define FLAG_SUMONLY        0x00800000
#define FLAG_FRAMEINTERVAL  0x01000000
#define FLAG_IPG            0x02000000
#define FLAG_DONTROUTE      0x04000000
#define FLAG_NEARCONGEST    0x08000000
#define FLAG_PERMITKEY      0x10000000
#define FLAG_SETTCPMSS      0x20000000
#define FLAG_INCRDSTPORT    0x40000000
#define FLAG_INCRSRCIP      0x80000000

/*
 * More extended flags
 */
#define FLAG_PERIODICBURST  0x00000001
#define FLAG_SUMDSTIP       0x00000002
#define FLAG_SMALLTRIPTIME  0x00000004
#define FLAG_RXCLAMP        0x00000008
#define FLAG_WRITEPREFETCH  0x00000010
#define FLAG_TUNDEV         0x00000020
#define FLAG_TAPDEV         0x00000040
#define FLAG_HIDEIPS        0x00000080
#define FLAG_BOUNCEBACK     0x00000100
#define FLAG_TCPWRITETIMES  0x00000200
#define FLAG_INCRSRCPORT    0x00000400
#define FLAG_OVERRIDETOS    0x00000800
#define FLAG_TCPQUICKACK    0x00001000
#define FLAG_WORKING_LOAD_DOWN 0x00002000
#define FLAG_WORKING_LOAD_UP 0x00004000
#define FLAG_DOMAINV4       0x00008000

#define isBuflenSet(settings)      ((settings->flags & FLAG_BUFLENSET) != 0)
#define isCompat(settings)         ((settings->flags & FLAG_COMPAT) != 0)
#define isDaemon(settings)         ((settings->flags & FLAG_DAEMON) != 0)
#define isIPV6(settings)           ((settings->flags & FLAG_DOMAINV6) != 0)
#define isIPV4(settings)           ((settings->flags_extend2 & FLAG_DOMAINV4) != 0)
#define isFileInput(settings)      ((settings->flags & FLAG_FILEINPUT) != 0)
#define isNoDelay(settings)        ((settings->flags & FLAG_NODELAY) != 0)
#define isPrintMSS(settings)       ((settings->flags & FLAG_PRINTMSS) != 0)
#define isRemoveService(settings)  ((settings->flags & FLAG_REMOVESERVICE) != 0)
#define isSTDIN(settings)          ((settings->flags & FLAG_STDIN) != 0)
#define isSTDOUT(settings)         ((settings->flags & FLAG_STDOUT) != 0)
#define isSuggestWin(settings)     ((settings->flags & FLAG_SUGGESTWIN) != 0)
#define isUDP(settings)            ((settings->flags & FLAG_UDP) != 0)
#define isModeTime(settings)       ((settings->flags & FLAG_MODETIME) != 0)
#define isReport(settings)         ((settings->flags & FLAG_REPORTSETTINGS) != 0)
#define isMulticast(settings)      ((settings->flags & FLAG_MULTICAST) != 0)
#define isSSMMulticast(settings)   ((settings->flags & FLAG_SSM_MULTICAST) != 0)
// Active Low for Reports
#define isSettingsReport(settings) ((settings->flags & FLAG_NOSETTREPORT) == 0)
#define isConnectionReport(settings)  ((settings->flags & FLAG_NOCONNREPORT) == 0)
#define isDataReport(settings)     ((settings->flags & FLAG_NODATAREPORT) == 0)
#define isServerReport(settings)   ((settings->flags & FLAG_NOSERVREPORT) == 0)
#define isMultipleReport(settings) ((settings->flags & FLAG_NOMULTREPORT) == 0)
// end Active Low
#define isSingleClient(settings)   ((settings->flags & FLAG_SINGLECLIENT) != 0)
#define isSingleUDP(settings)      ((settings->flags & FLAG_SINGLEUDP) != 0)
#define isCongestionControl(settings) ((settings->flags & FLAG_CONGESTION) != 0)
#define isRealtime(settings)       ((settings->flags & FLAG_REALTIME) != 0)
#define isBWSet(settings)          ((settings->flags & FLAG_BWSET) != 0)
#define isEnhanced(settings)       ((settings->flags & FLAG_ENHANCEDREPORT) != 0)
#define isServerModeTime(settings) ((settings->flags & FLAG_SERVERMODETIME) != 0)
#define isPeerVerDetect(settings)  ((settings->flags_extend & FLAG_PEERVER) != 0)
#define isSeqNo64b(settings)       ((settings->flags_extend & FLAG_SEQNO64) != 0)
#define isReverse(settings)        ((settings->flags_extend & FLAG_REVERSE) != 0)
#define isFullDuplex(settings)     ((settings->flags_extend & FLAG_FULLDUPLEX) != 0)
#define isServerReverse(settings)  ((settings->flags_extend & FLAG_SERVERREVERSE) != 0)
#define isIsochronous(settings)    ((settings->flags_extend & FLAG_ISOCHRONOUS) != 0)
#define isHistogram(settings)    ((settings->flags_extend & FLAG_HISTOGRAM) != 0)
#define isL2LengthCheck(settings)  ((settings->flags_extend & FLAG_L2LENGTHCHECK) != 0)
#define isIncrDstIP(settings)      ((settings->flags_extend & FLAG_INCRDSTIP) != 0)
#define isIncrSrcIP(settings)      ((settings->flags_extend & FLAG_INCRSRCIP) != 0)
#define isIncrDstPort(settings)    ((settings->flags_extend & FLAG_INCRDSTPORT) != 0)
#define isIncrSrcPort(settings)    ((settings->flags_extend2 & FLAG_INCRSRCPORT) != 0)
#define isTxStartTime(settings)    ((settings->flags_extend & FLAG_TXSTARTTIME) != 0)
#define isTxHoldback(settings)     ((settings->flags_extend & FLAG_TXHOLDBACK) != 0)
#define isVaryLoad(settings)       ((settings->flags_extend & FLAG_VARYLOAD) != 0)
#define isFQPacing(settings)       ((settings->flags_extend & FLAG_FQPACING) != 0)
#define isTripTime(settings)       ((settings->flags_extend & FLAG_TRIPTIME) != 0)
#define isSmallTripTime(settings)  ((settings->flags_extend2 & FLAG_SMALLTRIPTIME) != 0)
#define isModeInfinite(settings)   ((settings->flags_extend & FLAG_MODEINFINITE) != 0)
#define isModeAmount(settings)     (!isModeTime(settings) && !isModeInfinite(settings))
#define isConnectOnly(settings)    ((settings->flags_extend & FLAG_CONNECTONLY) != 0)
#define isWriteAck(settings)       ((settings->flags_extend & FLAG_WRITEACK) != 0)
#define isNoUDPfin(settings)       ((settings->flags_extend & FLAG_NOUDPFIN) != 0)
#define isNoConnectSync(settings)  ((settings->flags_extend & FLAG_NOCONNECTSYNC) != 0)
#define isSumOnly(settings)        ((settings->flags_extend & FLAG_SUMONLY) != 0)
#define isFrameInterval(settings)  ((settings->flags_extend & FLAG_FRAMEINTERVAL) != 0)
#define isIPG(settings)  ((settings->flags_extend & FLAG_IPG) != 0)
#define isDontRoute(settings)      ((settings->flags_extend & FLAG_DONTROUTE) != 0)
#define isNearCongest(settings)    ((settings->flags_extend & FLAG_NEARCONGEST) != 0)
#define isPermitKey(settings)  ((settings->flags_extend & FLAG_PERMITKEY) != 0)
#define isTCPMSS(settings)         ((settings->flags_extend & FLAG_SETTCPMSS) != 0)
#define isPeriodicBurst(settings)  ((settings->flags_extend2 & FLAG_PERIODICBURST) != 0)
#define isSumServerDstIP(settings) ((settings->flags_extend2 & FLAG_SUMDSTIP) != 0)
#define isRxClamp(settings)        ((settings->flags_extend2 & FLAG_RXCLAMP) != 0)
#define isWritePrefetch(settings) ((settings->flags_extend2 & FLAG_WRITEPREFETCH) != 0)
#define isTapDev(settings)         ((settings->flags_extend2 & FLAG_TAPDEV) != 0)
#define isTunDev(settings)         ((settings->flags_extend2 & FLAG_TUNDEV) != 0)
#define isHideIPs(settings)        ((settings->flags_extend2 & FLAG_HIDEIPS) != 0)
#define isBounceBack(settings)     ((settings->flags_extend2 & FLAG_BOUNCEBACK) != 0)
#define isTcpWriteTimes(settings)  ((settings->flags_extend2 & FLAG_TCPWRITETIMES) != 0)
#define isOverrideTOS(settings)    ((settings->flags_extend2 & FLAG_OVERRIDETOS) != 0)
#define isTcpQuickAck(settings)    ((settings->flags_extend2 & FLAG_TCPQUICKACK) != 0)
#define isWorkingLoadUp(settings)  ((settings->flags_extend2 & FLAG_WORKING_LOAD_UP) != 0)
#define isWorkingLoadDown(settings)  ((settings->flags_extend2 & FLAG_WORKING_LOAD_DOWN) != 0)

#define setBuflenSet(settings)     settings->flags |= FLAG_BUFLENSET
#define setCompat(settings)        settings->flags |= FLAG_COMPAT
#define setDaemon(settings)        settings->flags |= FLAG_DAEMON
#define setIPV6(settings)          settings->flags |= FLAG_DOMAINV6
#define setIPV4(settings)          settings->flags_extend2 |= FLAG_DOMAINV4
#define setFileInput(settings)     settings->flags |= FLAG_FILEINPUT
#define setNoDelay(settings)       settings->flags |= FLAG_NODELAY
#define setPrintMSS(settings)      settings->flags |= FLAG_PRINTMSS
#define setRemoveService(settings) settings->flags |= FLAG_REMOVESERVICE
#define setSTDIN(settings)         settings->flags |= FLAG_STDIN
#define setSTDOUT(settings)        settings->flags |= FLAG_STDOUT
#define setSuggestWin(settings)    settings->flags |= FLAG_SUGGESTWIN
#define setUDP(settings)           settings->flags |= FLAG_UDP
#define setModeTime(settings)      settings->flags |= FLAG_MODETIME
#define setReport(settings)        settings->flags |= FLAG_REPORTSETTINGS
#define setMulticast(settings)     settings->flags |= FLAG_MULTICAST
#define setSSMMulticast(settings)  settings->flags |= FLAG_SSM_MULTICAST
#define setNoSettReport(settings)  settings->flags |= FLAG_NOSETTREPORT
#define setNoConnReport(settings)  settings->flags |= FLAG_NOCONNREPORT
#define setNoDataReport(settings)  settings->flags |= FLAG_NODATAREPORT
#define setNoServReport(settings)  settings->flags |= FLAG_NOSERVREPORT
#define setNoMultReport(settings)  settings->flags |= FLAG_NOMULTREPORT
#define setSingleClient(settings)  settings->flags |= FLAG_SINGLECLIENT
#define setSingleUDP(settings)     settings->flags |= FLAG_SINGLEUDP
#define setCongestionControl(settings) settings->flags |= FLAG_CONGESTION
#define setRealtime(settings)      settings->flags |= FLAG_REALTIME
#define setBWSet(settings)         settings->flags |= FLAG_BWSET
#define setEnhanced(settings)      settings->flags |= FLAG_ENHANCEDREPORT
#define setServerModeTime(settings)    settings->flags |= FLAG_SERVERMODETIME
#define setPeerVerDetect(settings) settings->flags_extend |= FLAG_PEERVER
#define setSeqNo64b(settings)      settings->flags_extend |= FLAG_SEQNO64
#define setReverse(settings)       settings->flags_extend |= FLAG_REVERSE
#define setFullDuplex(settings)    settings->flags_extend |= FLAG_FULLDUPLEX
#define setServerReverse(settings) settings->flags_extend |= FLAG_SERVERREVERSE
#define setIsochronous(settings)   settings->flags_extend |= FLAG_ISOCHRONOUS
#define setHistogram(settings)   settings->flags_extend |= FLAG_HISTOGRAM
#define setL2LengthCheck(settings) settings->flags_extend |= FLAG_L2LENGTHCHECK
#define setIncrDstIP(settings)     settings->flags_extend |= FLAG_INCRDSTIP
#define setIncrSrcIP(settings)     settings->flags_extend |= FLAG_INCRSRCIP
#define setIncrDstPort(settings)   settings->flags_extend |= FLAG_INCRDSTPORT
#define setIncrSrcPort(settings)   settings->flags_extend2 |= FLAG_INCRSRCPORT
#define setTxStartTime(settings)   settings->flags_extend |= FLAG_TXSTARTTIME
#define setTxHoldback(settings)    settings->flags_extend |= FLAG_TXHOLDBACK
#define setVaryLoad(settings)      settings->flags_extend |= FLAG_VARYLOAD
#define setFQPacing(settings)      settings->flags_extend |= FLAG_FQPACING
#define setTripTime(settings)      settings->flags_extend |= FLAG_TRIPTIME
#define setSmallTripTime(settings) settings->flags_extend2 |= FLAG_SMALLTRIPTIME
#define setModeInfinite(settings)  settings->flags_extend |= FLAG_MODEINFINITE
#define setConnectOnly(settings)   settings->flags_extend |= FLAG_CONNECTONLY
#define setWriteAck(settings)      settings->flags_extend |= FLAG_WRITEACK
#define setNoUDPfin(settings)      settings->flags_extend |= FLAG_NOUDPFIN
#define setNoConnectSync(settings) settings->flags_extend |= FLAG_NOCONNECTSYNC
#define setSumOnly(settings)       settings->flags_extend |= FLAG_SUMONLY
#define setFrameInterval(settings) settings->flags_extend |= FLAG_FRAMEINTERVAL
#define setIPG(settings)           settings->flags_extend |= FLAG_IPG
#define setDontRoute(settings)     settings->flags_extend |= FLAG_DONTROUTE
#define setNearCongest(settings)   settings->flags_extend |= FLAG_NEARCONGEST
#define setPermitKey(settings)     settings->flags_extend |= FLAG_PERMITKEY
#define setTCPMSS(settings)        settings->flags_extend |= FLAG_SETTCPMSS
#define setPeriodicBurst(settings) settings->flags_extend2 |= FLAG_PERIODICBURST
#define setSumServerDstIP(settings) settings->flags_extend2 |= FLAG_SUMDSTIP
#define setRxClamp(settings)       settings->flags_extend2 |= FLAG_RXCLAMP
#define setWritePrefetch(settings) settings->flags_extend2 |= FLAG_WRITEPREFETCH
#define setTapDev(settings)        settings->flags_extend2 |= FLAG_TAPDEV
#define setTunDev(settings)        settings->flags_extend2 |= FLAG_TUNDEV
#define setHideIPs(settings)       settings->flags_extend2 |= FLAG_HIDEIPS
#define setBounceBack(settings)    settings->flags_extend2 |= FLAG_BOUNCEBACK
#define setTcpWriteTimes(settings) settings->flags_extend2 |= FLAG_TCPWRITETIMES
#define setOverrideTOS(settings)   settings->flags_extend2 |= FLAG_OVERRIDETOS
#define setTcpQuickAck(settings)   settings->flags_extend2 |= FLAG_TCPQUICKACK
#define setWorkingLoadUp(settings)   settings->flags_extend2 |= FLAG_WORKING_LOAD_UP
#define setWorkingLoadDown(settings) settings->flags_extend2 |= FLAG_WORKING_LOAD_DOWN

#define unsetBuflenSet(settings)   settings->flags &= ~FLAG_BUFLENSET
#define unsetCompat(settings)      settings->flags &= ~FLAG_COMPAT
#define unsetDaemon(settings)      settings->flags &= ~FLAG_DAEMON
#define unsetIPV6(settings)        settings->flags &= ~FLAG_DOMAINV6
#define unsetIPV4(settings)        settings->flags_extend2 &= ~FLAG_DOMAINV4
#define unsetFileInput(settings)   settings->flags &= ~FLAG_FILEINPUT
#define unsetNoDelay(settings)     settings->flags &= ~FLAG_NODELAY
#define unsetPrintMSS(settings)    settings->flags &= ~FLAG_PRINTMSS
#define unsetRemoveService(settings)  settings->flags &= ~FLAG_REMOVESERVICE
#define unsetSTDIN(settings)       settings->flags &= ~FLAG_STDIN
#define unsetSTDOUT(settings)      settings->flags &= ~FLAG_STDOUT
#define unsetSuggestWin(settings)  settings->flags &= ~FLAG_SUGGESTWIN
#define unsetUDP(settings)         settings->flags &= ~FLAG_UDP
#define unsetModeTime(settings)    settings->flags &= ~FLAG_MODETIME
#define unsetReport(settings)      settings->flags &= ~FLAG_REPORTSETTINGS
#define unsetMulticast(settings)   settings->flags &= ~FLAG_MULTICAST
#define unsetSSMMulticast(settings)   settings->flags &= ~FLAG_SSM_MULTICAST
#define unsetNoSettReport(settings)   settings->flags &= ~FLAG_NOSETTREPORT
#define unsetNoConnReport(settings)   settings->flags &= ~FLAG_NOCONNREPORT
#define unsetNoDataReport(settings)   settings->flags &= ~FLAG_NODATAREPORT
#define unsetNoServReport(settings)   settings->flags &= ~FLAG_NOSERVREPORT
#define unsetNoMultReport(settings)   settings->flags &= ~FLAG_NOMULTREPORT
#define unsetSingleClient(settings)   settings->flags &= ~FLAG_SINGLECLIENT
#define unsetSingleUDP(settings)      settings->flags &= ~FLAG_SINGLEUDP
#define unsetCongestionControl(settings) settings->flags &= ~FLAG_CONGESTION
#define unsetRealtime(settings)    settings->flags &= ~FLAG_REALTIME
#define unsetBWSet(settings)       settings->flags &= ~FLAG_BWSET
#define unsetEnhanced(settings)    settings->flags &= ~FLAG_ENHANCEDREPORT
#define unsetServerModeTime(settings) settings->flags &= ~FLAG_SERVERMODETIME
#define unsetPeerVerDetect(settings)  settings->flags_extend &= ~FLAG_PEERVER
#define unsetSeqNo64b(settings)    settings->flags_extend &= ~FLAG_SEQNO64
#define unsetReverse(settings)     settings->flags_extend &= ~FLAG_REVERSE
#define unsetFullDuplex(settings)  settings->flags_extend &= ~FLAG_FULLDUPLEX
#define unsetServerReverse(settings) settings->flags_extend &= ~FLAG_SERVERREVERSE
#define unsetIsochronous(settings)  settings->flags_extend &= ~FLAG_ISOCHRONOUS
#define unsetHistogram(settings)  settings->flags_extend &= ~FLAG_HISTOGRAM
#define unsetL2LengthCheck(settings)  settings->flags_extend &= ~FLAG_L2LENGTHCHECK
#define unsetIncrDstIP(settings)    settings->flags_extend &= ~FLAG_INCRDSTIP
#define unsetIncrSrcIP(settings)    settings->flags_extend &= ~FLAG_INCRSRCIP
#define unsetIncrDstPort(settings)  settings->flags_extend &= ~FLAG_INCRDSTPORT
#define unsetIncrSrcPort(settings)  settings->flags_extend2 &= ~FLAG_INCRSRCPORT
#define unsetTxStartTime(settings)  settings->flags_extend &= ~FLAG_TXSTARTTIME
#define unsetTxHoldback(settings)   settings->flags_extend &= ~FLAG_TXHOLDBACK
#define unsetVaryLoad(settings)     settings->flags_extend &= ~FLAG_VARYLOAD
#define unsetFQPacing(settings)     settings->flags_extend &= ~FLAG_FQPACING
#define unsetTripTime(settings)     settings->flags_extend &= ~FLAG_TRIPTIME
#define unsetSmallTripTime(settings) settings->flags_extend2 &= ~FLAG_SMALLTRIPTIME
#define unsetModeInfinite(settings) settings->flags_extend &= ~FLAG_MODEINFINITE
#define unsetConnectOnly(settings)  settings->flags_extend &= ~FLAG_CONNECTONLY
#define unsetWriteAck(settings)     settings->flags_extend &= ~FLAG_WRITEACK
#define unsetNoUDPfin(settings)     settings->flags_extend &= ~FLAG_NOUDPFIN
#define unsetNoConnectSync(settings) settings->flags_extend &= ~FLAG_NOCONNECTSYNC
#define unsetSumOnly(settings)       settings->flags_extend &= ~FLAG_SUMONLY
#define unsetFrameInterval(settings) settings->flags_extend &= ~FLAG_FRAMEINTERVAL
#define unsetIPG(settings)           settings->flags_extend &= ~FLAG_IPG
#define unsetDontRoute(settings)     settings->flags_extend &= ~FLAG_DONTROUTE
#define unsetPermitKey(settings)     settings->flags_extend &= ~FLAG_PERMITKEY
#define unsetTCPMSS(settings)        settings->flags_extend &= ~FLAG_SETTCPMSS
#define unsetPeriodicBurst(settings) settings->flags_extend2 &= ~FLAG_PERIODICBURST
#define unsetSumServerDstIP(settings) settings->flags_extend2 &= ~FLAG_SUMDSTIP
#define unsetRxClamp(settings)       settings->flags_extend2 &= ~FLAG_RXCLAMP
#define unsetWritePrefetch(settings) settings->flags_extend2 &= ~FLAG_WRITEPREFETCH
#define unsetTapDev(settings)        settings->flags_extend2 &= ~FLAG_TAPDEV
#define unsetTunDev(settings)        settings->flags_extend2 &= ~FLAG_TUNDEV
#define unsetHideIPs(settings)       settings->flags_extend2 &= ~FLAG_HIDEIPS
#define unsetBounceBack(settings)    settings->flags_extend2 &= ~FLAG_BOUNCEBACK
#define unsetTcpWriteTimes(settings) settings->flags_extend2 &= ~FLAG_TCPWRITETIMES
#define unsetOverrideTOS(settings)   settings->flags_extend2 &= ~FLAG_OVERRIDETOS
#define unsetTcpQuickAck(settings)   settings->flags_extend2 &= ~FLAG_TCPQUICKACK
#define unsetWorkingLoadUp(settings)   settings->flags_extend2 &= ~FLAG_WORKING_LOAD_UP
#define unsetWorkingLoadDown(settings) settings->flags_extend2 &= ~FLAG_WORKING_LOAD_DOWN

// set to defaults
void Settings_Initialize(struct thread_Settings* main);

// copy structure
void Settings_Copy(struct thread_Settings* from, struct thread_Settings** into, int copyall);

// free associated memory
void Settings_Destroy(struct thread_Settings *mSettings);

// parse settings from user's environment variables
void Settings_ParseEnvironment(struct thread_Settings *mSettings);

// parse settings from app's command line
void Settings_ParseCommandLine(int argc, char **argv, struct thread_Settings *mSettings);

// convert to lower case for [KMG]bits/sec
void Settings_GetLowerCaseArg(const char *,char *);

// convert to upper case for [KMG]bytes/sec
void Settings_GetUpperCaseArg(const char *,char *);

// generate settings for listener instance
void Settings_GenerateListenerSettings(struct thread_Settings *client, struct thread_Settings **listener);

// generate settings for speaker instance
void Settings_GenerateClientSettings(struct thread_Settings *server, struct thread_Settings **client, void * mBuf);

// generate client header for server
int Settings_GenerateClientHdr(struct thread_Settings *client, void * hdr, struct timeval startTime);

int Settings_ClientTestHdrLen(uint32_t flags, struct thread_Settings *inSettings);

#ifdef __cplusplus
} /* end extern "C" */
#endif

#endif // SETTINGS_H
