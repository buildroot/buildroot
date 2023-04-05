/*---------------------------------------------------------------
 * Copyright (c) 2014
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
 * checkdelay.c
 * Simple tool to measure mean/min/max of nanosleep
 * by Robert J. McMahon (rjmcmahon@rjmcmahon.com, rmcmahon@broadcom.com)
 * ------------------------------------------------------------------- */
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <unistd.h>
#include "headers.h"
#include "util.h"
#include "delay.h"
#if HAVE_SCHED_SETSCHEDULER
#include <sched.h>
#ifdef HAVE_MLOCKALL
#include <sys/mman.h>
#endif
#endif



#define BILLION 1000000000
#define MILLION 1000000

int main (int argc, char **argv) {
    double sum=0;
    double time1, time2;
    double delta, max=0, min=-1;
    int ix, delay=1,loopcount=1000;
    int c;
    int clockgettime = 0, kalman = 0;
#if HAVE_DECL_CPU_SET
    int affinity = 0;
#endif
#if HAVE_SCHED_SETSCHEDULER
    int realtime = 0;
    struct sched_param sp;
#endif
#ifdef HAVE_CLOCK_GETTIME
    struct timespec t1;
#else
    struct timeval t1;
#endif

    while ((c=getopt(argc, argv, "a:bkd:i:r")) != -1)
	switch (c) {
	case 'b':
	    clockgettime = 1;
	    break;
	case 'k':
	    kalman = 1;
	    break;
	case 'd':
	    delay = atoi(optarg);
	    break;
	case 'i':
	    loopcount = atoi(optarg);
	    break;
#if HAVE_DECL_CPU_SET
	case 'a':
	    affinity=atoi(optarg);
	    break;
#endif
#if HAVE_SCHED_SETSCHEDULER
	case 'r':
	    realtime = 1;
	    break;
#endif
	case '?':
	    fprintf(stderr,"Usage -b busyloop, -d usec delay, -i iterations"
#if HAVE_DECL_CPU_SET
		    ", -a affinity"
#endif
#if HAVE_SCHED_SETSCHEDULER
		    ", -r realtime"
#endif
		    "\n");
	    return 1;
	default:
	    abort();
	}

#ifndef HAVE_NANOSLEEP
    clockgettime = 1;
#endif

#if HAVE_SCHED_SETSCHEDULER
    if (realtime) {
	fprintf(stdout,"Setting scheduler to realtime via SCHED_RR\n");
	// SCHED_OTHER, SCHED_FIFO, SCHED_RR
	sp.sched_priority = sched_get_priority_max(SCHED_RR);
	WARN_errno(sched_setscheduler(0, SCHED_RR, &sp) < 0,
		   "Client set scheduler");
#ifdef HAVE_MLOCKALL
	// lock the threads memory
	WARN_errno(mlockall(MCL_CURRENT | MCL_FUTURE) != 0, "mlockall");
#endif
    }
#if HAVE_DECL_CPU_SET
    if (affinity) {
	fprintf(stdout,"CPU affinity set to %d\n", affinity);
	cpu_set_t myset;
	CPU_ZERO(&myset);
	CPU_SET(affinity,&myset);
    }
#endif
#endif
    if (loopcount > 1000)
        fprintf(stdout,"Measuring %s over %.0e iterations using %d usec delay\n",
		kalman ? "kalman" :
		clockgettime ? "clock_gettime" : "nanosleep",
		(double) loopcount, delay);
    else
        fprintf(stdout,"Measuring %s over %d iterations using %d usec delay\n",
		kalman ? "kalman" :
		clockgettime ? "clock_gettime" : "nanosleep",
		loopcount, delay);
    fflush(stdout);
    for (ix=0; ix < loopcount; ix++) {
	// Find the max jitter for delay call
#ifdef HAVE_CLOCK_GETTIME
        clock_gettime(CLOCK_REALTIME, &t1);
	time1 = t1.tv_sec + (t1.tv_nsec / 1000000000.0);
#else
	gettimeofday( &t1, NULL );
	time1 = t1.tv_sec + (t1.tv_usec / 1000000.0);
#endif
#ifdef HAVE_KALMAN
	if (kalman) {
	    delay_kalman(delay);
	} else
#endif
	if (clockgettime) {
	    delay_busyloop(delay);
	} else {
#ifdef HAVE_NANOSLEEP
	    delay_nanosleep(delay);
#endif
	}
#ifdef HAVE_CLOCK_GETTIME
	clock_gettime(CLOCK_REALTIME, &t1);
	time2 = t1.tv_sec + (t1.tv_nsec / 1000000000.0);
#else
	gettimeofday( &t1, NULL );
	time2 = t1.tv_sec + (t1.tv_usec / 1000000.0);
#endif
	delta = (time2 - time1) * 1e6;
	if (delta > max) {
	  max = delta;
	}
	if (delta < min || min < 0) {
	  min = delta;
	}
	sum += (double) delta;
    }
    fprintf(stdout,"delay=%.03f/%.03f/%.03f usec (mean/min/max)\n",
	    (sum / loopcount), min, max);
    return(0);
}
