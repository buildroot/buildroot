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
 * delay.c
 * by Mark Gates <mgates@nlanr.net>
 * updates
 * by Robert J. McMahon <rmcmahon@broadcom.com> <rjmcmahon@rjmcmahon.com>
 * -------------------------------------------------------------------
 * attempts at accurate microsecond delays
 * ------------------------------------------------------------------- */
#include "headers.h"
#include "util.h"
#include "delay.h"
#include "Thread.h"
#include <math.h>

#define MILLION 1000000
#define BILLION 1000000000

/* -------------------------------------------------------------------
 * A micro-second delay function
 * o Use a busy loop or nanosleep
 *
 * Some notes:
 * o clock nanosleep with a relative is preferred (see man page for why)
 * o clock_gettime() (if available) is preferred over gettimeofday()
 *   as it give nanosecond resolution and should be more efficient.
 *   It also supports CLOCK_MONOTONIC and CLOCK_MONOTONIC_RAW
 *   though CLOCK_REALTIME is being used by the code.
 * o This code does not use Timestamp object, as the goal of these
 *   functions is accurate delays (vs accurate timestamps.)
 * o The syscalls such as nanosleep guarantee at least the request time
 *   and can and will delay longer, particularly due to things like context
 *   switching, causing the delay to lose accuracy
 * o Kalman filtering is used to predict delay error which in turn
 *   is used to adjust the delay, hopefully mitigating the above.
 *   Note:  This can cause the delay to return faster than the request,
 *   i.e. the *at least* guarantee is not preserved for the kalman
 *   adjusted delay calls.
 * o Remember, the Client is keeping a running average delay for the
 *   thread so errors in delay will also be adjusted there. (Assuming
 *   it's possible.  It's not really possible at top line link rates
 *   because lost time can't be made up for by speeding up the transmits.
 *   Hence, don't lose time with delay calls which error on the side of
 *   taking too long.  Kalman should help much here.)
 *
 * POSIX nanosleep(). This allows a higher timing resolution
 * (under Linux e.g. it uses hrtimers), does not affect any signals,
 * and will use up remaining time when interrupted.
 * ------------------------------------------------------------------- */

void delay_loop(unsigned long usec)
{
#ifdef HAVE_CLOCK_NANOSLEEP
  {
    struct timespec res;
    res.tv_sec = usec/MILLION;
    res.tv_nsec = (usec * 1000) % BILLION;
  #ifndef WIN32
    clock_nanosleep(CLOCK_MONOTONIC, 0, &res, NULL);
  #else
    clock_nanosleep(0, 0, &res, NULL);
  #endif
  }
#else
  #ifdef HAVE_KALMAN
    delay_kalman(usec);
  #else
  #ifdef HAVE_NANOSLEEP
    delay_nanosleep(usec);
  #else
    delay_busyloop(usec);
  #endif
  #endif
#endif
}

int clock_usleep (struct timeval *request) {
    int rc = 0;
#if HAVE_THREAD_DEBUG
    thread_debug("Thread called clock_usleep() until %ld.%ld", request->tv_sec, request->tv_usec);
#endif
#ifdef HAVE_CLOCK_NANOSLEEP
    struct timespec tmp;
    tmp.tv_sec = request->tv_sec;
    tmp.tv_nsec = request->tv_usec * 1000;

// Cygwin systems have an issue with CLOCK_MONOTONIC
#if defined(CLOCK_MONOTONIC) && !defined(WIN32)
    rc = clock_nanosleep(CLOCK_MONOTONIC, 0, &tmp, NULL);
#else
    rc = clock_nanosleep(0, 0, &tmp, NULL);
#endif
    if (rc) {
	fprintf(stderr, "failed clock_nanosleep()=%d\n", rc);
    }
#else
    struct timeval now;
    struct timeval next = *request;
#ifdef HAVE_CLOCK_GETTIME
    struct timespec t1;
    clock_gettime(CLOCK_REALTIME, &t1);
    now.tv_sec  = t1.tv_sec;
    now.tv_usec = t1.tv_nsec / 1000;
#else
    gettimeofday(&now, NULL);
#endif
    double delta_usecs;
    if ((delta_usecs = TimeDifference(next, now)) > 0.0) {
	delay_loop(delta_usecs);
    }
#endif
    return rc;
}

int clock_usleep_abstime (struct timeval *request) {
    int rc = 0;
#if defined(HAVE_CLOCK_NANOSLEEP) && defined(TIMER_ABSTIME) && !defined(WIN32)
    struct timespec tmp;
    tmp.tv_sec = request->tv_sec;
    tmp.tv_nsec = request->tv_usec * 1000;
    rc = clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &tmp, NULL);
    if (rc) {
	fprintf(stderr, "failed clock_nanosleep()=%d\n", rc);
    }
