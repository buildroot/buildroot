
/*---------------------------------------------------------------
 * Copyright (c) 1999,2000,2001,2002,2003
 * The Board of Trustees of the University of Illinois
 * All Rights Reserved.
 *---------------------------------------------------------------
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software (Iperf) and associated
 * documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
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
 * Reporter.c
 * by Kevin Gibbs <kgibbs@nlanr.net>
 *
 * Major rewrite by Robert McMahon (Sept 2020, ver 2.0.14)
 * ________________________________________________________________ */

#include <math.h>
#include "headers.h"
#include "Settings.hpp"
#include "util.h"
#include "Reporter.h"
#include "Thread.h"
#include "Locale.h"
#include "PerfSocket.hpp"
#include "SocketAddr.h"
#include "histogram.h"
#include "delay.h"
#include "packet_ring.h"
#include "payloads.h"
#include "gettcpinfo.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef INITIAL_PACKETID
# define INITIAL_PACKETID 0
#endif

struct ReportHeader *ReportRoot = NULL;
struct ReportHeader *ReportPendingHead = NULL;
struct ReportHeader *ReportPendingTail = NULL;

// Reporter's reset of stats after a print occurs
static void reporter_reset_transfer_stats_client_tcp(struct TransferInfo *stats);
static void reporter_reset_transfer_stats_client_udp(struct TransferInfo *stats);
static void reporter_reset_transfer_stats_server_udp(struct TransferInfo *stats);
static void reporter_reset_transfer_stats_server_tcp(struct TransferInfo *stats);

// code for welfornd's algorithm to produce running mean/min/max/var
static void reporter_update_mmm (struct MeanMinMaxStats *stats, double value);
static void reporter_reset_mmm (struct MeanMinMaxStats *stats);


// one way delay (OWD) calculations
static void reporter_handle_packet_oneway_transit(struct TransferInfo *stats, struct ReportStruct *packet);
static void reporter_handle_isoch_oneway_transit_tcp(struct TransferInfo *stats, struct ReportStruct *packet);
static void reporter_handle_isoch_oneway_transit_udp(struct TransferInfo *stats, struct ReportStruct *packet);
static void reporter_handle_frame_isoch_oneway_transit(struct TransferInfo *stats, struct ReportStruct *packet);
static void reporter_handle_txmsg_oneway_transit(struct TransferInfo *stats, struct ReportStruct *packet);
static void reporter_handle_rxmsg_oneway_transit(struct TransferInfo *stats, struct ReportStruct *packet);

static inline void reporter_compute_packet_pps (struct TransferInfo *stats, struct ReportStruct *packet);

#if HAVE_TCP_STATS
static inline void reporter_handle_packet_tcpistats(struct ReporterData *data, struct ReportStruct *packet);
#endif
static struct ConnectionInfo *myConnectionReport;

void PostReport (struct ReportHeader *reporthdr) {
#ifdef HAVE_THREAD_DEBUG
    char rs[REPORTTXTMAX];
    reporttype_text(reporthdr, &rs[0]);
    thread_debug("Jobq *POST* report %p (%s)", reporthdr, &rs[0]);
#endif
    if (reporthdr) {
#ifdef HAVE_THREAD
	/*
	 * Update the ReportRoot to include this report.
	 */
	Condition_Lock(ReportCond);
	reporthdr->next = NULL;
	if (!ReportPendingHead) {
	  ReportPendingHead = reporthdr;
	  ReportPendingTail = reporthdr;
	} else {
	  ReportPendingTail->next = reporthdr;
	  ReportPendingTail = reporthdr;
	}
	Condition_Unlock(ReportCond);
	// wake up the reporter thread
	Condition_Signal(&ReportCond);
#else
	/*
	 * Process the report in this thread
	 */
	reporthdr->next = NULL;
	reporter_process_report(reporthdr);
#endif
    }
}
/*
 * ReportPacket is called by a transfer agent to record
 * the arrival or departure of a "packet" (for TCP it
 * will actually represent many packets). This needs to
 * be as simple and fast as possible as it gets called for
 * every "packet".
 *
 * Returns true when the tcpinfo was sampled, false ohterwise
 */
bool ReportPacket (struct ReporterData* data, struct ReportStruct *packet) {
    assert(data != NULL);

    bool rc = false;
  #ifdef HAVE_THREAD_DEBUG
    if (packet->packetID < 0) {
	thread_debug("Reporting last packet for %p  qdepth=%d sock=%d", (void *) data, packetring_getcount(data->packetring), data->info.common->socket);
    }
  #endif
#if HAVE_TCP_STATS
    struct TransferInfo *stats = &data->info;
    packet->tcpstats.isValid = false;
    if (stats->isEnableTcpInfo) {
	if (!TimeZero(stats->ts.nextTCPSampleTime) && (TimeDifference(stats->ts.nextTCPSampleTime, packet->packetTime) < 0)) {
	    gettcpinfo(data->info.common->socket, &packet->tcpstats);
	    TimeAdd(stats->ts.nextTCPSampleTime, stats->ts.intervalTime);
	} else {
	    gettcpinfo(data->info.common->socket, &packet->tcpstats);
	}
    }
#endif

    // Note for threaded operation all that needs
    // to be done is to enqueue the packet data
    // into the ring.
    packetring_enqueue(data->packetring, packet);
    // The traffic thread calls the reporting process
    // directly forr non-threaded operation
    // These defeats the puropse of separating
    // traffic i/o from user i/o and really
    // should be avoided.
  #ifdef HAVE_THREAD
    // bypass the reporter thread here for single UDP
    if (isSingleUDP(data->info.common))
        reporter_process_transfer_report(data);
  #else
    /*
     * Process the report in this thread
     */
    reporter_process_transfer_report(data);
  #endif

    return rc;
}

/*
 * EndJob is called by a traffic thread to inform the reporter
 * thread to print a final report and to remove the data report from its jobq.
 * It also handles the freeing reports and other closing actions
 */
int EndJob (struct ReportHeader *reporthdr, struct ReportStruct *finalpacket) {
    assert(reporthdr!=NULL);
    assert(finalpacket!=NULL);
    struct ReporterData *report = (struct ReporterData *) reporthdr->this_report;
    struct ReportStruct packet;

    memset(&packet, 0, sizeof(struct ReportStruct));
    int do_close = 1;
    /*
     * Using PacketID of -1 ends reporting
     * It pushes a "special packet" through
     * the packet ring which will be detected
     * by the reporter thread as and end of traffic
     * event
     */
#if HAVE_TCP_STATS
    // tcpi stats are sampled on a final packet
    struct TransferInfo *stats = &report->info;
    if (stats->isEnableTcpInfo) {
	gettcpinfo(report->info.common->socket, &finalpacket->tcpstats);
    }
#endif
    // clear the reporter done predicate
    report->packetring->consumerdone = 0;
    // the negative packetID is used to inform the report thread this traffic thread is done
    packet.packetID = -1;
    packet.packetLen = finalpacket->packetLen;
    packet.packetTime = finalpacket->packetTime;
    if (isSingleUDP(report->info.common)) {
	packetring_enqueue(report->packetring, &packet);
	reporter_process_transfer_report(report);
    } else {
	ReportPacket(report, &packet);
#ifdef HAVE_THREAD_DEBUG
	thread_debug( "Traffic thread awaiting reporter to be done with %p and cond %p", (void *)report, (void *) report->packetring->awake_producer);
#endif
	Condition_Lock((*(report->packetring->awake_producer)));
	while (!report->packetring->consumerdone) {
	    // This wait time is the lag between the reporter thread
	    // and the traffic thread, a reporter thread with lots of
	    // reports (e.g. fastsampling) can lag per the i/o
	    Condition_TimedWait(report->packetring->awake_producer, 1);
	    // printf("Consumer done may be stuck\n");
	}
	Condition_Unlock((*(report->packetring->awake_producer)));
    }
    if (report->FullDuplexReport && isFullDuplex(report->FullDuplexReport->info.common)) {
	if (fullduplex_stop_barrier(&report->FullDuplexReport->fullduplex_barrier)) {
	    struct Condition *tmp = &report->FullDuplexReport->fullduplex_barrier.await;
	    Condition_Destroy(tmp);
#if HAVE_THREAD_DEBUG
	    thread_debug("Socket fullduplex close sock=%d", report->FullDuplexReport->info.common->socket);
#endif
	    FreeSumReport(report->FullDuplexReport);
	} else {
	    do_close = 0;
	}
    }
    return do_close;
}

//  This is used to determine the packet/cpu load into the reporter thread
//  If the overall reporter load is too low, add some yield
//  or delay so the traffic threads can fill the packet rings
#define MINPACKETDEPTH 10
#define MINPERQUEUEDEPTH 20
#define REPORTERDELAY_DURATION 16000 // units is microseconds
struct ConsumptionDetectorType {
    int accounted_packets;
    int accounted_packet_threads;
    int reporter_thread_suspends ;
};
struct ConsumptionDetectorType consumption_detector = \
  {.accounted_packets = 0, .accounted_packet_threads = 0, .reporter_thread_suspends = 0};

static inline void reset_consumption_detector (void) {
    consumption_detector.accounted_packet_threads = thread_numtrafficthreads();
    if ((consumption_detector.accounted_packets = thread_numtrafficthreads() * MINPERQUEUEDEPTH) <= MINPACKETDEPTH) {
	consumption_detector.accounted_packets = MINPACKETDEPTH;
    }
}
static inline void apply_consumption_detector (void) {
    if (--consumption_detector.accounted_packet_threads <= 0) {
	// All active threads have been processed for the loop,
	// reset the thread counter and check the consumption rate
	// If the rate is too low add some delay to the reporter
	consumption_detector.accounted_packet_threads = thread_numtrafficthreads();
	// Check to see if we need to suspend the reporter
	if (consumption_detector.accounted_packets > 0) {
	    /*
	     * Suspend the reporter thread for some (e.g. 4) milliseconds
	     *
	     * This allows the thread to receive client or server threads'
	     * packet events in "aggregates."  This can reduce context
	     * switching allowing for better CPU utilization,
	     * which is very noticble on CPU constrained systems.
	     */
	    delay_loop(REPORTERDELAY_DURATION);
	    consumption_detector.reporter_thread_suspends++;
	    // printf("DEBUG: forced reporter suspend, accounted=%d,  queueue depth after = %d\n", accounted_packets, getcount_packetring(reporthdr));
	} else {
	    // printf("DEBUG: no suspend, accounted=%d,  queueue depth after = %d\n", accounted_packets, getcount_packetring(reporthdr));
	}
	reset_consumption_detector();
    }
}

