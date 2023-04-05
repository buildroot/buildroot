/*---------------------------------------------------------------
 * Copyright (c) 2021
 * Broadcom Corporation
 * All Rights Reserved.
 *---------------------------------------------------------------
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated
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
 * Neither the name of Broadcom Coporation,
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
 *
 * gettcpinfo.c
 * Suppport for tcp info in a portable way
 *
 * by Robert J. McMahon (rjmcmahon@rjmcmahon.com, bob.mcmahon@broadcom.com)
 * -------------------------------------------------------------------
 */
#include "headers.h"
#include "gettcpinfo.h"
#ifdef HAVE_THREAD_DEBUG
// needed for thread_debug
#include "Thread.h"
#endif

#if HAVE_TCP_STATS
inline void gettcpinfo (int sock, struct iperf_tcpstats *stats) {
    assert(stats);
#if HAVE_DECL_TCP_INFO
    struct tcp_info tcp_info_buf;
    socklen_t tcp_info_length = sizeof(struct tcp_info);
    if ((sock > 0) && !(getsockopt(sock, IPPROTO_TCP, TCP_INFO, &tcp_info_buf, &tcp_info_length) < 0)) {
        stats->cwnd = tcp_info_buf.tcpi_snd_cwnd * tcp_info_buf.tcpi_snd_mss / 1024;
	stats->rtt = tcp_info_buf.tcpi_rtt;
	stats->rttvar = tcp_info_buf.tcpi_rttvar;
	stats->retry_tot = tcp_info_buf.tcpi_total_retrans;
	stats->mss_negotiated = tcp_info_buf.tcpi_snd_mss;
	stats->isValid  = true;
#elif HAVE_DECL_TCP_CONNECTION_INFO
    struct tcp_connection_info tcp_info_buf;
    socklen_t tcp_info_length = sizeof(struct tcp_connection_info);
    if ((sock > 0) && !(getsockopt(sock, IPPROTO_TCP, TCP_CONNECTION_INFO, &tcp_info_buf, &tcp_info_length) < 0)) {
#ifdef __APPLE__
	stats->cwnd = tcp_info_buf.tcpi_snd_cwnd / 1024;
#else
	stats->cwnd = tcp_info_buf.tcpi_snd_cwnd * tcp_info_buf.tcpi_maxseg / 1024;
#endif
	stats->rtt = tcp_info_buf.tcpi_rttcur * 1000; // OS X units is ms
	stats->rttvar = tcp_info_buf.tcpi_rttvar;
	stats->retry_tot = tcp_info_buf.tcpi_txretransmitpackets;
	stats->mss_negotiated = tcp_info_buf.tcpi_maxseg;
	stats->isValid  = true;
#endif
    } else {
	stats->rtt = 1;
	stats->isValid = false;
    }
}
inline void tcpstats_copy (struct iperf_tcpstats *stats_dst, struct iperf_tcpstats *stats_src) {
    stats_dst->cwnd = stats_src->cwnd;
    stats_dst->rtt = stats_src->rtt;
    stats_dst->rttvar = stats_src->rttvar;
    stats_dst->mss_negotiated = stats_src->mss_negotiated;
    stats_dst->retry_tot = stats_src->retry_tot;
    stats_dst->connecttime = stats_src->connecttime;
    stats_dst->isValid = stats_src->isValid;
}
#else
#if WIN32
inline void gettcpinfo (SOCKET sock, struct iperf_tcpstats *stats) {
#else
inline void gettcpinfo (int sock, struct iperf_tcpstats *stats) {
#endif
    stats->rtt = 1;
    stats->isValid  = false;
};
inline void tcpstats_copy (struct iperf_tcpstats *stats_dst, struct iperf_tcpstats *stats_src) {
    stats_dst->rtt = stats_src->rtt;
    stats_dst->isValid = stats_src->isValid;
}
#endif