#else
    struct timeval now;
    struct timeval next = *request;
#ifdef HAVE_CLOCK_GETTIME
    struct timespec t1;
    clock_gettime(CLOCK_REALTIME, &t1);
    now.tv_sec  = t1.tv_sec;
    now.tv_usec = t1.tv_nsec / 1000;
#else
    gettimeofday(&now, NULL);
#endif
    double delta_usecs;
    if ((delta_usecs = (1e6 * TimeDifference(next, now))) > 0.0) {
	delay_loop(delta_usecs);
    }
#endif
    return rc;
}

#ifdef HAVE_NANOSLEEP
// Can use the nanosleep syscall suspending the thread
void delay_nanosleep (unsigned long usec) {
    struct timespec requested, remaining;
    requested.tv_sec  = 0;
    requested.tv_nsec = usec * 1000L;
    // Note, signals will cause the nanosleep
    // to return early.  That's fine.
    nanosleep(&requested, &remaining);
}
#endif

#if defined (HAVE_NANOSLEEP) || defined (HAVE_CLOCK_GETTIME)
static void timespec_add_ulong (struct timespec *tv0, unsigned long value) {
    tv0->tv_sec += (value / BILLION);
    tv0->tv_nsec += (value % BILLION);
    if (tv0->tv_nsec >= BILLION) {
	tv0->tv_sec++;
	tv0->tv_nsec -= BILLION;
    }
}
#endif

#ifdef HAVE_KALMAN
// Kalman versions attempt to support delay request
// accuracy over a minimum guaranteed delay by
// prediciting the delay error. This is
// the basic recursive algorithm.
static void kalman_update (struct kalman_state *state, double measurement) {
    //prediction update
    state->p = state->p + state->q;
    //measurement update
    state->k = state->p / (state->p + state->r);
    state->x = state->x + (state->k * (measurement - state->x));
    state->p = (1 - state->k) * state->p;
}
#endif