#ifdef HAVE_THREAD_DEBUG
static void reporter_jobq_dump(void) {
  thread_debug("reporter thread job queue request lock");
  Condition_Lock(ReportCond);
  struct ReportHeader *itr = ReportRoot;
  while (itr) {
    thread_debug("Job in queue %p",(void *) itr);
    itr = itr->next;
  }
  Condition_Unlock(ReportCond);
  thread_debug("reporter thread job queue unlock");
}
#endif


/* Concatenate pending reports and return the head */
static inline struct ReportHeader *reporter_jobq_set_root (struct thread_Settings *inSettings) {
    struct ReportHeader *root = NULL;
    Condition_Lock(ReportCond);
    // check the jobq for empty
    if (ReportRoot == NULL) {
	sInterupted = 0; // reset flags in reporter thread emtpy context
	// The reporter is starting from an empty state
	// so set the load detect to trigger an initial delay
        if (!isSingleUDP(inSettings)) {
	    reset_consumption_detector();
	    reporter_default_heading_flags((inSettings->mReportMode == kReport_CSV));
        }
	// Only hang the timed wait if more than this thread is active
	if (!ReportPendingHead && (thread_numuserthreads() > 1)) {
	    Condition_TimedWait(&ReportCond, 1);
#ifdef HAVE_THREAD_DEBUG
	    thread_debug( "Jobq *WAIT* exit  %p/%p cond=%p threads u/t=%d/%d", \
			  (void *) ReportRoot, (void *) ReportPendingHead, \
			  (void *) &ReportCond, thread_numuserthreads(), thread_numtrafficthreads());
#endif
	}
    }
    // update the jobq per pending reports
    if (ReportPendingHead) {
	ReportPendingTail->next = ReportRoot;
	ReportRoot = ReportPendingHead;
#ifdef HAVE_THREAD_DEBUG
	thread_debug( "Jobq *ROOT* %p (last=%p)", \
		      (void *) ReportRoot, (void * ) ReportPendingTail->next);
#endif
	ReportPendingHead = NULL;
	ReportPendingTail = NULL;
    }
    root = ReportRoot;
    Condition_Unlock(ReportCond);
    return root;
}
/*
 * Welford's online algorithm
 *
 * # For a new value newValue, compute the new count, new mean, the new M2.
 * # mean accumulates the mean of the entire dataset
 * # M2 aggregates the squared distance from the mean
 * # count aggregates the number of samples seen so far
 * def update(existingAggregate, newValue):
 *   (count, mean, M2) = existingAggregate
 *   count += 1
 *   delta = newValue - mean
 *   mean += delta / count
 *   delta2 = newValue - mean
 *   M2 += delta * delta2
 *   return (count, mean, M2)
 *
 * # Retrieve the mean, variance and sample variance from an aggregate
 * def finalize(existingAggregate):
 *   (count, mean, M2) = existingAggregate
 *   if count < 2:
 *       return float("nan")
 *   else:
 *       (mean, variance, sampleVariance) = (mean, M2 / count, M2 / (count - 1))
 *       return (mean, variance, sampleVariance)
 *
 */
static void reporter_update_mmm (struct MeanMinMaxStats *stats, double value) {
    assert(stats != NULL);
    stats->cnt++;
    if (stats->cnt == 1) {
	// Very first entry
	stats->min = value;
	stats->max = value;
	stats->sum = value;
	stats->vd = value;
	stats->mean = value;
	stats->m2 = 0;
	stats->sum = value;
    } else {
	stats->sum += value;
	stats->vd = value - stats->mean;
	stats->mean += (stats->vd / stats->cnt);
	stats->m2 += stats->vd * (value - stats->mean);
	// mean min max tests
	if (value < stats->min)
	    stats->min = value;
	if (value > stats->max)
	    stats->max = value;
    }
    // fprintf(stderr,"**** mmm(%d) val/sum=%f/%f mmm=%f/%f/%f/%f\n", stats->cnt, value, stats->sum, stats->mean, stats->min, stats->max, stats->m2);
}
static void reporter_reset_mmm (struct MeanMinMaxStats *stats) {
    stats->min = FLT_MAX;
    stats->max = FLT_MIN;
    stats->sum = 0;
    stats->vd = 0;
    stats->mean = 0;
    stats->m2 = 0;
    stats->cnt = 0;
};

/*
 * This function is the loop that the reporter thread processes
 */
void reporter_spawn (struct thread_Settings *thread) {
#ifdef HAVE_THREAD_DEBUG
    thread_debug( "Reporter thread started");
#endif
    if (isEnhanced(thread)) {
        myConnectionReport = InitConnectOnlyReport(thread);
    }
    /*
     * reporter main loop needs to wait on all threads being started
     */
    Condition_Lock(threads_start.await);
    while (!threads_start.ready) {
	Condition_TimedWait(&threads_start.await, 1);
    }
    Condition_Unlock(threads_start.await);
#ifdef HAVE_THREAD_DEBUG
    thread_debug( "Reporter await done");
#endif

    //
    // Signal to other (client) threads that the
    // reporter is now running.
    //
    Condition_Lock(reporter_state.await);
    reporter_state.ready = 1;
    Condition_Unlock(reporter_state.await);
    Condition_Broadcast(&reporter_state.await);
#if HAVE_SCHED_SETSCHEDULER
    // set reporter thread to realtime if requested
    thread_setscheduler(thread);
#endif
    /*
     * Keep the reporter thread alive under the following conditions
     *
     * o) There are more reports to output, ReportRoot has a report
     * o) The number of threads is greater than one which indicates
     *    either traffic threads are still running or a Listener thread
     *    is running. If equal to 1 then only the reporter thread is alive
     */
    while ((reporter_jobq_set_root(thread) != NULL) || (thread_numuserthreads() > 1)){
#ifdef HAVE_THREAD_DEBUG
	// thread_debug( "Jobq *HEAD* %p (%d)", (void *) ReportRoot, thread_numuserthreads());
#endif
	if (ReportRoot) {
	    // https://blog.kloetzl.info/beautiful-code/
	    // Linked list removal/processing is derived from:
	    //
	    // remove_list_entry(entry) {
	    //     indirect = &head;
	    //     while ((*indirect) != entry) {
	    //	       indirect = &(*indirect)->next;
	    //     }
	    //     *indirect = entry->next
	    // }
	    struct ReportHeader **work_item = &ReportRoot;
	    while (*work_item) {
#ifdef HAVE_THREAD_DEBUG
		// thread_debug( "Jobq *NEXT* %p", (void *) *work_item);
#endif
		// Report process report returns true
		// when a report needs to be removed
		// from the jobq.  Also, work item might
		// be removed as part of processing
		// Store a cached pointer for the linked list maitenance
		struct ReportHeader *tmp = (*work_item)->next;
	        if (reporter_process_report(*work_item)) {
#ifdef HAVE_THREAD_DEBUG
		  thread_debug("Jobq *REMOVE* %p", (void *) (*work_item));
#endif
		    // memory for *work_item is gone by now
		    *work_item = tmp;
		    if (!tmp)
			break;
		}
		work_item = &(*work_item)->next;
	    }
	}
    }
    if (myConnectionReport) {
	if (myConnectionReport->connect_times.cnt > 1) {
	    reporter_connect_printf_tcp_final(myConnectionReport);
	}
	FreeConnectionReport(myConnectionReport);
    }
#ifdef HAVE_THREAD_DEBUG
    if (sInterupted)
        reporter_jobq_dump();
    thread_debug("Reporter thread finished user/traffic %d/%d", thread_numuserthreads(), thread_numtrafficthreads());
#endif
}

// The Transfer or Data report is by far the most complicated report
int reporter_process_transfer_report (struct ReporterData *this_ireport) {
    assert(this_ireport != NULL);
    struct TransferInfo *sumstats = (this_ireport->GroupSumReport ? &this_ireport->GroupSumReport->info : NULL);
    struct TransferInfo *fullduplexstats = (this_ireport->FullDuplexReport ? &this_ireport->FullDuplexReport->info : NULL);
    int need_free = 0;
    // The consumption detector applies delay to the reporter
    // thread when its consumption rate is too low.   This allows
    // the traffic threads to send aggregates vs thrash
    // the packet rings.  The dissimilarity between the thread
    // speeds is due to the performance differences between i/o
    // bound threads vs cpu bound ones, and it's expected
    // that reporter thread being CPU limited should be much
    // faster than the traffic threads, even in aggregate.
    // Note: If this detection is not going off it means
    // the system is likely CPU bound and iperf is now likely
    // becoming a CPU bound test vs a network i/o bound test
    if (!isSingleUDP(this_ireport->info.common))
	apply_consumption_detector();
    // If there are more packets to process then handle them
    struct ReportStruct *packet = NULL;
    int advance_jobq = 0;
    while (!advance_jobq && (packet = packetring_dequeue(this_ireport->packetring))) {
	// Increment the total packet count processed by this thread
	// this will be used to make decisions on if the reporter
	// thread should add some delay to eliminate cpu thread
	// thrashing,
	consumption_detector.accounted_packets--;
	// Check against a final packet event on this packet ring
#if HAVE_TCP_STATS
	if (this_ireport->info.isEnableTcpInfo && packet->tcpstats.isValid) {
	    reporter_handle_packet_tcpistats(this_ireport, packet);
	}
#endif
	if (!(packet->packetID < 0)) {
	    // Check to output any interval reports,
            // bursts need to report the packet first
	    if (this_ireport->packet_handler_pre_report) {
		(*this_ireport->packet_handler_pre_report)(this_ireport, packet);
	    }
	    if (this_ireport->transfer_interval_handler) {
		advance_jobq = (*this_ireport->transfer_interval_handler)(this_ireport, packet);
	    }
	    if (this_ireport->packet_handler_post_report) {
		(*this_ireport->packet_handler_post_report)(this_ireport, packet);
	    }
	    // Sum reports update the report header's last
	    // packet time after the handler. This means
	    // the report header's packet time will be
	    // the previous time before the interval
	    if (sumstats)
		sumstats->ts.packetTime = packet->packetTime;
	    if (fullduplexstats)
		fullduplexstats->ts.packetTime = packet->packetTime;
	} else {
	    need_free = 1;
	    advance_jobq = 1;
	    // A last packet event was detected
	    // printf("last packet event detected\n"); fflush(stdout);
	    this_ireport->reporter_thread_suspends = consumption_detector.reporter_thread_suspends;
	    if (this_ireport->packet_handler_pre_report) {
		(*this_ireport->packet_handler_pre_report)(this_ireport, packet);
	    }
	    if (this_ireport->packet_handler_post_report) {
		(*this_ireport->packet_handler_post_report)(this_ireport, packet);
	    }
	    this_ireport->info.ts.packetTime = packet->packetTime;
	    assert(this_ireport->transfer_protocol_handler != NULL);
	    (*this_ireport->transfer_protocol_handler)(this_ireport, 1);
	    // This is a final report so set the sum report header's packet time
	    // Note, the thread with the max value will set this
	    if (fullduplexstats && isEnhanced(this_ireport->info.common)) {
		// The largest packet timestamp sets the sum report final time
		if (TimeDifference(fullduplexstats->ts.packetTime, packet->packetTime) > 0) {
		    fullduplexstats->ts.packetTime = packet->packetTime;
		}
		if (DecrSumReportRefCounter(this_ireport->FullDuplexReport) == 0) {
		    if (this_ireport->FullDuplexReport->transfer_protocol_sum_handler) {
			(*this_ireport->FullDuplexReport->transfer_protocol_sum_handler)(fullduplexstats, 1);
		    }
		    // FullDuplex report gets freed by a traffic thread (per its barrier)
		}
	    }
	    if (sumstats) {
		if (TimeDifference(sumstats->ts.packetTime, packet->packetTime) > 0) {
		    sumstats->ts.packetTime = packet->packetTime;
		}
		if (DecrSumReportRefCounter(this_ireport->GroupSumReport) == 0) {
		    if (this_ireport->GroupSumReport->transfer_protocol_sum_handler && \
			((this_ireport->GroupSumReport->reference.maxcount > 1) || isSumOnly(this_ireport->info.common))) {
			(*this_ireport->GroupSumReport->transfer_protocol_sum_handler)(&this_ireport->GroupSumReport->info, 1);
		    }
		    FreeSumReport(this_ireport->GroupSumReport);
		}
	    }
	}
    }
    return need_free;
}
/*
 * Process reports
 *
 * Make notice here, the reporter thread is freeing most reports, traffic threads
 * can't use them anymore (except for the DATA REPORT);
 *
 */
