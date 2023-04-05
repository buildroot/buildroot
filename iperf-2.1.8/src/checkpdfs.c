/*---------------------------------------------------------------
 * Copyright (c) 2017
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
 * pdfs.c
 * Produce probability distribution functions, expected to be used
 * for iperf client traffic emulations
 *
 * by Robert J. McMahon (rjmcmahon@rjmcmahon.com, bob.mcmahon@broadcom.com)
 * ------------------------------------------------------------------- */

/* Produce normal and log normal
 *
 * Implements the Polar form of the Box-Muller Transformation
 *
 *
*/
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <unistd.h>
#include "headers.h"
#include "util.h"
#include "pdfs.h"

#define MAXBINS 1024
#define TRUE 1
#define FALSE 0
#define MILLION 1000000
#define BILLION 1000000000

#ifdef HAVE_CLOCK_GETTIME
static double timespec_diff(struct timespec tv1, struct timespec tv0);
#else
static double timeval_diff (struct timeval tv1, struct timeval tv0);
#endif

int main (int argc, char **argv) {
    int c, i;
    int minbin = MAXBINS;
    int maxbin = 0;
    int bincount=MAXBINS;
    time_t t;
    int histogram[MAXBINS];
    float mean=100.0;
    float variance=30.0;
    int count = 10000;
    int gaussian = TRUE;
    int printout = FALSE;
    int speedonly = FALSE;
    int exectime;
    int random = FALSE;
    double total;
    double binwidth=1.0;

    while ((c=getopt(argc, argv, "b:c:lm:prsv:w:")) != -1)
	switch (c) {
	case 'b':
	    bincount = atoi(optarg);
	    break;
	case 'c':
	    count = atoi(optarg);
	    break;
	case 'l':
	    gaussian = FALSE;
	    break;
	case 'm':
	    mean = bitorbyte_atof(optarg);
	    break;
	case 'p':
	    printout = TRUE;
	    break;
	case 'r':
	    random = TRUE;
	    break;
	case 's':
	    speedonly = TRUE;
	    break;
	case 'v':
	    variance = bitorbyte_atof(optarg);
	    break;
	case 'w':
	    binwidth = bitorbyte_atof(optarg);
	    break;
	case '?':
	default:
	    fprintf(stderr,"Usage -b bins, -c count, -l log normal, -m mean, -p print, -s speed only, -v variance");
	    exit(-1);
	}
    if (bincount > MAXBINS) {
	int max = MAXBINS;
	fprintf(stderr, "Maximum number of bins is %d while %d requested\n", max, bincount);
	abort();
    }
    /* Intializes random number generator */
    if (random) {
	srand((unsigned) time(&t));
	printf("seed = %ld\n", t);
    }
    memset(histogram, 0, sizeof(histogram));
#ifdef HAVE_CLOCK_GETTIME
    struct timespec t1;
    clock_gettime(CLOCK_REALTIME, &t1);
#else
    struct timeval t1;
    gettimeofday( &t1, NULL );
#endif
    if (gaussian) {
	for( i = 0 ; i < count ; i++ )  {
	    int result = round(normal(mean,variance)/binwidth);
	    if (!speedonly) {
		if (result >= 0 && result < (MAXBINS - 1)) {
		    histogram[result]++;
		    if (result < minbin)
			minbin = result;
		    if (result > maxbin)
			maxbin = result;
		}
	    }
	}
    } else {
	for( i = 0 ; i < count ; i++ )  {
	    int result = round(lognormal(mean,variance)/binwidth);
	    if (!speedonly) {
		if (result >= 0 && result < (MAXBINS - 1)) {
		    histogram[result]++;
		    if (result < minbin)
			minbin = result;
		    if (result > maxbin)
			maxbin = result;
		}
	    }
	}
    }
#ifdef HAVE_CLOCK_GETTIME
    struct timespec t2;
    clock_gettime(CLOCK_REALTIME, &t2);
    total = timespec_diff(t2, t1);
#else
    struct timeval t2;
    gettimeofday( &t2, NULL );
    total = timeval_diff(t2, t1);
#endif
    if (printout) {
	for( i = minbin ; i <= maxbin ; i++ )
	    printf("%.0f %d\n", i * binwidth, histogram[i]);
    }
    exectime = round(1e9 * total / count);
    if (!printout) {
	printf("Total time=%f secs, count= %d, average generate time of %d nanoseconds\n", total, count, exectime);
    }
    return(0);
}
#ifdef HAVE_CLOCK_GETTIME
// tv1 assumed greater than tv0
static double timespec_diff (struct timespec tv1, struct timespec tv0) {
    double result;
    if (tv1.tv_nsec < tv0.tv_nsec) {
	tv1.tv_nsec += BILLION;
	tv1.tv_sec--;
    }
    result = (double) (((tv1.tv_sec - tv0.tv_sec) * BILLION) + (tv1.tv_nsec - tv0.tv_nsec));
    return (result / 1e9);
}
#else
// tv1 assumed greater than tv0
static double timeval_diff (struct timeval tv1, struct timeval tv0) {
    double result;
    if (tv1.tv_usec < tv0.tv_usec) {
	tv1.tv_usec += MILLION;
	tv1.tv_sec--;
    }
    result = (double) (((tv1.tv_sec - tv0.tv_sec) * MILLION) + (tv1.tv_usec - tv0.tv_usec));
    return (result / 1e6);
}
#endif
