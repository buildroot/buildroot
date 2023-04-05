
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
 * Thread.c
 * by Kevin Gibbs <kgibbs@nlanr.net>
 *
 * Based on:
 * Thread.cpp
 * by Mark Gates <mgates@nlanr.net>
 * -------------------------------------------------------------------
 * The thread subsystem is responsible for all thread functions. It
 * provides a thread implementation agnostic interface to Iperf. If
 * threads are not available (HAVE_THREAD is undefined), thread_start
 * does not start a new thread but just launches the specified object
 * in the current thread. Everything that defines a thread of
 * execution in Iperf is contained in an thread_Settings structure. To
 * start a thread simply pass one such structure into thread_start.
 * -------------------------------------------------------------------
 * headers
 * uses
 *   <stdlib.h>
 *   <stdio.h>
 *   <assert.h>
 *   <errno.h>
 * Thread.h may include <pthread.h>
 * ------------------------------------------------------------------- */

#include "headers.h"

#include "Thread.h"
#include "Locale.h"
#include "util.h"

#ifdef __cplusplus
extern "C" {
#endif

#if HAVE_THREAD_DEBUG
#include <time.h>
#include <unistd.h>
#if HAVE_GETTID_SYSCALL
#include <sys/syscall.h>
#endif
#include <sys/types.h>
#include <stdarg.h>
#include "Reporter.h"
void reporttype_text(struct ReportHeader *reporthdr, char *rs) {
    switch (reporthdr->type) {
    case DATA_REPORT:
	strncpy(rs,"data", REPORTTXTMAX);
	break;
    case SUM_REPORT:
	strncpy(rs,"sum", REPORTTXTMAX);
	break;
    case SETTINGS_REPORT:
	strncpy(rs,"settings", REPORTTXTMAX);
	break;
    case CONNECTION_REPORT:
	strncpy(rs,"connection", REPORTTXTMAX);
	break;
    case SERVER_RELAY_REPORT:
	strncpy(rs,"server", REPORTTXTMAX);
	break;
    default :
	strncpy(rs,"unknown", REPORTTXTMAX);
    }
    rs[REPORTTXTMAX-1] = '\0';
}

Mutex thread_debug_mutex;
static void __gettimestamp(char *timestr) {
    struct timespec t1;
    clock_gettime(CLOCK_REALTIME, &t1);
    struct tm *t;
    t=localtime(&t1.tv_sec);
    if (t) {
#if WIN32
	strftime(timestr, 200, "%Y-%m-%d %H:%M:%S", t);
#else
        strftime(timestr, 200, "%T", t);
#endif
        // strftime(buf, len, "%F %T", &t);
	snprintf(&timestr[strlen(timestr)], strlen(timestr), ".%09ld", t1.tv_nsec);
        timestr[199]='\0';
    } else {
        *timestr='\0';
    }
}
static int __log(const char *level, const char *format, va_list args) {
    int len;
    char *newformat;
    char timestamp[200];
    char logformat[]="%s(%ld):[%s] %s\n";

    __gettimestamp(timestamp);
  #if HAVE_GETTID_SYSCALL
    unsigned long tid = syscall(SYS_gettid);
  #else
    unsigned long tid = -1;
  #endif
    len = snprintf(NULL, 0, logformat, level, tid, timestamp, format);
    len++;  // Trailing null byte + extra
    newformat = malloc(len);
    len = snprintf(newformat, len, logformat, level, tid, timestamp, format);
    if (len > 0) {
      len = vprintf(newformat, args);
    }
    free(newformat);
    return len;
}

void thread_debug(const char *format, ...) {
    Mutex_Lock(&thread_debug_mutex);
    va_list ap;
    va_start(ap, format);
    __log("THREAD", format, ap);
    va_end(ap);
    fflush(stdout);
    Mutex_Unlock(&thread_debug_mutex);
}
#endif

/* -------------------------------------------------------------------
 * define static variables.
 * ------------------------------------------------------------------- */

// number of currently running threads
int thread_sNum = 0;
// number of currently running traffic threads
int thread_trfc_sNum = 0;
int thread_trfctx_sNum = 0;
int thread_trfcrx_sNum = 0;
// number of non-terminating running threads (ie listener thread)
int nonterminating_num = 0;
// condition to protect updating the above and alerting on
// changes to above
struct Condition thread_sNum_cond;


/* -------------------------------------------------------------------
 * Initialize the thread subsystems variables and set the concurrency
 * level in solaris.
 * ------------------------------------------------------------------- */
void thread_init() {
    Condition_Initialize(&thread_sNum_cond);
#if defined(sun)
    /* Solaris apparently doesn't default to timeslicing threads,
     * as such we force it to play nice. This may not work perfectly
     * when _sending_ multiple _UDP_ streams.
     */
    pthread_setconcurrency (3);
#endif
}

/* -------------------------------------------------------------------
 * Destroy the thread subsystems variables.
 * ------------------------------------------------------------------- */
void thread_destroy() {
    Condition_Destroy(&thread_sNum_cond);
}

/* -------------------------------------------------------------------
 * Start the specified object's thread execution. Increments thread
 * count, spawns new thread, and stores thread ID.
 * ------------------------------------------------------------------- */
void thread_start_all(struct thread_Settings* thread) {
    struct thread_Settings *ithread = thread;
    while(ithread) {
	thread_start(ithread);
	ithread = ithread->runNow;
    }
}

void thread_start(struct thread_Settings* thread) {
    // Make sure this object has not been started already
    if (!thread_equalid(thread->mTID, thread_zeroid())) {
	WARN(1, "thread_start called on running thread");
#if HAVE_THREAD_DEBUG
	thread_debug("Thread_start info %p id=%d ", (void *)thread, (int)thread->mTID);
#endif
    } else {
        // increment thread count
        Condition_Lock(thread_sNum_cond);
        thread_sNum++;
	if ((thread->mThreadMode == kMode_Client) || (thread->mThreadMode == kMode_Server)) {
	    thread_trfc_sNum++;
	}
        Condition_Unlock(thread_sNum_cond);

#if defined(HAVE_POSIX_THREAD)
        // pthreads -- spawn new thread
        if (pthread_create(&thread->mTID, NULL, thread_run_wrapper, thread) != 0) {
            WARN(1, "pthread_create");

            // decrement thread count
            Condition_Lock(thread_sNum_cond);
            thread_sNum--;
	    if (thread->mThreadMode == kMode_Client) {
	        thread_trfc_sNum--;
	        thread_trfctx_sNum--;
	    }
	    if (thread->mThreadMode == kMode_Server) {
	        thread_trfc_sNum--;
	        thread_trfcrx_sNum--;
	    }
            Condition_Unlock(thread_sNum_cond);
        }
#if HAVE_THREAD_DEBUG
	thread_debug("Thread_run_wrapper(%p mode=%x) thread counts tot/trfc=%d/%d (id=%d)", (void *)thread, thread->mThreadMode, thread_sNum, thread_trfc_sNum, (int)thread->mTID);
#endif
#elif defined(HAVE_WIN32_THREAD)
        // Win32 threads -- spawn new thread
        // Win32 has a thread handle in addition to the thread ID
        thread->mHandle = CreateThread(NULL, 0, thread_run_wrapper, thread, 0, &thread->mTID);
        if (thread->mHandle == NULL) {
            WARN(1, "CreateThread");

            // decrement thread count
            Condition_Lock(thread_sNum_cond);
            thread_sNum--;
	    if ((thread->mThreadMode == kMode_Client) || (thread->mThreadMode == kMode_Server)) {
		thread_trfc_sNum--;
	    }
            Condition_Unlock(thread_sNum_cond);
        }
#else
        // single-threaded -- call Run_Wrapper in this thread
        thread_run_wrapper(thread);
#endif
    }
} // end thread_start

/* -------------------------------------------------------------------
 * Stop the specified object's thread execution (if any) immediately.
 * Decrements thread count and resets the thread ID.
 *
 * Note: This does not free any objects and calling it without
 * lots of conideration will likely cause memory leaks. Better to let
 * thread_start's thread_run_wrapper run to completion and not
 * preemptively stop a thread.
 * ------------------------------------------------------------------- */
void thread_stop(struct thread_Settings* thread) {
#ifdef HAVE_THREAD
  #ifdef HAVE_THREAD_DEBUG
  thread_debug("Thread stop invoked %p (%d/%d)", (void *)thread, thread_sNum, thread_trfc_sNum);
  #endif
    // Make sure we have been started
    if (!thread_equalid(thread->mTID, thread_zeroid())) {

        // decrement thread count
        Condition_Lock(thread_sNum_cond);
        thread_sNum--;
	if ((thread->mThreadMode == kMode_Client) || (thread->mThreadMode == kMode_Server)) {
	    thread_trfc_sNum--;
	}
        Condition_Signal(&thread_sNum_cond);
        Condition_Unlock(thread_sNum_cond);

        // use exit()   if called from within this thread
        // use cancel() if called from a different thread
        if (thread_equalid(thread_getid(), thread->mTID)) {

            // Destroy the object
            Settings_Destroy(thread);

            // Exit
#if   defined(HAVE_POSIX_THREAD)
            pthread_exit(NULL);
#else // Win32
            CloseHandle(thread->mHandle);
            ExitThread(0);
#endif
        } else {

            // Cancel
#if   defined(HAVE_POSIX_THREAD)
            // Cray J90 doesn't have pthread_cancel; Iperf works okay without
#ifdef HAVE_PTHREAD_CANCEL
            pthread_cancel(thread->mTID);
#endif
#else // Win32
            // this is a somewhat dangerous function; it's not
            // suggested to Stop() threads a lot.
            TerminateThread(thread->mHandle, 0);
#endif

            // Destroy the object only after killing the thread
            Settings_Destroy(thread);
        }
    }
#endif
} // end Stop

/* -------------------------------------------------------------------
 * This function is the entry point for new threads created in
 * thread_start.
 * ------------------------------------------------------------------- */
#if   defined(HAVE_WIN32_THREAD)
DWORD WINAPI
#else
void*
#endif
thread_run_wrapper(void* paramPtr) {
    bool signal_on_exit = false;
    struct thread_Settings* thread = (struct thread_Settings*) paramPtr;

    // which type of object are we
    switch (thread->mThreadMode) {
        case kMode_Server:
            {
		signal_on_exit = true;
                /* Spawn a Server thread with these settings */
                server_spawn(thread);
            } break;
        case kMode_Client:
            {
		signal_on_exit = true;
                /* Spawn a Client thread with these settings */
                client_spawn(thread);
            } break;
        case kMode_Reporter:
        case kMode_ReporterClient:
            {
                /* Spawn a Reporter thread with these settings */
                reporter_spawn(thread);
            } break;
        case kMode_Listener:
            {
                // Increment the non-terminating thread count
                thread_register_nonterm();
                /* Spawn a Listener thread with these settings */
                listener_spawn(thread);
                // Decrement the non-terminating thread count
                thread_unregister_nonterm();
            } break;
        default:
            {
                FAIL(1, "Unknown Thread Type!\n", thread);
            } break;
    }

#ifdef HAVE_POSIX_THREAD
    // detach Thread. If someone already joined it will not do anything
    // If none has then it will free resources upon return from this
    // function (Run_Wrapper)
    pthread_detach(thread->mTID);
#endif

    // decrement thread count and send condition signal
    Condition_Lock(thread_sNum_cond);
    thread_sNum--;
    if ((thread->mThreadMode == kMode_Client) || (thread->mThreadMode == kMode_Server)) {
       thread_trfc_sNum--;
    }
    Condition_Signal(&thread_sNum_cond);
    Condition_Unlock(thread_sNum_cond);

    // Check if we need to start up a thread after executing this one
    if (thread->runNext != NULL) {
        thread_start(thread->runNext);
    }
    // Destroy this thread object
    Settings_Destroy(thread);
    // signal the reporter thread now that thread state has changed
    if (signal_on_exit) {
	Condition_Signal(&ReportCond);
#if HAVE_THREAD_DEBUG
	thread_debug("Signal sent to reporter thread");
#endif
    }
    return 0;
} // end run_wrapper

/* -------------------------------------------------------------------
 * Wait for all thread object's execution to complete. Depends on the
 * thread count being accurate and the threads sending a condition
 * signal when they terminate.
 * ------------------------------------------------------------------- */
void thread_joinall(void) {
    Condition_Lock(thread_sNum_cond);
    while (thread_sNum > 0) {
        Condition_Wait(&thread_sNum_cond);
    }
    Condition_Unlock(thread_sNum_cond);
} // end Joinall


/* -------------------------------------------------------------------
 * Compare the thread ID's (inLeft == inRight); return true if they
 * are equal. On some OS's nthread_t is a struct so == will not work.
 * TODO use pthread_equal. Any Win32 equivalent??
 * ------------------------------------------------------------------- */
int thread_equalid(nthread_t inLeft, nthread_t inRight) {
    return(memcmp(&inLeft, &inRight, sizeof(inLeft)) == 0);
}

/* -------------------------------------------------------------------
 * Return a zero'd out thread ID. On some OS's nthread_t is a struct
 * so == 0 will not work.
 * [static]
 * ------------------------------------------------------------------- */
nthread_t thread_zeroid(void) {
    nthread_t a;
    memset(&a, 0, sizeof(a));
    return a;
}

/* -------------------------------------------------------------------
 * set a thread to be ignorable, so joinall won't wait on it
 * this simply decrements the thread count that joinall uses.
 * This is utilized by the reporter thread which knows when it
 * is ok to quit (aka no pending reports).
 * ------------------------------------------------------------------- */
void thread_setignore() {
    Condition_Lock(thread_sNum_cond);
    thread_sNum--;
    Condition_Signal(&thread_sNum_cond);
    Condition_Unlock(thread_sNum_cond);
}

/* -------------------------------------------------------------------
 * unset a thread from being ignorable, so joinall will wait on it
 * this simply increments the thread count that joinall uses.
 * This is utilized by the reporter thread which knows when it
 * is ok to quit (aka no pending reports).
 * ------------------------------------------------------------------- */
void thread_unsetignore(void) {
    Condition_Lock(thread_sNum_cond);
    thread_sNum++;
    Condition_Signal(&thread_sNum_cond);
    Condition_Unlock(thread_sNum_cond);
}

/* -------------------------------------------------------------------
 * set a thread to be non-terminating, so if you cancel through
 * Ctrl-C they can be ignored by the joinall.
 * ------------------------------------------------------------------- */
void thread_register_nonterm(void) {
    Condition_Lock(thread_sNum_cond);
    nonterminating_num++;
    Condition_Unlock(thread_sNum_cond);
}

/* -------------------------------------------------------------------
 * unset a thread from being non-terminating, so if you cancel through
 * Ctrl-C they can be ignored by the joinall.
 * ------------------------------------------------------------------- */
void thread_unregister_nonterm(void) {
    Condition_Lock(thread_sNum_cond);
    if (nonterminating_num == 0) {
        // nonterminating has been released with release_nonterm
        // Add back to the threads to wait on
        thread_sNum++;
    } else {
        nonterminating_num--;
    }
    Condition_Unlock(thread_sNum_cond);
}

/* -------------------------------------------------------------------
 * this function releases all non-terminating threads from the list
 * of active threads, so that when all terminating threads quit
 * the joinall will complete. This is called on a Ctrl-C input. It is
 * also used by the -P usage on the server side
 * ------------------------------------------------------------------- */
int thread_release_nonterm(int interrupt) {
    Condition_Lock(thread_sNum_cond);
    thread_sNum -= nonterminating_num;
    if (thread_sNum > 1 && nonterminating_num > 0 && interrupt != 0) {
        fprintf(stderr, "%s", wait_server_threads);
    }
    nonterminating_num = 0;
    Condition_Signal(&thread_sNum_cond);
    Condition_Unlock(thread_sNum_cond);
    return thread_sNum;
}

/* -------------------------------------------------------------------
 * Return the number of threads currently running (doesn't include
 * active threads that have called setdaemon (aka reporter thread))
 * ------------------------------------------------------------------- */
int thread_numuserthreads(void) {
    return thread_sNum;
}

/* -------------------------------------------------------------------
 * Return the number of taffic threads currently running
 * ------------------------------------------------------------------- */
int thread_numtrafficthreads(void) {
    return thread_trfc_sNum;
}

/* -------------------------------------------------------------------
 * Support for realtime scheduling of threads
 * ------------------------------------------------------------------- */
#if HAVE_SCHED_SETSCHEDULER
#include <sched.h>
#endif
#ifdef HAVE_MLOCKALL
#include <sys/mman.h>
#endif
void thread_setscheduler(struct thread_Settings *thread) {
#if HAVE_SCHED_SETSCHEDULER
    if (isRealtime(thread)) {
	struct sched_param sp;
	sp.sched_priority = sched_get_priority_max(SCHED_RR);
	// SCHED_OTHER, SCHED_FIFO, SCHED_RR
	if (sched_setscheduler(0, SCHED_RR, &sp) < 0)  {
	    perror("Client set scheduler");
#ifdef HAVE_MLOCKALL
	} else if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0) {
	    // lock the threads memory
	    perror ("mlockall");
#endif // MLOCK
	}
    }
#endif // SCHED
}

/*
 * -------------------------------------------------------------------
 * Allow another thread to execute. If no other threads are runable this
 * is not guarenteed to actually rest.
 * ------------------------------------------------------------------- */
void thread_rest (void) {
#if defined(HAVE_THREAD)
#if defined(HAVE_POSIX_THREAD)
  #if HAVE_SCHED_YIELD
     sched_yield();
  #endif
#else // Win32
    SwitchToThread();
#endif
#endif
}

#ifdef __cplusplus
} /* end extern "C" */
#endif