inline int reporter_process_report (struct ReportHeader *reporthdr) {
    assert(reporthdr != NULL);
    int done = 1;
    switch (reporthdr->type) {
    case DATA_REPORT:
	done = reporter_process_transfer_report((struct ReporterData *)reporthdr->this_report);
	fflush(stdout);
	if (done) {
	    struct ReporterData *tmp = (struct ReporterData *)reporthdr->this_report;
	    struct PacketRing *pr = tmp->packetring;
	    pr->consumerdone = 1;
	    // Data Reports are special because the traffic thread needs to free them, just signal
	    Condition_Signal(pr->awake_producer);
	}
	break;
    case CONNECTION_REPORT:
    {
	struct ConnectionInfo *creport = (struct ConnectionInfo *)reporthdr->this_report;
	assert(creport!=NULL);
	if (!isCompat(creport->common) && (creport->common->ThreadMode == kMode_Client) && myConnectionReport) {
	    // Clients' connect times will be inputs to the overall connect stats
	    if (creport->tcpinitstats.connecttime > 0.0) {
		reporter_update_mmm(&myConnectionReport->connect_times, creport->tcpinitstats.connecttime);
	    } else {
		myConnectionReport->connect_times.err++;
	    }
	}
	reporter_print_connection_report(creport);
	fflush(stdout);
	FreeReport(reporthdr);
    }
	break;
    case SETTINGS_REPORT:
	reporter_print_settings_report((struct ReportSettings *)reporthdr->this_report);
	fflush(stdout);
	FreeReport(reporthdr);
	break;
    case SERVER_RELAY_REPORT:
	reporter_print_server_relay_report((struct ServerRelay *)reporthdr->this_report);
	fflush(stdout);
	FreeReport(reporthdr);
	break;
    default:
	fprintf(stderr,"Invalid report type in process report %p\n", reporthdr->this_report);
	assert(0);
	break;
    }
#ifdef HAVE_THREAD_DEBUG
    // thread_debug("Processed report %p type=%d", (void *)reporthdr, reporthdr->report.type);
#endif
    return done;
}

/*
 * Updates connection stats
 */
#define L2DROPFILTERCOUNTER 100

// Reporter private routines
void reporter_handle_packet_null (struct ReporterData *data, struct ReportStruct *packet) {
}
void reporter_transfer_protocol_null (struct ReporterData *data, int final){
}

static inline void reporter_compute_packet_pps (struct TransferInfo *stats, struct ReportStruct *packet) {
    if (!packet->emptyreport) {
        stats->total.Datagrams.current++;
        stats->total.IPG.current++;
    }
    stats->ts.IPGstart = packet->packetTime;
    stats->IPGsum += TimeDifference(packet->packetTime, packet->prevPacketTime);
#ifdef DEBUG_PPS
    printf("*** IPGsum = %f cnt=%ld ipg=%ld.%ld pkt=%ld.%ld id=%ld empty=%d transit=%f prev=%ld.%ld\n", stats->IPGsum, stats->cntIPG, stats->ts.IPGstart.tv_sec, stats->ts.IPGstart.tv_usec, packet->packetTime.tv_sec, packet->packetTime.tv_usec, packet->packetID, packet->emptyreport, TimeDifference(packet->packetTime, packet->prevPacketTime), packet->prevPacketTime.tv_sec, packet->prevPacketTime.tv_usec);
#endif
}

static void reporter_handle_packet_oneway_transit (struct TransferInfo *stats, struct ReportStruct *packet) {
    // Transit or latency updates done inline below
    double transit = TimeDifference(packet->packetTime, packet->sentTime);
    if (stats->latency_histogram) {
        histogram_insert(stats->latency_histogram, transit, NULL);
    }
    double deltaTransit;
    // from RFC 1889, Real Time Protocol (RTP)
    // J = J + ( | D(i-1,i) | - J ) /
    // Compute jitter
    deltaTransit = transit - stats->transit.current.last;
    if (deltaTransit < 0.0) {
	deltaTransit = -deltaTransit;
    }
    stats->jitter += (deltaTransit - stats->jitter) / (16.0);
    // Compute end/end delay stats
    reporter_update_mmm(&stats->transit.total, transit);
    reporter_update_mmm(&stats->transit.current, transit);
    stats->transit.current.last = transit;
}


static void reporter_handle_isoch_oneway_transit_tcp (struct TransferInfo *stats, struct ReportStruct *packet) {
    // printf("fid=%lu bs=%lu remain=%lu\n", packet->frameID, packet->burstsize, packet->remaining);
    if (packet->frameID && packet->transit_ready) {
	int framedelta = 0;
	double frametransit = 0;
	// very first isochronous frame
	if (!stats->isochstats.frameID) {
	    stats->isochstats.framecnt.current=packet->frameID;
	}
	// perform client and server frame based accounting
	if ((framedelta = (packet->frameID - stats->isochstats.frameID))) {
	    stats->isochstats.framecnt.current++;
	    if (framedelta > 1) {
		stats->isochstats.framelostcnt.current += (framedelta-1);
		stats->isochstats.slipcnt.current++;
	    } else if (stats->common->ThreadMode == kMode_Server) {
		// Triptimes use the frame start time in passed in the frame header while
		// it's calculated from the very first start time and frame id w/o trip timees
		if (isTripTime(stats->common)) {
		    frametransit = TimeDifference(packet->packetTime, packet->isochStartTime);
		} else {
		    frametransit = TimeDifference(packet->packetTime, packet->isochStartTime) \
			- ((packet->burstperiod * (packet->frameID - 1)) / 1e6);
		}
		reporter_update_mmm(&stats->isochstats.transit.total, frametransit);
		reporter_update_mmm(&stats->isochstats.transit.current, frametransit);
		if (stats->framelatency_histogram) {
		    histogram_insert(stats->framelatency_histogram, frametransit, &packet->packetTime);
		}
	    }
	}
	stats->isochstats.frameID = packet->frameID;
    }
}

static void reporter_handle_isoch_oneway_transit_udp (struct TransferInfo *stats, struct ReportStruct *packet) {
    // printf("fid=%lu bs=%lu remain=%lu\n", packet->frameID, packet->burstsize, packet->remaining);
    if (packet->frameID && packet->transit_ready) {
	int framedelta = 0;
	double frametransit = 0;
	// very first isochronous frame
	if (!stats->isochstats.frameID) {
	    stats->isochstats.framecnt.current=1;
	}
	// perform client and server frame based accounting
	framedelta = (packet->frameID - stats->isochstats.frameID);
	stats->isochstats.framecnt.current++;
//      stats->matchframeID = packet->frameID + 1;
	if (framedelta == 1) {
	    // Triptimes use the frame start time in passed in the frame header while
	    // it's calculated from the very first start time and frame id w/o trip timees
	    frametransit = TimeDifference(packet->packetTime, packet->isochStartTime) \
		- ((packet->burstperiod * (packet->frameID - 1)) / 1e6);
	    reporter_update_mmm(&stats->isochstats.transit.total, frametransit);
	    reporter_update_mmm(&stats->isochstats.transit.current, frametransit);
	    if (stats->framelatency_histogram) {
		histogram_insert(stats->framelatency_histogram, frametransit, &packet->packetTime);
	    }
	} else {
	    if (stats->common->ThreadMode == kMode_Server) {
		stats->isochstats.framelostcnt.current += framedelta;
	    } else {
		stats->isochstats.framelostcnt.current += framedelta;
		stats->isochstats.slipcnt.current++;
	    }
	}
	stats->isochstats.frameID = packet->frameID;
    }
}


