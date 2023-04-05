/*---------------------------------------------------------------
 * Copyright (c) 2017-2021
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
 * isochronous.c
 * Suppport for isochonronous traffic testing
 *
 * by Robert J. McMahon (rjmcmahon@rjmcmahon.com, bob.mcmahon@broadcom.com)
 * -------------------------------------------------------------------
 */
#include "headers.h"
#include "Timestamp.hpp"
#include "isochronous.hpp"
#include "delay.h"

#define BILLION 1000000000

using namespace Isochronous;

FrameCounter::FrameCounter (double value, const Timestamp& start) : frequency(value) {
    period = static_cast<unsigned int>(1000000 / frequency);
    startTime = start;
    nextslotTime=start;
    lastcounter = 0;
    slot_counter = 0;
    slip = 0;
}
FrameCounter::FrameCounter (double value) : frequency(value) {
#ifdef WIN32
    /* Create timer */
    my_timer = CreateWaitableTimer(NULL, TRUE, NULL);
    if (!SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_TIME_CRITICAL))
	WARN_errno(1, "SetThreadPriority");
#endif
    period = static_cast<unsigned int>(1000000 / frequency); // unit us
    lastcounter = 0;
    slot_counter = 0;
    slip = 0;
}


FrameCounter::~FrameCounter () {
#ifdef WIN32
    /* Clean resources */
    if (my_timer)
	CloseHandle(my_timer);
#endif
}

#ifdef WIN32
/* Windows sleep in 100ns units returns 0 on success as does clock_nanosleep*/
int FrameCounter::mySetWaitableTimer (long delay_time) {
    int rc = -1;
    if (!my_timer) {
	if ((my_timer = CreateWaitableTimer(NULL, TRUE, NULL))) {
	    /* Set timer properties */
	    delay.QuadPart = -delay_time;
	} else {
	    WARN_errno(1, "CreateWaitable");
	    my_timer = NULL;
	}
    }
    if (my_timer) {
	/* Set timer properties */
	/* negative values are relative, positive absolute UTC time */
	delay.QuadPart = -delay_time;
	if(!SetWaitableTimer(my_timer, &delay, 0, NULL, NULL, FALSE)) {
	    WARN_errno(1, "SetWaitableTimer");
	    CloseHandle(my_timer);
	    my_timer = NULL;
	} else {
	    // Wait for timer
	    if (WaitForSingleObject(my_timer, INFINITE)) {
		WARN_errno(1, "WaitForSingleObject");
	    } else {
		rc = 0;
	    }
	}
    }
    return rc;
}
#endif

#if defined(HAVE_CLOCK_NANOSLEEP)
unsigned int FrameCounter::wait_tick () {
    Timestamp now;
    int rc = true;
    if (!slot_counter) {
	slot_counter = 1;
	now.setnow();
	nextslotTime = now;
    } else {
	while (!now.before(nextslotTime)) {
	    now.setnow();
	    nextslotTime.add(period);
	    slot_counter++;
	}
	if (lastcounter && ((slot_counter - lastcounter) > 1)) {
	    slip++;
	}
    }
  #ifndef WIN32
    timespec txtime_ts;
    txtime_ts.tv_sec = nextslotTime.getSecs();
    txtime_ts.tv_nsec = nextslotTime.getUsecs() * 1000;
    rc = clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &txtime_ts, NULL);
  #else
    long duration = nextslotTime.subUsec(now);
    rc = mySetWaitableTimer(10 * duration); // convert us to 100ns
    //int rc = clock_nanosleep(0, TIMER_ABSTIME, &txtime_ts, NULL);
  #endif
    WARN_errno((rc!=0), "wait_tick failed");
  #ifdef HAVE_THREAD_DEBUG
    // thread_debug("Client tick occurred per %ld.%ld", txtime_ts.tv_sec, txtime_ts.tv_nsec / 1000);
  #endif
    lastcounter = slot_counter;
    return(slot_counter);
}
#else
unsigned int FrameCounter::wait_tick (void) {
    long remaining;
    unsigned int framecounter;

    if (!lastcounter) {
	reset();
	framecounter = 1;
    } else {
	framecounter = get(&remaining);
	if ((framecounter - lastcounter) > 1)
	    slip++;
//    	delay_loop(remaining);
	remaining *= 1000;
	struct timespec tv0={0,0}, tv1;
	tv0.tv_sec = (remaining / BILLION);
	tv0.tv_nsec += (remaining % BILLION);
	if (tv0.tv_nsec >= BILLION) {
	    tv0.tv_sec++;
	    tv0.tv_nsec -= BILLION;
	}
	int rc = nanosleep(&tv0, &tv1);
	WARN_errno((rc != 0), "nanosleep wait_tick");	    ;
//	printf("****** rc = %d, remain %ld.%ld\n", rc, tv1.tv_sec, tv1.tv_nsec);
	framecounter ++;
    }
    lastcounter = framecounter;
    return(framecounter);
}
#endif
inline unsigned int FrameCounter::get () const {
    Timestamp now;
    return slot_counter + 1;
}

inline unsigned int FrameCounter::get (const Timestamp& slot) const {
    return(slot_counter + 1); // Frame counter for packets starts at 1
}

inline unsigned int FrameCounter::get (long *ticks_remaining) {
    assert(ticks_remaining != NULL);
    Timestamp sampleTime;  // Constructor will initialize timestamp to now
    long usecs = -startTime.subUsec(sampleTime);
    unsigned int counter = static_cast<unsigned int>(usecs / period) + 1;
    // figure out how many usecs before the next frame counter tick
    // the caller can use this to delay until the next tick
    *ticks_remaining = (counter * period) - usecs;
    return(counter + 1); // Frame counter for packets starts at 1
}

inline Timestamp FrameCounter::next_slot () {
    Timestamp next = startTime;
    slot_counter = get();
    // period unit is in microseconds, convert to seconds
    next.add(slot_counter * (period / 1e6));
    return next;
}

unsigned int FrameCounter::period_us () {
    return(period);
}

void FrameCounter::reset () {
    period = (1000000 / frequency);
    startTime.setnow();
}

unsigned int FrameCounter::wait_sync (long sec, long usec) {
    long remaining;
    unsigned int framecounter;
    startTime.set(sec, usec);
    framecounter = get(&remaining);
    delay_loop(remaining);
    reset();
    framecounter = 1;
    lastcounter = 1;
    return(framecounter);
}

long FrameCounter::getSecs () {
    return startTime.getSecs();
}

long FrameCounter::getUsecs () {
    return startTime.getUsecs();
}
