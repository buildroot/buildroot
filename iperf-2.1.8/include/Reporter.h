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
 * Reporter.h
 * by Kevin Gibbs <kgibbs@nlanr.net>
 *
 * Since version 2.0 this handles all reporting.
 * ________________________________________________________________ */

#ifndef REPORTER_H
#define REPORTER_H

#include "headers.h"
#include "Mutex.h"
#include "histogram.h"
#include "packet_ring.h"
#include "gettcpinfo.h"

// forward declarations found in Settings.hpp
struct thread_Settings;
struct server_hdr;

#include "Settings.hpp"

#define NUM_REPORT_STRUCTS 10000
#define PEERVERBUFSIZE 256
#define NETPOWERCONSTANT 1e-6
#define REPORTTXTMAX 80
#define MINBARRIERTIMEOUT 3
#define PARTIALPERCENT 0.25 // used to decide if a final partial report should be displayed
// If the minimum latency exceeds the boundaries below
// assume the clocks are not synched and suppress the
// latency output. Units are seconds
#define UNREALISTIC_LATENCYMINMIN -0.01*1e6
#define UNREALISTIC_LATENCYMINMAX 60*1e6

#ifdef __cplusplus
extern "C" {
#endif

extern struct Condition ReportCond;
extern struct Condition ReportsPending;
extern int groupID;
extern Mutex transferid_mutex;

/*
 *
 * Used for end/end latency measurements
 *
 */

struct MeanMinMaxStats {
    double max;
    double min;
    double sum;
    double last;
    double mean;
    double m2;
    double vd;
    intmax_t cnt;
    intmax_t err;
};

#define TCPREADBINCOUNT 8
struct ReadStats {
    intmax_t cntRead;
    intmax_t totcntRead;
    int bins[TCPREADBINCOUNT];
    int totbins[TCPREADBINCOUNT];
    int binsize;
};

struct WriteStats {
    intmax_t WriteCnt;
    intmax_t WriteErr;
    intmax_t totWriteCnt;
    intmax_t totWriteErr;
    struct iperf_tcpstats tcpstats;
};

/*
 * This struct contains all important information from the sending or
 * recieving thread.
 */
#define L2UNKNOWN  0x01
#define L2LENERR   0x02
#define L2CSUMERR  0x04

enum WriteErrType {
    WriteNoErr  = 0,
    WriteErrAccount,
    WriteErrFatal,
    WriteErrNoAccount,
};

struct L2Stats {
    intmax_t cnt;
    intmax_t unknown;
    intmax_t udpcsumerr;
    intmax_t lengtherr;
    intmax_t tot_cnt;
    intmax_t tot_unknown;
    intmax_t tot_udpcsumerr;
    intmax_t tot_lengtherr;
};

struct RunningMMMStats {
    struct MeanMinMaxStats current;
    struct MeanMinMaxStats total;
};
/*
 * The type field of ReporterData is a bitmask
 * with one or more of the following
 */
enum ReportType {
    DATA_REPORT = 1,
    SUM_REPORT,
    SETTINGS_REPORT,
    CONNECTION_REPORT,
    SERVER_RELAY_REPORT
};

enum ReportSubType {
    FULLDUPLEXSUM_REPORT = 1,
    HOSTSUM_REPORT,
    TOTALSUM_REPORT
};

union SendReadStats {
    struct ReadStats read;
    struct WriteStats write;
};

// This attributes are shared by all reports
// deep copies are made when creating a new report
// rather than using references
struct ReportCommon {
    enum ThreadMode ThreadMode;
    enum ReportMode ReportMode;
    bool KeyCheck;
    int flags;
    int flags_extend;
    int flags_extend2;
    int threads;
    unsigned short Port;
    unsigned short PortLast;
    unsigned short BindPort;
    unsigned short ListenPort;
    intmax_t AppRate;            // -b or -u
    uint32_t BurstSize;
    int AppRateUnits;
    char Format;
    int TTL;
    int BufLen;
    int MSS;
    int TCPWin;
    int TOS;
    int RTOS;
#if HAVE_DECL_TCP_WINDOW_CLAMP
    int ClampSize;
#endif
#if HAVE_DECL_TCP_NOTSENT_LOWAT
    int WritePrefetch;
#endif
    int winsize_requested;
    unsigned int FQPacingRate;
    int HistBins;
    int HistBinsize;
    int HistUnits;
    double pktIPG;
    iperf_sockaddr peer;
    Socklen_t size_peer;
    iperf_sockaddr local;
    Socklen_t size_local;
    char* Host;                   // -c
    char* HideHost;
    char* Localhost;              // -B
    char* Ifrname;
    char* Ifrnametx;
    char* SSMMulticastStr;
    char* Congestion;
    char* transferIDStr;
    char* PermitKey;
    int transferID;
    double rtt_weight;
    double ListenerTimeout;
    double FPS;
    int bbsize;
    int bbhold;
    int bbcount;
#if WIN32
    SOCKET socket;
#else
    int socket;
#if defined(HAVE_LINUX_FILTER_H) && defined(HAVE_AF_PACKET)
    int socketdrop;
#endif
#endif
};

struct ConnectionInfo {
    struct ReportCommon *common;
    struct timeval connect_timestamp;
    struct timeval txholdbacktime;
    struct timeval epochStartTime;
    int winsize;
    char peerversion[PEERVERBUFSIZE];
    struct MeanMinMaxStats connect_times;
    struct iperf_tcpstats tcpinitstats;
};

struct ShiftIntCounter {
    intmax_t current;
    intmax_t prev;
};

struct ShiftUintCounter {
    uintmax_t current;
    uintmax_t prev;
};

struct ShiftCounters {
    struct ShiftUintCounter Bytes;
    struct ShiftIntCounter Lost;
    struct ShiftIntCounter OutofOrder;
    struct ShiftIntCounter Datagrams;
    struct ShiftIntCounter IPG;
};

struct IsochStats {
    double mFPS; //frames per second
    double mMean; //variable bit rate mean
    double mVariance; //vbr variance
    int mJitterBufSize; //Server jitter buffer size, units is frames
    uintmax_t cntFrames;
    uintmax_t cntFramesMissed;
    uintmax_t cntSlips;
    struct ShiftUintCounter slipcnt;
    struct ShiftUintCounter framecnt;
    struct ShiftUintCounter framelostcnt;
    unsigned int mBurstInterval;
    unsigned int mBurstIPG; //IPG of packets within the burst
    uint32_t frameID;
    struct RunningMMMStats transit;
};

struct ReportSettings {
    struct ReportCommon *common;
    iperf_sockaddr peer;
    Socklen_t size_peer;
    iperf_sockaddr local;
    Socklen_t size_local;
    int pid;
    int sockmaxseg;
    struct IsochStats isochstats;
    void (*output_handler) (struct ReportSettings *settings);
};

// Timestamps
enum TimeStampType {
    INTERVAL  = 0,
    FINALPARTIAL,
    TOTAL,
    INTERVALPARTIAL
};

struct ReportTimeStamps {
    double iStart;
    double iEnd;
    double significant_partial;
    struct timeval startTime;
    struct timeval matchTime;
    struct timeval packetTime;
    struct timeval prevpacketTime;
    struct timeval prevsendTime;
    struct timeval nextTime;
    struct timeval intervalTime;
    struct timeval IPGstart;
    struct timeval nextTCPSampleTime;
};

struct TransferInfo {
    struct ReportCommon *common;
    struct ReportTimeStamps ts;
    void (*output_handler) (struct TransferInfo *stats);
    int groupID;
    int threadcnt;
    bool isMaskOutput;
    uintmax_t cntBytes;
    intmax_t cntError;
    intmax_t cntOutofOrder;
    intmax_t cntDatagrams;
    intmax_t cntIPG;
    intmax_t PacketID;
    double jitter;
    double IPGsum;
    struct ShiftCounters total; // Shift counters used to calculate interval reports and hold totals
    union SendReadStats sock_callstats;
    struct IsochStats isochstats;
    struct histogram *latency_histogram;
    struct RunningMMMStats transit;
    struct histogram *framelatency_histogram;
    struct RunningMMMStats frame; // isochronous frame or msg burst
    struct histogram *bbrtt_histogram;
    struct RunningMMMStats bbrtt;
    struct RunningMMMStats bbowdto;
    struct RunningMMMStats bbowdfro;
    struct RunningMMMStats bbasym;
    struct L2Stats l2counts;
    // Packet and frame state info
    uint32_t matchframeID;
    uint32_t frameID;
    char csv_peer[CSVPEERLIMIT];
    bool final;
    bool burstid_transition;
    bool isEnableTcpInfo;
    struct RunningMMMStats write_mmm;
    struct histogram *write_histogram;
    double iBBrunning;
    double fBBrunning;
};

struct SumReport {
    struct ReferenceMutex reference;
    int threads;
    struct TransferInfo info;
    void (*transfer_protocol_sum_handler) (struct TransferInfo *stats, int final);
    struct BarrierMutex fullduplex_barrier;
    int sum_fd_set;
};

struct ReporterData {
    // function pointer for per packet processing
    void (*packet_handler_pre_report) (struct ReporterData *data, struct ReportStruct *packet);
    void (*packet_handler_post_report) (struct ReporterData *data, struct ReportStruct *packet);
    void (*transfer_protocol_handler) (struct ReporterData *data, int final);
    int (*transfer_interval_handler) (struct ReporterData *data, struct ReportStruct *packet);

    struct PacketRing *packetring;
    int reporter_thread_suspends; // used to detect CPU bound systems

    // group sum and full duplext reports
    struct SumReport *GroupSumReport;
    struct SumReport *FullDuplexReport;
    struct TransferInfo info;
};

struct ServerRelay {
    struct TransferInfo info;
    iperf_sockaddr peer;
    Socklen_t size_peer;
    iperf_sockaddr local;
    Socklen_t size_local;
};

struct ReportHeader {
    enum ReportType type;
    enum ReportMode ReportMode;
    void *this_report;
    struct ReportHeader *next;
};

typedef void* (* report_connection)( struct ConnectionInfo*, int );
typedef void (* report_settings)( struct ReporterData* );
typedef void (* report_statistics)( struct TransferInfo* );
typedef void (* report_serverstatistics)( struct ConnectionInfo *, struct TransferInfo* );

void SetSumHandlers (struct thread_Settings *inSettings, struct SumReport* sumreport);
struct SumReport* InitSumReport(struct thread_Settings *inSettings, int inID, int fullduplex);
struct ReportHeader* InitIndividualReport(struct thread_Settings *inSettings);
struct ReportHeader* InitConnectionReport(struct thread_Settings *inSettings);
struct ConnectionInfo* InitConnectOnlyReport(struct thread_Settings *thread);
struct ReportHeader *InitSettingsReport(struct thread_Settings *inSettings);
struct ReportHeader* InitServerRelayUDPReport(struct thread_Settings *inSettings, struct server_hdr *server);
void PostReport(struct ReportHeader *reporthdr);
bool ReportPacket (struct ReporterData* data, struct ReportStruct *packet);
int EndJob(struct ReportHeader *reporthdr,  struct ReportStruct *packet);
void FreeReport(struct ReportHeader *reporthdr);
void FreeSumReport (struct SumReport *sumreport);
void FreeConnectionReport(struct ConnectionInfo *reporthdr);
void ReportServerUDP(struct thread_Settings *inSettings, struct server_hdr *server);
void ReportConnections(struct thread_Settings *inSettings );
void reporter_dump_job_queue(void);
void IncrSumReportRefCounter(struct SumReport *sumreport);
int DecrSumReportRefCounter(struct SumReport *sumreport);

extern struct AwaitMutex reporter_state;
extern struct AwaitMutex threads_start;

extern report_connection connection_reports[];
extern report_settings settings_reports[];
extern report_statistics statistics_reports[];
extern report_serverstatistics serverstatistics_reports[];
extern report_statistics multiple_reports[];


// The packet or read/write accounting routines used by the reporter thread
// They're function vectors called from the reporter loop via
// this_ireport->packet_handler_pre_report or this_ireport->packet_handler_post_report
// The vectors are set during report instantiation in Reports.c
// Note that client packet handling is the same for TCP and UDP
void reporter_handle_packet_null(struct ReporterData *data, struct ReportStruct *packet);
void reporter_handle_packet_client(struct ReporterData *data, struct ReportStruct *packet);
void reporter_handle_packet_server_udp(struct ReporterData *data, struct ReportStruct *packet);
void reporter_handle_packet_server_tcp(struct ReporterData *data, struct ReportStruct *packet);
void reporter_handle_packet_bb_client(struct ReporterData *data, struct ReportStruct *packet);
void reporter_handle_packet_bb_server(struct ReporterData *data, struct ReportStruct *packet);

// Reporter thread's conditional prints of interval reports
// Invoked from the Reporter thread per function vector this_ireport->transfer_interval_handler
// This is set during Report instantiation (found in Reports.c)
// These conditionally, e.g per a sample interval, invoke the transfer protocol handlers
int reporter_condprint_time_interval_report(struct ReporterData *data, struct ReportStruct *packet);
int reporter_condprint_frame_interval_report_client_udp(struct ReporterData *data, struct ReportStruct *packet);
int reporter_condprint_frame_interval_report_server_udp(struct ReporterData *data, struct ReportStruct *packet);
int reporter_condprint_frame_interval_report_server_tcp(struct ReporterData *data, struct ReportStruct *packet);
int reporter_condprint_frame_interval_report_client_tcp(struct ReporterData *data, struct ReportStruct *packet);
int reporter_condprint_burst_interval_report_client_udp(struct ReporterData *data, struct ReportStruct *packet);
int reporter_condprint_burst_interval_report_server_udp(struct ReporterData *data, struct ReportStruct *packet);
int reporter_condprint_burst_interval_report_server_tcp(struct ReporterData *data, struct ReportStruct *packet);
int reporter_condprint_burst_interval_report_client_tcp(struct ReporterData *data, struct ReportStruct *packet);

// Each report type needs specialized updating prior to printing its report
// These functions realize that updating. They are called by the transfer protocol handler,
// e.g. (*data->transfer_protocol_handler)(data, 0) found in src/Reporter.c
// These update the TransferInfo stats struct which is used during output (e.g. the output handler)
void reporter_transfer_protocol_null(struct ReporterData *data, int final);
void reporter_transfer_protocol_client_tcp(struct ReporterData *data, int final);
void reporter_transfer_protocol_client_bb_tcp(struct ReporterData *data, int final);
void reporter_transfer_protocol_client_udp(struct ReporterData *data, int final);
void reporter_transfer_protocol_server_tcp(struct ReporterData *data, int final);
void reporter_transfer_protocol_server_bb_tcp(struct ReporterData *data, int final);
void reporter_transfer_protocol_server_udp(struct ReporterData *data, int final);
// Function vectors to suppport sum reports
void reporter_transfer_protocol_sum_client_tcp(struct TransferInfo *stats, int final);
void reporter_transfer_protocol_sum_server_tcp(struct TransferInfo *stats, int final);
void reporter_transfer_protocol_sum_client_udp(struct TransferInfo *stats, int final);
void reporter_transfer_protocol_sum_server_udp(struct TransferInfo *stats, int final);
void reporter_transfer_protocol_fullduplex_tcp(struct TransferInfo *stats, int final);
void reporter_transfer_protocol_fullduplex_udp(struct TransferInfo *stats, int final);

// Report output print routines invoked by the transfer_protocol handler
// Bound in Report instantiation and invoked by the transfer protocol
// handler, using (*stats->output_handler)(stats)
// TCP server
void tcp_output_read(struct TransferInfo *stats);
void tcp_output_read_enhanced(struct TransferInfo *stats);
void tcp_output_read_triptime(struct TransferInfo *stats);
void tcp_output_sum_read(struct TransferInfo *stats);
void tcp_output_sum_read_enhanced(struct TransferInfo *stats);
void tcp_output_sumcnt_read(struct TransferInfo *stats);
void tcp_output_sumcnt_read_enhanced (struct TransferInfo *stats);
void tcp_output_frame_read(struct TransferInfo *stats);
void tcp_output_frame_read_triptime(struct TransferInfo *stats);
void tcp_output_burst_read(struct TransferInfo *stats);
void tcp_output_read_enhanced_isoch(struct TransferInfo *stats);
// TCP client
void tcp_output_write(struct TransferInfo *stats);
void tcp_output_burst_write(struct TransferInfo *stats);
void tcp_output_sum_write(struct TransferInfo *stats);
void tcp_output_sumcnt_write(struct TransferInfo *stats);
void tcp_output_write_enhanced (struct TransferInfo *stats);
void tcp_output_write_enhanced_isoch (struct TransferInfo *stats);
void tcp_output_sum_write_enhanced (struct TransferInfo *stats);
void tcp_output_sumcnt_write_enhanced (struct TransferInfo *stats);
void tcp_output_write_enhanced_write (struct TransferInfo *stats);
void tcp_output_write_bb(struct TransferInfo *stats);
// TCP fullduplex
void tcp_output_fullduplex(struct TransferInfo *stats);
void tcp_output_fullduplex_enhanced(struct TransferInfo *stats);
void tcp_output_fullduplex_sum (struct TransferInfo *stats);
// UDP server
void udp_output_read(struct TransferInfo *stats);
void udp_output_read_triptime(struct TransferInfo *stats);
void udp_output_read_triptime_isoch(struct TransferInfo *stats);
void udp_output_sum_read(struct TransferInfo *stats);
void udp_output_sum_read_enhanced (struct TransferInfo *stats);
void udp_output_sumcnt(struct TransferInfo *stats);
void udp_output_sumcnt_read_enhanced (struct TransferInfo *stats);
//UDP client
void udp_output_write(struct TransferInfo *stats);
void udp_output_sum_write(struct TransferInfo *stats);
void udp_output_write_enhanced(struct TransferInfo *stats);
void udp_output_write_enhanced_isoch(struct TransferInfo *stats);
void udp_output_sum_write_enhanced (struct TransferInfo *stats);
void udp_output_sumcnt_write(struct TransferInfo *stats);
void udp_output_sumcnt_write_enhanced (struct TransferInfo *stats);
void udp_output_sumcnt_enhanced(struct TransferInfo *stats);
// UDP full duplex
void udp_output_fullduplex(struct TransferInfo *stats);
void udp_output_fullduplex_enhanced(struct TransferInfo *stats);
void udp_output_fullduplex_sum(struct TransferInfo *stats);

// CSV output
void udp_output_basic_csv(struct TransferInfo *stats);
void tcp_output_basic_csv(struct TransferInfo *stats);

// The report output routines that are simpler and aren't related to stats
void reporter_print_connection_report(struct ConnectionInfo *report);
void reporter_print_settings_report(struct ReportSettings *report);
void reporter_print_server_relay_report(struct ServerRelay *report);
void reporter_peerversion (struct ConnectionInfo *report, uint32_t upper, uint32_t lower);
void PrintMSS(struct ReporterData *data);
void reporter_default_heading_flags(int);
void reporter_connect_printf_tcp_final(struct ConnectionInfo *report);

void write_UDP_AckFIN(struct TransferInfo *stats, int len);

int reporter_process_transfer_report (struct ReporterData *this_ireport);
int reporter_process_report (struct ReportHeader *reporthdr);

void setTransferID(struct thread_Settings *inSettings, int role_reversal);

#ifdef __cplusplus
} /* end extern "C" */
#endif

#endif // REPORTER_H