static void reporter_handle_rxmsg_oneway_transit (struct TransferInfo *stats, struct ReportStruct *packet) {
    // very first burst
    if (!stats->isochstats.frameID) {
	stats->isochstats.frameID = packet->frameID;
    }
    if (packet->frameID && packet->transit_ready) {
	double transit = TimeDifference(packet->packetTime, packet->sentTime);
//	printf("**** r pt %ld.%ld st %ld.%ld %f\n", packet->packetTime.tv_sec, packet->packetTime.tv_usec, packet->sentTime.tv_sec, packet->sentTime.tv_usec, transit);
	reporter_update_mmm(&stats->transit.total, transit);
	reporter_update_mmm(&stats->transit.current, transit);
	if (stats->framelatency_histogram) {
	    histogram_insert(stats->framelatency_histogram, transit, &packet->sentTime);
	}
	if (!TimeZero(stats->ts.prevpacketTime)) {
	    double delta = TimeDifference(packet->sentTime, stats->ts.prevpacketTime);
	    stats->IPGsum += delta;
	}
	stats->ts.prevpacketTime = packet->sentTime;
	stats->isochstats.frameID++;  // RJM fix this overload
	stats->burstid_transition = true;
    } else if (stats->burstid_transition && packet->frameID && (packet->frameID != stats->isochstats.frameID)) {
	stats->burstid_transition = false;
	fprintf(stderr,"%sError: expected burst id %u but got %" PRIdMAX "\n", \
		stats->common->transferIDStr, stats->isochstats.frameID + 1, packet->frameID);
	stats->isochstats.frameID = packet->frameID;
    }
}

static inline void reporter_handle_txmsg_oneway_transit (struct TransferInfo *stats, struct ReportStruct *packet) {
    // very first burst
    if (!stats->isochstats.frameID) {
	stats->isochstats.frameID = packet->frameID;
    }
    if (!TimeZero(stats->ts.prevpacketTime)) {
	double delta = TimeDifference(packet->sentTime, stats->ts.prevpacketTime);
	stats->IPGsum += delta;
    }
    if (packet->transit_ready) {
        reporter_handle_packet_oneway_transit(stats, packet);
	// printf("***Burst id = %ld, transit = %f\n", packet->frameID, stats->transit.lastTransit);
	if (isIsochronous(stats->common)) {
	    if (packet->frameID && (packet->frameID != (stats->isochstats.frameID + 1))) {
		fprintf(stderr,"%sError: expected burst id %u but got %" PRIdMAX "\n", \
			stats->common->transferIDStr, stats->isochstats.frameID + 1, packet->frameID);
	    }
	    stats->isochstats.frameID = packet->frameID;
	}
    }
}

static void reporter_handle_frame_isoch_oneway_transit (struct TransferInfo *stats, struct ReportStruct *packet) {
    // printf("fid=%lu bs=%lu remain=%lu\n", packet->frameID, packet->burstsize, packet->remaining);
    if (packet->frameID && packet->transit_ready) {
	int framedelta=0;
	// very first isochronous frame
	if (!stats->isochstats.frameID) {
	    stats->isochstats.framecnt.current=packet->frameID;
	}
	// perform client and server frame based accounting
	if ((framedelta = (packet->frameID - stats->isochstats.frameID))) {
	    stats->isochstats.framecnt.current++;
	    if (framedelta > 1) {
		if (stats->common->ThreadMode == kMode_Server) {
		    int lost = framedelta - (packet->frameID - packet->prevframeID);
		    stats->isochstats.framelostcnt.current += lost;
		} else {
		    stats->isochstats.framelostcnt.current += (framedelta-1);
		    stats->isochstats.slipcnt.current++;
		}
	    }
	}
	// peform frame latency checks
	if (stats->framelatency_histogram) {
	    // first packet of a burst and not a duplicate
	    if ((packet->burstsize == packet->remaining) && (stats->matchframeID!=packet->frameID)) {
		stats->matchframeID=packet->frameID;
	    }
	    if ((packet->packetLen == packet->remaining) && (packet->frameID == stats->matchframeID)) {
		// last packet of a burst (or first-last in case of a duplicate) and frame id match
		double frametransit = TimeDifference(packet->packetTime, packet->isochStartTime) \
		    - ((packet->burstperiod * (packet->frameID - 1)) / 1000000.0);
		histogram_insert(stats->framelatency_histogram, frametransit, NULL);
		stats->matchframeID = 0;  // reset the matchid so any potential duplicate is ignored
	    }
	}
	stats->isochstats.frameID = packet->frameID;
    }
}

// This is done in reporter thread context
void reporter_handle_packet_client (struct ReporterData *data, struct ReportStruct *packet) {
    struct TransferInfo *stats = &data->info;
    stats->ts.packetTime = packet->packetTime;
    if (!packet->emptyreport) {
	stats->total.Bytes.current += packet->packetLen;
        if (packet->errwrite && (packet->errwrite != WriteErrNoAccount)) {
	    stats->sock_callstats.write.WriteErr++;
	    stats->sock_callstats.write.totWriteErr++;
	}
	// These are valid packets that need standard iperf accounting
	stats->sock_callstats.write.WriteCnt += packet->writecnt;
	stats->sock_callstats.write.totWriteCnt += packet->writecnt;
	if (isIsochronous(stats->common)) {
	    reporter_handle_frame_isoch_oneway_transit(stats, packet);
	} else if (isPeriodicBurst(stats->common)) {
	    reporter_handle_txmsg_oneway_transit(stats, packet);
	}
	if (isTcpWriteTimes(stats->common) && !isUDP(stats->common) && (packet->write_time > 0)) {
	    reporter_update_mmm(&stats->write_mmm.current, ((double) packet->write_time));
	    reporter_update_mmm(&stats->write_mmm.total, ((double) packet->write_time));
	    if (stats->write_histogram ) {
		histogram_insert(stats->write_histogram, (1e-6 * packet->write_time), NULL);
	    }
	}
    }
    if (isUDP(stats->common)) {
	stats->PacketID = packet->packetID;
	reporter_compute_packet_pps(stats, packet);
    } else if (packet->transit_ready) {
	if (isIsochronous(stats->common) && packet->frameID) {
	    reporter_handle_frame_isoch_oneway_transit(stats, packet);
	} else if (isPeriodicBurst(stats->common) || isTripTime(stats->common)) {
	    reporter_handle_rxmsg_oneway_transit(stats, packet);
	}
    }
}

void reporter_handle_packet_bb_client (struct ReporterData *data, struct ReportStruct *packet) {
    if (!packet->emptyreport && (packet->packetLen > 0)) {
        struct TransferInfo *stats = &data->info;
	stats->total.Bytes.current += packet->packetLen;
	double bbrtt = TimeDifference(packet->packetTime, packet->sentTime);
	double bbowdto = TimeDifference(packet->sentTimeRX, packet->sentTime);
	double bbowdfro = TimeDifference(packet->packetTime, packet->sentTimeTX);
	double asym = bbowdfro - bbowdto;
	stats->ts.prevpacketTime = packet->packetTime;
#if 0
	fprintf(stderr, "BB Debug: ctx=%lx.%lx srx=%lx.%lx stx=%lx.%lx crx=%lx.%lx\n", packet->sentTime.tv_sec, packet->sentTime.tv_usec, packet->sentTimeRX.tv_sec, packet->sentTimeRX.tv_usec, packet->sentTimeTX.tv_sec, packet->sentTimeTX.tv_usec, packet->packetTime.tv_sec, packet->pAckettime.tv_usec);
	fprintf(stderr, "BB Debug: ctx=%ld.%ld srx=%ld.%ld stx=%ld.%ld crx=%ld.%ld\n", packet->sentTime.tv_sec, packet->sentTime.tv_usec, packet->sentTimeRX.tv_sec, packet->sentTimeRX.tv_usec, packet->sentTimeTX.tv_sec, packet->sentTimeTX.tv_usec, packet->packetTime.tv_sec, packet->packetTime.tv_usec);
#endif
	stats->iBBrunning += bbrtt;
	stats->fBBrunning += bbrtt;
	reporter_update_mmm(&stats->bbrtt.current, bbrtt);
	reporter_update_mmm(&stats->bbrtt.total, bbrtt);
	reporter_update_mmm(&stats->bbowdto.total, bbowdto);
	reporter_update_mmm(&stats->bbowdfro.total, bbowdfro);
	reporter_update_mmm(&stats->bbasym.total, fabs(asym));
	if (stats->bbrtt_histogram) {
	    histogram_insert(stats->bbrtt_histogram, bbrtt, NULL);
	}
    }
}

void reporter_handle_packet_bb_server (struct ReporterData *data, struct ReportStruct *packet) {
    struct TransferInfo *stats = &data->info;
    stats->ts.packetTime = packet->packetTime;
    if (!packet->emptyreport && (packet->packetLen > 0)) {
	stats->total.Bytes.current += packet->packetLen;
    }
}

inline void reporter_handle_packet_server_tcp (struct ReporterData *data, struct ReportStruct *packet) {
    struct TransferInfo *stats = &data->info;
    if (packet->packetLen > 0) {
	int bin;
	stats->total.Bytes.current += packet->packetLen;
	// mean min max tests
	stats->sock_callstats.read.cntRead++;
	stats->sock_callstats.read.totcntRead++;
	bin = (int)floor((packet->packetLen -1)/stats->sock_callstats.read.binsize);
	if (bin < TCPREADBINCOUNT) {
	    stats->sock_callstats.read.bins[bin]++;
	    stats->sock_callstats.read.totbins[bin]++;
	}
	if (packet->transit_ready) {
	    if (isIsochronous(stats->common) && packet->frameID) {
		reporter_handle_isoch_oneway_transit_tcp(stats, packet);
	    } else if (isPeriodicBurst(stats->common) || isTripTime(stats->common)) {
		reporter_handle_rxmsg_oneway_transit(stats, packet);
	    }
	}
    }
}