#ifdef HAVE_CLOCK_GETTIME
// Delay calls for systems with clock_gettime
// Working units are nanoseconds and structures are timespec
static void timespec_add_double (struct timespec *tv0, double value) {
    tv0->tv_nsec += (unsigned long) value;
    if (tv0->tv_nsec >= BILLION) {
	tv0->tv_sec++;
	tv0->tv_nsec -= BILLION;
    }
}
// tv1 assumed greater than tv0
static double timespec_diff (struct timespec tv1, struct timespec tv0) {
    double result;
    if (tv1.tv_nsec < tv0.tv_nsec) {
	tv1.tv_nsec += BILLION;
	tv1.tv_sec--;
    }
    result = (double) (((tv1.tv_sec - tv0.tv_sec) * BILLION) + (tv1.tv_nsec - tv0.tv_nsec));
    return result;
}
static void timespec_add( struct timespec *tv0, struct timespec *tv1)
{
    tv0->tv_sec += tv1->tv_sec;
    tv0->tv_nsec += tv1->tv_nsec;
    if ( tv0->tv_nsec >= BILLION ) {
	tv0->tv_nsec -= BILLION;
	tv0->tv_sec++;
    }
}
static inline
int timespec_greaterthan(struct timespec tv1, struct timespec tv0) {
    if (tv1.tv_sec > tv0.tv_sec ||					\
	((tv0.tv_sec == tv1.tv_sec) && (tv1.tv_nsec > tv0.tv_nsec))) {
	return 1;
    } else {
	return 0;
    }
}
// A cpu busy loop for systems with clock_gettime
void delay_busyloop (unsigned long usec) {
    struct timespec t1, t2;
    clock_gettime(CLOCK_REALTIME, &t1);
    timespec_add_ulong(&t1, (usec * 1000L));
    while (1) {
	clock_gettime(CLOCK_REALTIME, &t2);
	if (timespec_greaterthan(t2, t1))
	    break;
    }
}
// Kalman routines for systems with clock_gettime
#ifdef HAVE_KALMAN
// Request units is microseconds
// Adjust units is nanoseconds
void delay_kalman (unsigned long usec) {
    struct timespec t1, t2, finishtime, requested={0,0}, remaining;
    double nsec_adjusted, err;
    static struct kalman_state kalmanerr={
	0.00001, //q process noise covariance
	0.1, //r measurement noise covariance
	0.0, //x value, error predictio (units nanoseconds)
	1, //p estimation error covariance
	0.75 //k kalman gain
    };
    // Get the current clock
    clock_gettime(CLOCK_REALTIME, &t1);
    // Perform the kalman adjust per the predicted delay error
    nsec_adjusted = (usec * 1000.0) - kalmanerr.x;
    // Set a timespec to be used by the nanosleep
    // as well as for the finished time calculation
    timespec_add_double(&requested, nsec_adjusted);
    // Set the finish time in timespec format
    finishtime = t1;
    timespec_add(&finishtime, &requested);
#  ifdef HAVE_NANOSLEEP
    // Don't call nanosleep for values less than 10 microseconds
    // as the syscall is too expensive.  Let the busy loop
    // provide the delay for times under that.
    if (nsec_adjusted > 10000) {
	nanosleep(&requested, &remaining);
    }
#  endif
    while (1) {
	clock_gettime(CLOCK_REALTIME, &t2);
	if (timespec_greaterthan(t2, finishtime))
	    break;
    }
    // Compute the delay error in units of nanoseconds
    // and cast to type double
    err = (timespec_diff(t2, t1) - (usec * 1000));
    // printf("req: %ld adj: %f err: %.5f (ns)\n", usec, nsec_adjusted, kalmanerr.x);
    kalman_update(&kalmanerr, err);
}
#endif // HAVE_KALMAN
#else
// Sadly, these systems must use the not so efficient gettimeofday()
// and working units are microseconds, struct is timeval
static void timeval_add_ulong (struct timeval *tv0, unsigned long value) {
    tv0->tv_usec += value;
    if (tv0->tv_usec >= MILLION) {
	tv0->tv_sec++;
	tv0->tv_usec -= MILLION;
    }
}
static inline
int timeval_greaterthan(struct timeval tv1, struct timeval tv0) {
    if (tv1.tv_sec > tv0.tv_sec ||					\
	((tv0.tv_sec == tv1.tv_sec) && (tv1.tv_usec > tv0.tv_usec))) {
	return 1;
    } else {
	return 0;
    }
}
// tv1 assumed greater than tv0
static double timeval_diff (struct timeval tv1, struct timeval tv0) {
    double result;
    if (tv1.tv_usec < tv0.tv_usec) {
	tv1.tv_usec += MILLION;
	tv1.tv_sec--;
    }
    result = (double) (((tv1.tv_sec - tv0.tv_sec) * MILLION) + (tv1.tv_usec - tv0.tv_usec));
    return result;
}
void delay_busyloop (unsigned long usec) {
    struct timeval t1, t2;
    gettimeofday( &t1, NULL );
    timeval_add_ulong(&t1, usec);
    while (1) {
	gettimeofday( &t2, NULL );
	if (timeval_greaterthan(t2, t1))
	    break;
    }
}
#ifdef HAVE_KALMAN
// Request units is microseconds
// Adjust units is microseconds
void delay_kalman (unsigned long usec) {
    struct timeval t1, t2, finishtime;
    long usec_adjusted;
    double err;
    static struct kalman_state kalmanerr={
	0.00001, //q process noise covariance
	0.1, //r measurement noise covariance
	0.0, //x value, error predictio (units nanoseconds)
	1, //p estimation error covariance
	0.25 //k kalman gain
    };
    // Get the current clock
    gettimeofday( &t1, NULL );
    // Perform the kalman adjust per the predicted delay error
    if (kalmanerr.x > 0) {
	usec_adjusted = usec - (long) floor(kalmanerr.x);
	if (usec_adjusted < 0)
	    usec_adjusted = 0;
    }
    else
	usec_adjusted = usec + (long) floor(kalmanerr.x);
    // Set the finishtime
    finishtime = t1;
    timeval_add_ulong(&finishtime, usec_adjusted);
#  ifdef HAVE_NANOSLEEP
    // Don't call nanosleep for values less than 10 microseconds
    // as the syscall is too expensive.  Let the busy loop
    // provide the delay for times under that.
    if (usec_adjusted > 10) {
	struct timespec requested={0,0}, remaining;
	timespec_add_ulong(&requested, (usec_adjusted * 1000));
	nanosleep(&requested, &remaining);
    }
#  endif
    while (1) {
	gettimeofday(&t2, NULL );
	if (timeval_greaterthan(t2, finishtime))
	    break;
    }
    // Compute the delay error in units of microseconds
    // and cast to type double
    err = (double)(timeval_diff(t2, t1)  - usec);
    // printf("req: %ld adj: %ld err: %.5f (us)\n", usec, usec_adjusted, kalmanerr.x);
    kalman_update(&kalmanerr, err);
}
#endif // Kalman
#endif
