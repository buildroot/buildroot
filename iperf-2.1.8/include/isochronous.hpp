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
 * isochronous.hpp
 * Suppport for isochonronous traffic testing
 *
 * by Robert J. McMahon (rjmcmahon@rjmcmahon.com, bob.mcmahon@broadcom.com)
 * -------------------------------------------------------------------
 */
#ifndef ISOCHRONOUS_H
#define ISOCHRONOUS_H

#include <time.h>
#include "Settings.hpp"
#include "Timestamp.hpp"

/* ------------------------------------------------------------------- */
namespace Isochronous {
    class FrameCounter {
    public :
        FrameCounter(double, const Timestamp& start);
        FrameCounter(double);
        ~FrameCounter();
	unsigned int get(void) const;
	unsigned int get(long *);
	unsigned int get(const Timestamp&) const;
	unsigned int period_us(void);
	unsigned int wait_tick(void);
	unsigned int wait_sync(long sec, long usec);
	long getSecs(void);
	long getUsecs(void);
	void reset(void);
        Timestamp next_slot(void);
	unsigned int slip;
    private :
	double frequency;
	Timestamp startTime;
	Timestamp nextslotTime;
	unsigned int period;  // units microseconds or 100 ns
	unsigned int lastcounter;
	unsigned int slot_counter;
#ifdef WIN32
	int mySetWaitableTimer (long delay_time);
	HANDLE my_timer;	// Timer handle
	LARGE_INTEGER delay;    // units is 100 nanoseconds
#endif

    }; // end class FrameCounter
}
#endif // ISOCHRONOUS_H