inline void reporter_handle_packet_server_udp (struct ReporterData *data, struct ReportStruct *packet) {
    struct TransferInfo *stats = &data->info;
    stats->ts.packetTime = packet->packetTime;
    if (packet->emptyreport && (stats->transit.current.cnt == 0)) {
	// This is the case when empty reports
	// cross the report interval boundary
	// Hence, set the per interval min to infinity
	// and the per interval max and sum to zero
	reporter_reset_mmm(&stats->transit.current);
    } else if (packet->packetID > 0) {
	stats->total.Bytes.current += packet->packetLen;
	// These are valid packets that need standard iperf accounting
	// Do L2 accounting first (if needed)
	if (packet->l2errors && (stats->total.Datagrams.current > L2DROPFILTERCOUNTER)) {
	    stats->l2counts.cnt++;
	    stats->l2counts.tot_cnt++;
	    if (packet->l2errors & L2UNKNOWN) {
		stats->l2counts.unknown++;
		stats->l2counts.tot_unknown++;
	    }
	    if (packet->l2errors & L2LENERR) {
		stats->l2counts.lengtherr++;
		stats->l2counts.tot_lengtherr++;
	    }
	    if (packet->l2errors & L2CSUMERR) {
		stats->l2counts.udpcsumerr++;
		stats->l2counts.tot_udpcsumerr++;
	    }
	}
	// packet loss occured if the datagram numbers aren't sequential
	if (packet->packetID != stats->PacketID + 1) {
	    if (packet->packetID < stats->PacketID + 1) {
		stats->total.OutofOrder.current++;
	    } else {
		stats->total.Lost.current += packet->packetID - stats->PacketID - 1;
	    }
	}
	// never decrease datagramID (e.g. if we get an out-of-order packet)
	if (packet->packetID > stats->PacketID) {
	    stats->PacketID = packet->packetID;
	}
	reporter_compute_packet_pps(stats, packet);
	reporter_handle_packet_oneway_transit(stats, packet);
	if (packet->transit_ready && packet->frameID) {
	    if (isIsochronous(stats->common)) {
		reporter_handle_isoch_oneway_transit_udp(stats, packet);
	    } else if (isPeriodicBurst(stats->common)) {
		reporter_handle_txmsg_oneway_transit(stats, packet);
	    }
	}
    }
}

// This is done in reporter thread context
#if HAVE_TCP_STATS
static inline void reporter_handle_packet_tcpistats (struct ReporterData *data, struct ReportStruct *packet) {
    assert(data!=NULL);
    struct TransferInfo *stats = &data->info;
    stats->sock_callstats.write.tcpstats.retry += (packet->tcpstats.retry_tot - stats->sock_callstats.write.tcpstats.retry_prev);
    stats->sock_callstats.write.tcpstats.retry_prev = packet->tcpstats.retry_tot;
    stats->sock_callstats.write.tcpstats.retry_tot = packet->tcpstats.retry_tot;
    stats->sock_callstats.write.tcpstats.cwnd = packet->tcpstats.cwnd;
    stats->sock_callstats.write.tcpstats.rtt = packet->tcpstats.rtt;
    stats->sock_callstats.write.tcpstats.rttvar = packet->tcpstats.rttvar;
}
#endif


/*
 * Report printing routines below
 */
static inline void reporter_set_timestamps_time (struct ReportTimeStamps *times, enum TimeStampType tstype) {
    // There is a corner case when the first packet is also the last where the start time (which comes
    // from app level syscall) is greater than the packetTime (which come for kernel level SO_TIMESTAMP)
    // For this case set the start and end time to both zero.
    if (TimeDifference(times->packetTime, times->startTime) < 0) {
	times->iEnd = 0;
	times->iStart = 0;
    } else {
	switch (tstype) {
	case INTERVAL:
	    times->iStart = times->iEnd;
	    times->iEnd = TimeDifference(times->nextTime, times->startTime);
	    TimeAdd(times->nextTime, times->intervalTime);
	    break;
	case TOTAL:
	    times->iStart = 0;
	    times->iEnd = TimeDifference(times->packetTime, times->startTime);
	    break;
	case FINALPARTIAL:
	    times->iStart = times->iEnd;
	    times->iEnd = TimeDifference(times->packetTime, times->startTime);
	    break;
	case INTERVALPARTIAL:
	    if ((times->iStart = TimeDifference(times->prevpacketTime, times->startTime)) < 0)
		times->iStart = 0.0;
	    times->iEnd = TimeDifference(times->packetTime, times->startTime);
	    break;
	default:
	    times->iEnd = -1;
	    times->iStart = -1;
	    break;
	}
    }
}

// If reports were missed, catch up now
static inline void reporter_transfer_protocol_missed_reports (struct TransferInfo *stats, struct ReportStruct *packet) {
    while (TimeDifference(packet->packetTime, stats->ts.nextTime) > TimeDouble(stats->ts.intervalTime)) {
//	printf("**** cmp=%f/%f next %ld.%ld packet %ld.%ld id=%ld\n", TimeDifference(packet->packetTime, stats->ts.nextTime), TimeDouble(stats->ts.intervalTime), stats->ts.nextTime.tv_sec, stats->ts.nextTime.tv_usec, packet->packetTime.tv_sec, packet->packetTime.tv_usec, packet->packetID);
	reporter_set_timestamps_time(&stats->ts, INTERVAL);
	struct TransferInfo emptystats;
	memset(&emptystats, 0, sizeof(struct TransferInfo));
	emptystats.ts.iStart = stats->ts.iStart;
	emptystats.ts.iEnd = stats->ts.iEnd;
	emptystats.common = stats->common;
	if ((stats->output_handler) && !(stats->isMaskOutput))
	    (*stats->output_handler)(&emptystats);
    }
}

static inline void reporter_reset_transfer_stats_client_tcp (struct TransferInfo *stats) {
    stats->total.Bytes.prev = stats->total.Bytes.current;
    stats->sock_callstats.write.WriteCnt = 0;
    stats->sock_callstats.write.WriteErr = 0;
    stats->isochstats.framecnt.prev = stats->isochstats.framecnt.current;
    stats->isochstats.framelostcnt.prev = stats->isochstats.framelostcnt.current;
    stats->isochstats.slipcnt.prev = stats->isochstats.slipcnt.current;
#if HAVE_TCP_STATS
    // set the interval retry counter to zero
    stats->sock_callstats.write.tcpstats.retry = 0;
#endif
    if (isBounceBack(stats->common)) {
	stats->iBBrunning = 0;
	reporter_reset_mmm(&stats->bbrtt.current);
	reporter_reset_mmm(&stats->bbowdto.current);
	reporter_reset_mmm(&stats->bbowdfro.current);
	reporter_reset_mmm(&stats->bbasym.current);
    }
    if (isTcpWriteTimes(stats->common)) {
	stats->write_mmm.current.cnt = 0;
	stats->write_mmm.current.min = FLT_MAX;
	stats->write_mmm.current.max = FLT_MIN;
	stats->write_mmm.current.sum = 0;
	stats->write_mmm.current.vd = 0;
	stats->write_mmm.current.mean = 0;
	stats->write_mmm.current.m2 = 0;
    }
}

static inline void reporter_reset_transfer_stats_client_udp (struct TransferInfo *stats) {
    if (stats->cntError < 0) {
	stats->cntError = 0;
    }
    stats->total.Lost.prev = stats->total.Lost.current;
    stats->total.Datagrams.prev = stats->total.Datagrams.current;
    stats->total.Bytes.prev = stats->total.Bytes.current;
    stats->total.IPG.prev = stats->total.IPG.current;
    stats->sock_callstats.write.WriteCnt = 0;
    stats->sock_callstats.write.WriteErr = 0;
    stats->isochstats.framecnt.prev = stats->isochstats.framecnt.current;
    stats->isochstats.framelostcnt.prev = stats->isochstats.framelostcnt.current;
    stats->isochstats.slipcnt.prev = stats->isochstats.slipcnt.current;
    if (stats->cntDatagrams)
	stats->IPGsum = 0;
}

static inline void reporter_reset_transfer_stats_server_tcp (struct TransferInfo *stats) {
    int ix;
    stats->total.Bytes.prev = stats->total.Bytes.current;
    stats->sock_callstats.read.cntRead = 0;
    for (ix = 0; ix < 8; ix++) {
	stats->sock_callstats.read.bins[ix] = 0;
    }
    reporter_reset_mmm(&stats->transit.current);
    stats->IPGsum = 0;
}

static inline void reporter_reset_transfer_stats_server_udp (struct TransferInfo *stats) {
    // Reset the enhanced stats for the next report interval
    stats->total.Bytes.prev = stats->total.Bytes.current;
    stats->total.Datagrams.prev = stats->PacketID;
    stats->total.OutofOrder.prev = stats->total.OutofOrder.current;
    stats->total.Lost.prev = stats->total.Lost.current;
    stats->total.IPG.prev = stats->total.IPG.current;
    reporter_reset_mmm(&stats->transit.current);
    stats->isochstats.framecnt.prev = stats->isochstats.framecnt.current;
    stats->isochstats.framelostcnt.prev = stats->isochstats.framelostcnt.current;
    stats->isochstats.slipcnt.prev = stats->isochstats.slipcnt.current;
    stats->l2counts.cnt = 0;
    stats->l2counts.unknown = 0;
    stats->l2counts.udpcsumerr = 0;
    stats->l2counts.lengtherr = 0;
    if (stats->cntDatagrams)
	stats->IPGsum = 0;
}

// These do the following
//
// o) set the TransferInfo struct and then calls the individual report output handler
// o) updates the sum and fullduplex reports
//
void reporter_transfer_protocol_server_udp (struct ReporterData *data, int final) {
    struct TransferInfo *stats = &data->info;
    struct TransferInfo *sumstats = (data->GroupSumReport != NULL) ? &data->GroupSumReport->info : NULL;
    struct TransferInfo *fullduplexstats = (data->FullDuplexReport != NULL) ? &data->FullDuplexReport->info : NULL;
    // print a interval report and possibly a partial interval report if this a final
    stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
    stats->cntOutofOrder = stats->total.OutofOrder.current - stats->total.OutofOrder.prev;
    // assume most of the  time out-of-order packets are
    // duplicate packets, so conditionally subtract them from the lost packets.
    stats->cntError = stats->total.Lost.current - stats->total.Lost.prev - stats->cntOutofOrder;
    if (stats->cntError < 0)
	stats->cntError = 0;
    stats->cntDatagrams = stats->PacketID - stats->total.Datagrams.prev;
    stats->cntIPG = stats->total.IPG.current - stats->total.IPG.prev;
    if (stats->latency_histogram) {
        stats->latency_histogram->final = final;
    }

    if (isIsochronous(stats->common)) {
	stats->isochstats.cntFrames = stats->isochstats.framecnt.current - stats->isochstats.framecnt.prev;
	stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current - stats->isochstats.framelostcnt.prev;
	stats->isochstats.cntSlips = stats->isochstats.slipcnt.current - stats->isochstats.slipcnt.prev;
	if (stats->framelatency_histogram) {
	    stats->framelatency_histogram->final = final;
	}

    }
    if (stats->total.Datagrams.current == 1)
	stats->jitter = 0;
    if (sumstats) {
	sumstats->total.OutofOrder.current += stats->total.OutofOrder.current - stats->total.OutofOrder.prev;
	// assume most of the  time out-of-order packets are not
	// duplicate packets, so conditionally subtract them from the lost packets.
	sumstats->total.Lost.current += stats->total.Lost.current - stats->total.Lost.prev;
	sumstats->total.Datagrams.current += stats->PacketID - stats->total.Datagrams.prev;
	sumstats->total.Bytes.current += stats->cntBytes;
	sumstats->total.IPG.current += stats->cntIPG;
	if (sumstats->IPGsum < stats->IPGsum)
	    sumstats->IPGsum = stats->IPGsum;
	sumstats->threadcnt++;
    }
    if (fullduplexstats) {
	fullduplexstats->total.Bytes.current += stats->cntBytes;
	fullduplexstats->total.IPG.current += stats->cntIPG;
	fullduplexstats->total.Datagrams.current += (stats->total.Datagrams.current - stats->total.Datagrams.prev);
	if (fullduplexstats->IPGsum < stats->IPGsum)
	    fullduplexstats->IPGsum = stats->IPGsum;
    }
    if (final) {
	if ((stats->cntBytes > 0) && !TimeZero(stats->ts.intervalTime)) {
	    stats->cntOutofOrder = stats->total.OutofOrder.current - stats->total.OutofOrder.prev;
	    // assume most of the  time out-of-order packets are not
	    // duplicate packets, so conditionally subtract them from the lost packets.
	    stats->cntError = stats->total.Lost.current - stats->total.Lost.prev;
	    stats->cntError -= stats->cntOutofOrder;
	    if (stats->cntError < 0)
		stats->cntError = 0;
	    stats->cntDatagrams = stats->PacketID - stats->total.Datagrams.prev;
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
	    }
	}
	reporter_set_timestamps_time(&stats->ts, TOTAL);
	stats->final = true;
	stats->IPGsum = TimeDifference(stats->ts.packetTime, stats->ts.startTime);
	stats->cntOutofOrder = stats->total.OutofOrder.current;
	// assume most of the  time out-of-order packets are not
	// duplicate packets, so conditionally subtract them from the lost packets.
	stats->cntError = stats->total.Lost.current;
	stats->cntError -= stats->cntOutofOrder;
	if (stats->cntError < 0)
	    stats->cntError = 0;
	stats->cntDatagrams = stats->PacketID;
	stats->cntIPG = stats->total.IPG.current;
	stats->IPGsum = TimeDifference(stats->ts.packetTime, stats->ts.startTime);
	stats->cntBytes = stats->total.Bytes.current;
	stats->l2counts.cnt = stats->l2counts.tot_cnt;
	stats->l2counts.unknown = stats->l2counts.tot_unknown;
	stats->l2counts.udpcsumerr = stats->l2counts.tot_udpcsumerr;
	stats->l2counts.lengtherr = stats->l2counts.tot_lengtherr;
	stats->transit.current = stats->transit.total;
	if (isIsochronous(stats->common)) {
	    stats->isochstats.cntFrames = stats->isochstats.framecnt.current;
	    stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current;
	    stats->isochstats.cntSlips = stats->isochstats.slipcnt.current;
	}
	if (stats->latency_histogram) {
	    stats->latency_histogram->final = 1;
	}
	if (stats->framelatency_histogram) {
	    stats->framelatency_histogram->final = 1;
	}
    }
    if ((stats->output_handler) && !(stats->isMaskOutput))
	(*stats->output_handler)(stats);
    if (!final)
	reporter_reset_transfer_stats_server_udp(stats);
}

void reporter_transfer_protocol_sum_server_udp (struct TransferInfo *stats, int final) {
    if (final) {
	reporter_set_timestamps_time(&stats->ts, TOTAL);
	stats->cntOutofOrder = stats->total.OutofOrder.current;
	// assume most of the  time out-of-order packets are not
	// duplicate packets, so conditionally subtract them from the lost packets.
	stats->cntError = stats->total.Lost.current;
	stats->cntError -= stats->cntOutofOrder;
	if (stats->cntError < 0)
	    stats->cntError = 0;
	stats->cntDatagrams = stats->total.Datagrams.current;
	stats->cntBytes = stats->total.Bytes.current;
	stats->IPGsum = TimeDifference(stats->ts.packetTime, stats->ts.startTime);
	stats->cntIPG = stats->total.IPG.current;
    } else {
	stats->cntOutofOrder = stats->total.OutofOrder.current - stats->total.OutofOrder.prev;
	// assume most of the  time out-of-order packets are not
	// duplicate packets, so conditionally subtract them from the lost packets.
	stats->cntError = stats->total.Lost.current - stats->total.Lost.prev;
	stats->cntError -= stats->cntOutofOrder;
	if (stats->cntError < 0)
	    stats->cntError = 0;
	stats->cntDatagrams = stats->total.Datagrams.current - stats->total.Datagrams.prev;
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	stats->cntIPG = stats->total.IPG.current - stats->total.IPG.prev;
    }
    if ((stats->output_handler) && !(stats->isMaskOutput))
	(*stats->output_handler)(stats);
    if (!final) {
	stats->threadcnt = 0;
	// there is no packet ID for sum server reports, set it to total cnt for calculation
	stats->PacketID = stats->total.Datagrams.current;
	reporter_reset_transfer_stats_server_udp(stats);
    }
}
void reporter_transfer_protocol_sum_client_udp (struct TransferInfo *stats, int final) {
    if (final) {
	reporter_set_timestamps_time(&stats->ts, TOTAL);
	stats->sock_callstats.write.WriteErr = stats->sock_callstats.write.totWriteErr;
	stats->sock_callstats.write.WriteCnt = stats->sock_callstats.write.totWriteCnt;
	stats->cntDatagrams = stats->total.Datagrams.current;
	stats->cntBytes = stats->total.Bytes.current;
	stats->IPGsum = TimeDifference(stats->ts.packetTime, stats->ts.startTime);
	stats->cntIPG = stats->total.IPG.current;
    } else {
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	stats->cntIPG = stats->total.IPG.current - stats->total.IPG.prev;
	stats->cntDatagrams = stats->total.Datagrams.current - stats->total.Datagrams.prev;
    }
    if ((stats->output_handler) && !(stats->isMaskOutput))
	(*stats->output_handler)(stats);

    if (!final) {
	stats->threadcnt = 0;
	reporter_reset_transfer_stats_client_udp(stats);
    } else if ((stats->common->ReportMode != kReport_CSV) && !(stats->isMaskOutput)) {
	printf(report_sumcnt_datagrams, stats->threadcnt, stats->total.Datagrams.current);
	fflush(stdout);
    }
}

void reporter_transfer_protocol_client_udp (struct ReporterData *data, int final) {
    struct TransferInfo *stats = &data->info;
    struct TransferInfo *sumstats = (data->GroupSumReport != NULL) ? &data->GroupSumReport->info : NULL;
    struct TransferInfo *fullduplexstats = (data->FullDuplexReport != NULL) ? &data->FullDuplexReport->info : NULL;
    stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
    stats->cntDatagrams = stats->total.Datagrams.current - stats->total.Datagrams.prev;
    stats->cntIPG = stats->total.IPG.current - stats->total.IPG.prev;
    if (isIsochronous(stats->common)) {
	stats->isochstats.cntFrames = stats->isochstats.framecnt.current - stats->isochstats.framecnt.prev;
	stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current - stats->isochstats.framelostcnt.prev;
	stats->isochstats.cntSlips = stats->isochstats.slipcnt.current - stats->isochstats.slipcnt.prev;
    }
    if (sumstats) {
	sumstats->total.Bytes.current += stats->cntBytes;
	sumstats->sock_callstats.write.WriteErr += stats->sock_callstats.write.WriteErr;
	sumstats->sock_callstats.write.WriteCnt += stats->sock_callstats.write.WriteCnt;
	sumstats->sock_callstats.write.totWriteErr += stats->sock_callstats.write.WriteErr;
	sumstats->sock_callstats.write.totWriteCnt += stats->sock_callstats.write.WriteCnt;
	sumstats->total.Datagrams.current += stats->cntDatagrams;
	if (sumstats->IPGsum < stats->IPGsum)
	    sumstats->IPGsum = stats->IPGsum;
	sumstats->total.IPG.current += stats->cntIPG;
	sumstats->threadcnt++;
    }
    if (fullduplexstats) {
	fullduplexstats->total.Bytes.current += stats->cntBytes;
	fullduplexstats->total.IPG.current += stats->cntIPG;
	fullduplexstats->total.Datagrams.current += stats->cntDatagrams;
	if (fullduplexstats->IPGsum < stats->IPGsum)
	    fullduplexstats->IPGsum = stats->IPGsum;
    }
    if (final) {
	reporter_set_timestamps_time(&stats->ts, TOTAL);
	stats->cntBytes = stats->total.Bytes.current;
	stats->sock_callstats.write.WriteErr = stats->sock_callstats.write.totWriteErr;
	stats->sock_callstats.write.WriteCnt = stats->sock_callstats.write.totWriteCnt;
	stats->cntIPG = stats->total.IPG.current;
	stats->cntDatagrams = stats->PacketID;
	stats->IPGsum = TimeDifference(stats->ts.packetTime, stats->ts.startTime);
	if (isIsochronous(stats->common)) {
	    stats->isochstats.cntFrames = stats->isochstats.framecnt.current;
	    stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current;
	    stats->isochstats.cntSlips = stats->isochstats.slipcnt.current;
	}
    } else {
	if (stats->ts.iEnd > 0) {
	    stats->cntIPG = (stats->total.IPG.current - stats->total.IPG.prev);
	} else {
	    stats->cntIPG = 0;
	}
    }
    if ((stats->output_handler) && !(stats->isMaskOutput)) {
	(*stats->output_handler)(stats);
	if (final && (stats->common->ReportMode != kReport_CSV)) {
	    printf(report_datagrams, stats->common->transferID, stats->total.Datagrams.current);
	    fflush(stdout);
	}
    }
    reporter_reset_transfer_stats_client_udp(stats);
}

void reporter_transfer_protocol_server_tcp (struct ReporterData *data, int final) {
    struct TransferInfo *stats = &data->info;
    struct TransferInfo *sumstats = (data->GroupSumReport != NULL) ? &data->GroupSumReport->info : NULL;
    struct TransferInfo *fullduplexstats = (data->FullDuplexReport != NULL) ? &data->FullDuplexReport->info : NULL;
    stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
    int ix;
    if (stats->framelatency_histogram) {
        stats->framelatency_histogram->final = 0;
    }
    if (sumstats) {
	sumstats->threadcnt++;
	sumstats->total.Bytes.current += stats->cntBytes;
        sumstats->sock_callstats.read.cntRead += stats->sock_callstats.read.cntRead;
        sumstats->sock_callstats.read.totcntRead += stats->sock_callstats.read.cntRead;
        for (ix = 0; ix < TCPREADBINCOUNT; ix++) {
	    sumstats->sock_callstats.read.bins[ix] += stats->sock_callstats.read.bins[ix];
	    sumstats->sock_callstats.read.totbins[ix] += stats->sock_callstats.read.bins[ix];
        }
    }
    if (fullduplexstats) {
	fullduplexstats->total.Bytes.current += stats->cntBytes;
    }
    if (final) {
	if ((stats->cntBytes > 0) && stats->output_handler && !TimeZero(stats->ts.intervalTime)) {
	    // print a partial interval report if enable and this a final
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		if (isIsochronous(stats->common)) {
		    stats->isochstats.cntFrames = stats->isochstats.framecnt.current - stats->isochstats.framecnt.prev;
		    stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current - stats->isochstats.framelostcnt.prev;
		    stats->isochstats.cntSlips = stats->isochstats.slipcnt.current - stats->isochstats.slipcnt.prev;
		}
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
		reporter_reset_transfer_stats_server_tcp(stats);
	    }
        }
        if (stats->framelatency_histogram) {
	    stats->framelatency_histogram->final = 1;
	}
	stats->final = true;
	reporter_set_timestamps_time(&stats->ts, TOTAL);
        stats->cntBytes = stats->total.Bytes.current;
	stats->IPGsum = stats->ts.iEnd;
        stats->sock_callstats.read.cntRead = stats->sock_callstats.read.totcntRead;
        for (ix = 0; ix < TCPREADBINCOUNT; ix++) {
	    stats->sock_callstats.read.bins[ix] = stats->sock_callstats.read.totbins[ix];
        }
	if (isIsochronous(stats->common)) {
	    stats->isochstats.cntFrames = stats->isochstats.framecnt.current;
	    stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current;
	    stats->isochstats.cntSlips = stats->isochstats.slipcnt.current;
	}
	stats->transit.current = stats->transit.total;
	if (stats->framelatency_histogram) {
	    stats->framelatency_histogram->final = 1;
	}
    } else if (isIsochronous(stats->common)) {
	stats->isochstats.cntFrames = stats->isochstats.framecnt.current - stats->isochstats.framecnt.prev;
	stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current - stats->isochstats.framelostcnt.prev;
	stats->isochstats.cntSlips = stats->isochstats.slipcnt.current - stats->isochstats.slipcnt.prev;
    }
    if ((stats->output_handler) && !stats->isMaskOutput) {
	(*stats->output_handler)(stats);
	if (isFrameInterval(stats->common) && stats->framelatency_histogram) {
	    histogram_print(stats->framelatency_histogram, stats->ts.iStart, stats->ts.iEnd);
	}
    }
    if (!final)
	reporter_reset_transfer_stats_server_tcp(stats);
}

void reporter_transfer_protocol_client_tcp (struct ReporterData *data, int final) {
    struct TransferInfo *stats = &data->info;
    struct TransferInfo *sumstats = (data->GroupSumReport != NULL) ? &data->GroupSumReport->info : NULL;
    struct TransferInfo *fullduplexstats = (data->FullDuplexReport != NULL) ? &data->FullDuplexReport->info : NULL;
    stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
    if (stats->latency_histogram) {
        stats->latency_histogram->final = final;
    }
    if (stats->write_histogram) {
        stats->write_histogram->final = final;
    }
    if (isIsochronous(stats->common)) {
	if (final) {
	    stats->isochstats.cntFrames = stats->isochstats.framecnt.current;
	    stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current;
	    stats->isochstats.cntSlips = stats->isochstats.slipcnt.current;
	} else {
	    stats->isochstats.cntFrames = stats->isochstats.framecnt.current - stats->isochstats.framecnt.prev;
	    stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current - stats->isochstats.framelostcnt.prev;
	    stats->isochstats.cntSlips = stats->isochstats.slipcnt.current - stats->isochstats.slipcnt.prev;
	}
    }
    if (sumstats) {
	sumstats->total.Bytes.current += stats->cntBytes;
	sumstats->sock_callstats.write.WriteErr += stats->sock_callstats.write.WriteErr;
	sumstats->sock_callstats.write.WriteCnt += stats->sock_callstats.write.WriteCnt;
	sumstats->sock_callstats.write.totWriteErr += stats->sock_callstats.write.WriteErr;
	sumstats->sock_callstats.write.totWriteCnt += stats->sock_callstats.write.WriteCnt;
	sumstats->threadcnt++;
#if HAVE_TCP_STATS
	sumstats->sock_callstats.write.tcpstats.retry += stats->sock_callstats.write.tcpstats.retry;
	sumstats->sock_callstats.write.tcpstats.retry_tot += stats->sock_callstats.write.tcpstats.retry;
#endif
    }
    if (fullduplexstats) {
	fullduplexstats->total.Bytes.current += stats->cntBytes;
    }
    if (final) {
	if (stats->latency_histogram) {
	    stats->latency_histogram->final = 1;
	}
	if (stats->write_histogram) {
	    stats->write_histogram->final = 1;
	}
	if ((stats->cntBytes > 0) && stats->output_handler && !TimeZero(stats->ts.intervalTime)) {
	    // print a partial interval report if enable and this a final
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		if (isIsochronous(stats->common)) {
		    stats->isochstats.cntFrames = stats->isochstats.framecnt.current - stats->isochstats.framecnt.prev;
		    stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current - stats->isochstats.framelostcnt.prev;
		    stats->isochstats.cntSlips = stats->isochstats.slipcnt.current - stats->isochstats.slipcnt.prev;
		}
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
		reporter_reset_transfer_stats_client_tcp(stats);
	    }
        }
	if (isIsochronous(stats->common)) {
	    stats->isochstats.cntFrames = stats->isochstats.framecnt.current;
	    stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current;
	    stats->isochstats.cntSlips = stats->isochstats.slipcnt.current;
	}
	stats->sock_callstats.write.WriteErr = stats->sock_callstats.write.totWriteErr;
	stats->sock_callstats.write.WriteCnt = stats->sock_callstats.write.totWriteCnt;
#if HAVE_TCP_STATS
	stats->sock_callstats.write.tcpstats.retry = stats->sock_callstats.write.tcpstats.retry_tot;
#endif
	if (stats->framelatency_histogram) {
	    stats->framelatency_histogram->final = 1;
	}
	stats->cntBytes = stats->total.Bytes.current;
	stats->write_mmm.current = stats->write_mmm.total;
	reporter_set_timestamps_time(&stats->ts, TOTAL);
    } else if (isIsochronous(stats->common)) {
	stats->isochstats.cntFrames = stats->isochstats.framecnt.current - stats->isochstats.framecnt.prev;
	stats->isochstats.cntFramesMissed = stats->isochstats.framelostcnt.current - stats->isochstats.framelostcnt.prev;
	stats->isochstats.cntSlips = stats->isochstats.slipcnt.current - stats->isochstats.slipcnt.prev;
    }
    if ((stats->output_handler) && !(stats->isMaskOutput)) {
	(*stats->output_handler)(stats);
    }
    if (!final)
	reporter_reset_transfer_stats_client_tcp(stats);
}

/*
 * Handles summing of threads
 */
void reporter_transfer_protocol_sum_client_tcp (struct TransferInfo *stats, int final) {
    if (!final || (final && (stats->cntBytes > 0) && !TimeZero(stats->ts.intervalTime))) {
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	if (final) {
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
		reporter_reset_transfer_stats_client_tcp(stats);
	    }
	} else if ((stats->output_handler) && !(stats->isMaskOutput)) {
	    (*stats->output_handler)(stats);
	    stats->threadcnt = 0;
	}
	reporter_reset_transfer_stats_client_tcp(stats);
    }
    if (final) {
	stats->sock_callstats.write.WriteErr = stats->sock_callstats.write.totWriteErr;
	stats->sock_callstats.write.WriteCnt = stats->sock_callstats.write.totWriteCnt;
#if HAVE_TCP_STATS
	stats->sock_callstats.write.tcpstats.retry = stats->sock_callstats.write.tcpstats.retry_tot;
#endif
	stats->cntBytes = stats->total.Bytes.current;
	reporter_set_timestamps_time(&stats->ts, TOTAL);
	if ((stats->output_handler) && !(stats->isMaskOutput))
	    (*stats->output_handler)(stats);
    }
}

void reporter_transfer_protocol_client_bb_tcp (struct ReporterData *data, int final) {
    struct TransferInfo *stats = &data->info;

    if (final) {
	if ((stats->cntBytes > 0) && stats->output_handler && !TimeZero(stats->ts.intervalTime)) {
	    // print a partial interval report if enable and this a final
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
		reporter_reset_transfer_stats_client_tcp(stats);
	    }
        }
#if HAVE_TCP_STATS
	stats->sock_callstats.write.tcpstats.retry = stats->sock_callstats.write.tcpstats.retry_tot;
#endif
	stats->cntBytes = stats->total.Bytes.current;
	reporter_set_timestamps_time(&stats->ts, TOTAL);
	stats->final=1;
    } else {
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
    }
    if ((stats->output_handler) && !(stats->isMaskOutput))
        (*stats->output_handler)(stats);
    if (!final) {
	reporter_reset_transfer_stats_client_tcp(stats);
    }
}

void reporter_transfer_protocol_server_bb_tcp (struct ReporterData *data, int final) {
    struct TransferInfo *stats = &data->info;
    if (final) {
	if ((stats->cntBytes > 0) && stats->output_handler && !TimeZero(stats->ts.intervalTime)) {
	    // print a partial interval report if enable and this a final
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
		reporter_reset_transfer_stats_server_tcp(stats);
	    }
        }
#if HAVE_TCP_STATS

	stats->sock_callstats.write.tcpstats.retry = stats->sock_callstats.write.tcpstats.retry_tot;
#endif
	stats->cntBytes = stats->total.Bytes.current;
	reporter_set_timestamps_time(&stats->ts, TOTAL);
	stats->final=1;
    } else {
	stats->final=0;
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
    }
    if ((stats->output_handler) && !(stats->isMaskOutput))
	(*stats->output_handler)(stats);
    if (!final)
	reporter_reset_transfer_stats_client_tcp(stats);
}

void reporter_transfer_protocol_sum_server_tcp (struct TransferInfo *stats, int final) {
    if (!final || (final && (stats->cntBytes > 0) && !TimeZero(stats->ts.intervalTime))) {
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	if (final) {
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
	    }
	} else if ((stats->output_handler) && !(stats->isMaskOutput)) {
	    (*stats->output_handler)(stats);
	    stats->threadcnt = 0;
	}
	reporter_reset_transfer_stats_server_tcp(stats);
    }
    if (final) {
	int ix;
	stats->cntBytes = stats->total.Bytes.current;
	stats->sock_callstats.read.cntRead = stats->sock_callstats.read.totcntRead;
	for (ix = 0; ix < TCPREADBINCOUNT; ix++) {
	    stats->sock_callstats.read.bins[ix] = stats->sock_callstats.read.totbins[ix];
	}
	stats->cntBytes = stats->total.Bytes.current;
	reporter_set_timestamps_time(&stats->ts, TOTAL);
	if ((stats->output_handler) && !(stats->isMaskOutput))
	    (*stats->output_handler)(stats);
    }
}
void reporter_transfer_protocol_fullduplex_tcp (struct TransferInfo *stats, int final) {
    if (!final || (final && (stats->cntBytes > 0) && !TimeZero(stats->ts.intervalTime))) {
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	if (final) {
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
	    }
	}
	stats->total.Bytes.prev = stats->total.Bytes.current;
    }
    if (final) {
	stats->cntBytes = stats->total.Bytes.current;
	reporter_set_timestamps_time(&stats->ts, TOTAL);
    } else {
	reporter_set_timestamps_time(&stats->ts, INTERVAL);
    }
    if ((stats->output_handler) && !(stats->isMaskOutput))
	(*stats->output_handler)(stats);
}

void reporter_transfer_protocol_fullduplex_udp (struct TransferInfo *stats, int final) {
    if (!final || (final && (stats->cntBytes > 0) && !TimeZero(stats->ts.intervalTime))) {
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	stats->cntDatagrams = stats->total.Datagrams.current - stats->total.Datagrams.prev;
	stats->cntIPG = stats->total.IPG.current - stats->total.IPG.prev;
	if (final) {
	    if ((stats->output_handler) && !(stats->isMaskOutput)) {
		reporter_set_timestamps_time(&stats->ts, FINALPARTIAL);
		if ((stats->ts.iEnd - stats->ts.iStart) > stats->ts.significant_partial)
		    (*stats->output_handler)(stats);
	    }
	}
	stats->total.Bytes.prev = stats->total.Bytes.current;
	stats->total.IPG.prev = stats->total.IPG.current;
	stats->total.Datagrams.prev = stats->total.Datagrams.current;
    }
    if (final) {
	stats->cntBytes = stats->total.Bytes.current;
	stats->cntBytes = stats->total.Bytes.current;
	stats->cntDatagrams = stats->total.Datagrams.current ;
	stats->cntIPG = stats->total.IPG.current;
	stats->IPGsum = TimeDifference(stats->ts.packetTime, stats->ts.startTime);
	reporter_set_timestamps_time(&stats->ts, TOTAL);
    } else {
	reporter_set_timestamps_time(&stats->ts, INTERVAL);
    }
    if ((stats->output_handler) && !(stats->isMaskOutput))
	(*stats->output_handler)(stats);
    if (stats->cntDatagrams)
        stats->IPGsum = 0.0;
}

// Conditional print based on time
int reporter_condprint_time_interval_report (struct ReporterData *data, struct ReportStruct *packet) {
    struct TransferInfo *stats = &data->info;
    assert(stats!=NULL);
    //   printf("***sum handler = %p\n", (void *) data->GroupSumReport->transfer_protocol_sum_handler);
    int advance_jobq = 0;
    // Print a report if packet time exceeds the next report interval time,
    // Also signal to the caller to move to the next report (or packet ring)
    // if there was output. This will allow for more precise interval sum accounting.
    // printf("***** pt = %ld.%ld next = %ld.%ld\n", packet->packetTime.tv_sec, packet->packetTime.tv_usec, stats->ts.nextTime.tv_sec, stats->ts.nextTime.tv_usec);
    if (TimeDifference(stats->ts.nextTime, packet->packetTime) < 0) {
	assert(data->transfer_protocol_handler!=NULL);
	advance_jobq = 1;
	struct TransferInfo *sumstats = (data->GroupSumReport ? &data->GroupSumReport->info : NULL);
	struct TransferInfo *fullduplexstats = (data->FullDuplexReport ? &data->FullDuplexReport->info : NULL);
	stats->ts.packetTime = packet->packetTime;
#ifdef DEBUG_PPS
	printf("*** packetID TRIGGER = %ld pt=%ld.%ld empty=%d nt=%ld.%ld\n",packet->packetID, packet->packetTime.tv_sec, packet->packetTime.tv_usec, packet->emptyreport, stats->ts.nextTime.tv_sec, stats->ts.nextTime.tv_usec);
#endif
	reporter_set_timestamps_time(&stats->ts, INTERVAL);
	(*data->transfer_protocol_handler)(data, 0);
	if (fullduplexstats && ((++data->FullDuplexReport->threads) == 2) && isEnhanced(stats->common)) {
	    data->FullDuplexReport->threads = 0;
	    assert(data->FullDuplexReport->transfer_protocol_sum_handler != NULL);
	    (*data->FullDuplexReport->transfer_protocol_sum_handler)(fullduplexstats, 0);
	}
	if (sumstats) {
	    if ((++data->GroupSumReport->threads) == data->GroupSumReport->reference.count)   {
		data->GroupSumReport->threads = 0;
		if ((data->GroupSumReport->reference.count > (fullduplexstats ? 2 : 1)) || \
		    isSumOnly(data->info.common)) {
		    sumstats->isMaskOutput = false;
		} else {
		    sumstats->isMaskOutput = true;
		}
		reporter_set_timestamps_time(&sumstats->ts, INTERVAL);
		assert(data->GroupSumReport->transfer_protocol_sum_handler != NULL);
		(*data->GroupSumReport->transfer_protocol_sum_handler)(sumstats, 0);
	    }
	}
        // In the (hopefully unlikely event) the reporter fell behind
        // output the missed reports to catch up
	if ((stats->output_handler) && !(stats->isMaskOutput))
	    reporter_transfer_protocol_missed_reports(stats, packet);
    }
    return advance_jobq;
}

// Conditional print based on bursts or frames
int reporter_condprint_frame_interval_report_server_udp (struct ReporterData *data, struct ReportStruct *packet) {
    struct TransferInfo *stats = &data->info;
    int advance_jobq = 0;
    // first packet of a burst and not a duplicate
    if ((packet->burstsize == (packet->remaining + packet->packetLen)) && (stats->matchframeID != packet->frameID)) {
	stats->matchframeID=packet->frameID;
    }
    if ((packet->packetLen == packet->remaining) && (packet->frameID == stats->matchframeID)) {
	if ((stats->ts.iStart = TimeDifference(stats->ts.nextTime, stats->ts.startTime)) < 0)
	    stats->ts.iStart = 0.0;
	stats->frameID = packet->frameID;
	stats->ts.iEnd = TimeDifference(packet->packetTime, stats->ts.startTime);
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	stats->cntOutofOrder = stats->total.OutofOrder.current - stats->total.OutofOrder.prev;
	// assume most of the  time out-of-order packets are not
	// duplicate packets, so conditionally subtract them from the lost packets.
	stats->cntError = stats->total.Lost.current - stats->total.Lost.prev;
	stats->cntError -= stats->cntOutofOrder;
	if (stats->cntError < 0)
	    stats->cntError = 0;
	stats->cntDatagrams = stats->PacketID - stats->total.Datagrams.prev;
	if ((stats->output_handler) && !(stats->isMaskOutput))
	    (*stats->output_handler)(stats);
	reporter_reset_transfer_stats_server_udp(stats);
	advance_jobq = 1;
    }
    return advance_jobq;
}

int reporter_condprint_frame_interval_report_server_tcp (struct ReporterData *data, struct ReportStruct *packet) {
    fprintf(stderr, "FIX ME\n");
    return 1;
}

int reporter_condprint_burst_interval_report_server_tcp (struct ReporterData *data, struct ReportStruct *packet) {
    struct TransferInfo *stats = &data->info;
    int advance_jobq = 0;
    if (packet->transit_ready) {
	stats->ts.prevpacketTime = packet->prevSentTime;
	stats->ts.packetTime = packet->packetTime;
	reporter_set_timestamps_time(&stats->ts, INTERVALPARTIAL);
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	if ((stats->output_handler) && !(stats->isMaskOutput))
	    (*stats->output_handler)(stats);
	reporter_reset_transfer_stats_server_tcp(stats);
	advance_jobq = 1;
    }
    return advance_jobq;
}

int reporter_condprint_burst_interval_report_client_tcp (struct ReporterData *data, struct ReportStruct *packet) {
    struct TransferInfo *stats = &data->info;
    int advance_jobq = 0;
    // first packet of a burst and not a duplicate
    if (packet->transit_ready) {
        reporter_handle_packet_oneway_transit(stats, packet);
//	printf("****sndpkt=%ld.%ld rxpkt=%ld.%ld\n", packet->sentTime.tv_sec, packet->sentTime.tv_usec, packet->packetTime.tv_sec,packet->packetTime.tv_usec);
	stats->ts.prevpacketTime = packet->prevSentTime;
	stats->ts.packetTime = packet->packetTime;
	reporter_set_timestamps_time(&stats->ts, INTERVALPARTIAL);
	stats->cntBytes = stats->total.Bytes.current - stats->total.Bytes.prev;
	if ((stats->output_handler) && !(stats->isMaskOutput))
	    (*stats->output_handler)(stats);
	reporter_reset_transfer_stats_client_tcp(stats);
	advance_jobq = 1;
    }
    return advance_jobq;
}

#ifdef __cplusplus
} /* end extern "C" */
#endif
