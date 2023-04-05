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
 * Launch.cpp
 * by Kevin Gibbs <kgibbs@nlanr.net>
 * -------------------------------------------------------------------
 * Functions to launch new server and client threads from C while
 * the server and client are in C++.
 * The launch function for reporters is in Reporter.c since it is
 * in C and does not need a special launching function.
 * ------------------------------------------------------------------- */

#include "headers.h"
#include "Thread.h"
#include "Settings.hpp"
#include "Client.hpp"
#include "Listener.hpp"
#include "Server.hpp"
#include "PerfSocket.hpp"
#include "active_hosts.h"
#include "SocketAddr.h"
#include "delay.h"

static int fullduplex_startstop_barrier (struct BarrierMutex *barrier) {
    int rc = 0;
    assert(barrier != NULL);
    Condition_Lock(barrier->await);
    ++barrier->count;
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Fullduplex barrier incr to %d %p ", barrier->count, (void *)&barrier->await, rc);
#endif
    if (barrier->count == 2) {
	rc = 1;
	// last one wake's up everyone else'
#ifdef HAVE_THREAD_DEBUG
	thread_debug("Fullduplex startstop broadcast on condition %p ", (void *)&barrier->await, rc);
#endif
	Condition_Broadcast(&barrier->await);
    } else {
	int timeout = barrier->timeout;
	while ((barrier->count != 2) && (timeout > 0)) {
#ifdef HAVE_THREAD_DEBUG
	    thread_debug("Fullduplex startstop barrier wait  %p %d/2 (%d)", (void *)&barrier->await, barrier->count, timeout);
#endif
	    Condition_TimedWait(&barrier->await, 1);
	    timeout--;
	    if ((timeout == 0) && (barrier->count != 2)) {
		fprintf(stdout, "Barrier timeout per full duplex traffic\n");
		Condition_Unlock(barrier->await);
		return -1;
	    }
	}
	barrier->count=0;
    }
    Condition_Unlock(barrier->await);
    return rc;
}
int fullduplex_start_barrier (struct BarrierMutex *barrier) {
    int rc = fullduplex_startstop_barrier(barrier);
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Fullduplex start barrier done on condition %p rc=%d", (void *)&barrier->await, rc);
#endif
    return rc;
}
int fullduplex_stop_barrier (struct BarrierMutex *barrier) {
    int rc = fullduplex_startstop_barrier(barrier);
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Fullduplex stop barrier done on condition %p rc=%d", (void *)&barrier->await, rc);
#endif
    return rc;
}

/*
 * listener_spawn is responsible for creating a Listener class
 * and launching the listener. It is provided as a means for
 * the C thread subsystem to launch the listener C++ object.
 */
void listener_spawn(struct thread_Settings *thread) {
    Listener *theListener = NULL;
    // the Listener need to trigger a settings report
    setReport(thread);
    // start up a listener
    theListener = new Listener(thread);
    // Start listening
    theListener->Run();
    DELETE_PTR(theListener);
}

/*
 * server_spawn is responsible for creating a Server class
 * and launching the server. It is provided as a means for
 * the C thread subsystem to launch the server C++ object.
 */
void server_spawn(struct thread_Settings *thread) {
    Server *theServer = NULL;
#ifdef HAVE_THREAD_DEBUG
    if (isBounceBack(thread)) {
	thread_debug("spawn server bounce-back");
    } else {
	thread_debug("spawn server settings=%p GroupSumReport=%p sock=%d", \
		     (void *) thread, (void *)thread->mSumReport, thread->mSock);
    }
#endif
    // set traffic thread to realtime if needed
#if HAVE_SCHED_SETSCHEDULER
    thread_setscheduler(thread);
#endif
    // Start up the server
    theServer = new Server(thread);
    if (isTxStartTime(thread)) {
	clock_usleep_abstime(&thread->txstart_epoch);
    }
    // Run the test
    if (isUDP(thread)) {
        theServer->RunUDP();
    } else {
	if (isBounceBack(thread)) {
	    theServer->RunBounceBackTCP();
	} else {
	    theServer->RunTCP();
	}
    }
    DELETE_PTR(theServer);
}

static void clientside_client_basic (struct thread_Settings *thread, Client *theClient) {
    setTransferID(thread, 0);
    SockAddr_remoteAddr(thread);
    theClient->my_connect(true);
#ifdef HAVE_THREAD_DEBUG
    if (isBounceBack(thread)) {
	thread_debug("Launch: spawn client bounce-back mode, size = %d", thread->mBurstSize);
    } else {
	thread_debug("Launch: client spawn thread basic (sock=%d)", thread->mSock);
    }
#endif
    if ((thread->mThreads > 1) && !isNoConnectSync(thread) && !isCompat(thread))
	// When -P > 1 then all threads finish connect before starting traffic
	theClient->BarrierClient(thread->connects_done);
    if (theClient->isConnected()) {
        if ((thread->mThreads > 1) || isSumOnly(thread))
	    Iperf_push_host(thread);
	theClient->StartSynch();
	theClient->Run();
    }
}

static void clientside_client_reverse (struct thread_Settings *thread, Client *theClient) {
    setTransferID(thread, 0);
    SockAddr_remoteAddr(thread);
    theClient->my_connect(true);
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Launch: client spawn thread reverse (sock=%d)", thread->mSock);
#endif
    if ((thread->mThreads > 1) && !isNoConnectSync(thread))
	// When -P > 1 then all threads finish connect before starting traffic
	theClient->BarrierClient(thread->connects_done);
    if (theClient->isConnected()) {
	struct thread_Settings *reverse_client = NULL;
	Settings_Copy(thread, &reverse_client, 0);
	FAIL((!reverse_client || !(thread->mSock > 0)), "Reverse test failed to start per thread settings or socket problem",  thread);
	setTransferID(reverse_client, 1);
	theClient->StartSynch();
	reverse_client->mSock = thread->mSock; // use the same socket for both directions
	reverse_client->mThreadMode = kMode_Server;
	setReverse(reverse_client);
	setNoUDPfin(reverse_client); // disable the fin report - no need
        if ((thread->mThreads > 1) || isSumOnly(thread))
	    Iperf_push_host(reverse_client);
	thread_start(reverse_client);
	if (theClient->myJob)
	    FreeReport(theClient->myJob);
    }
}

static void clientside_client_fullduplex (struct thread_Settings *thread, Client *theClient) {
    struct thread_Settings *reverse_client = NULL;
    setTransferID(thread, 0);
    SockAddr_remoteAddr(thread);
    if (!isBounceBack(thread)) {
        thread->mFullDuplexReport = InitSumReport(thread, -1, 1);
    }
    Settings_Copy(thread, &reverse_client, 0);
    if ((thread->mThreads > 1) || isSumOnly(thread) || \
	(!(thread->mThreads > 1) && !isEnhanced(thread))) {
	Iperf_push_host(thread);
	Iperf_push_host(reverse_client);
    }
    assert(reverse_client != NULL);
    setTransferID(reverse_client, 1);
    theClient->my_connect(true);
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Launch: client spawn thread fullduplex (sock=%d)", thread->mSock);
#endif
    if ((thread->mThreads > 1) && !isNoConnectSync(thread))
	// When -P > 1 then all threads finish connect before starting traffic
	theClient->BarrierClient(thread->connects_done);
    if (theClient->isConnected()) {
	thread->mFullDuplexReport->info.common->socket = thread->mSock;
	FAIL((!reverse_client || !(thread->mSock > 0)), "Reverse test failed to start per thread settings or socket problem",  thread);
	reverse_client->mSumReport = thread->mSumReport;
	reverse_client->mSock = thread->mSock; // use the same socket for both directions
	reverse_client->mThreadMode = kMode_Server;
	setReverse(reverse_client);
	if (isModeTime(reverse_client)) {
	    reverse_client->mAmount += (SLOPSECS * 100);  // add 2 sec for slop on reverse, units are 10 ms
	}
	thread_start(reverse_client);
	if (theClient->StartSynch() != -1) {
	    theClient->Run();
	}
    }
}

static void serverside_client_fullduplex (struct thread_Settings *thread, Client *theClient) {
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Launch: Listener spawn client thread (fd sock=%d)", thread->mSock);
#endif
    setTransferID(thread, 1);
    if (theClient->StartSynch() != -1) {
	theClient->Run();
    }
}

static void serverside_client_bidir (struct thread_Settings *thread, Client *theClient) {
#ifdef HAVE_THREAD_DEBUG
    thread_debug("Launch: Listener spawn client thread (bidir sock=%d)", thread->mSock);
#endif
    setTransferID(thread, 1);
    SockAddr_zeroAddress(&thread->peer);
    SockAddr_remoteAddr(thread);
    unsetNoSettReport(thread);
    setReport(thread);
    theClient->my_connect(false);
    if (theClient->isConnected()) {
	Iperf_push_host(thread);
	if (theClient->StartSynch() != -1) {
	    theClient->Run();
	}
    }
}

/*
 * client_spawn is responsible for creating a Client class
 * and launching the client. It is provided as a means for
 * the C thread subsystem to launch the client C++ object.
 *
 * There are a few different client startup modes
 * o) Normal
 * o) Dual (-d or -r) (legacy)
 * o) Reverse (Client side) (client acts like server)
 * o) FullDuplex (Client side) client starts server
 * o) ServerReverse (Server side) (listener starts a client)
 * o) FullDuplex (Server side) (listener starts server & client)
 * o) WriteAck
 *
 * Note: This runs in client thread context
 */
void client_spawn (struct thread_Settings *thread) {
    Client *theClient = NULL;

    // set traffic thread to realtime if needed
#if HAVE_SCHED_SETSCHEDULER
    thread_setscheduler(thread);
#endif
    // start up the client
    setTransferID(thread, 0);
    theClient = new Client(thread);
    // let the reporter thread go first in the case of -P greater than 1
    Condition_Lock(reporter_state.await);
    while (!reporter_state.ready) {
	Condition_TimedWait(&reporter_state.await, 1);
    }
    Condition_Unlock(reporter_state.await);

    if (isConnectOnly(thread)) {
	theClient->ConnectPeriodic();
    } else if (!isServerReverse(thread)) {
	// These are the client side spawning of clients
	if (!isReverse(thread) && !isFullDuplex(thread)) {
	    clientside_client_basic(thread, theClient);
	} else if (isReverse(thread) && !isFullDuplex(thread)) {
	    clientside_client_reverse(thread, theClient);
	} else if (isFullDuplex(thread)) {
	    clientside_client_fullduplex(thread, theClient);
	} else {
	    fprintf(stdout, "Program error in client side client_spawn");
	    _exit(0);
	}
    } else {
	if (thread->mMode != kTest_Normal) {
	    setCompat(thread);
	    // These are the server or listener side spawning of clients
	    serverside_client_bidir(thread, theClient);
	} else {
	    serverside_client_fullduplex(thread, theClient);
	}
    }
    // Call the client's destructor
    DELETE_PTR(theClient);
}

/*
 * client_init handles multiple threaded connects. It creates
 * a listener object if either the dual test or tradeoff were
 * specified. It also creates settings structures for all the
 * threads and arranges them so they can be managed and started
 * via the one settings structure that was passed in.
 *
 * Note: This runs in main thread context
 */
void client_init(struct thread_Settings *clients) {
    struct thread_Settings *itr = NULL;
    struct thread_Settings *next = NULL;

    itr = clients;
    setReport(clients);
    // See if we need to start a listener as well
    Settings_GenerateListenerSettings(clients, &next);
#ifdef HAVE_THREAD
    if (next != NULL) {
        // We have threads and we need to start a listener so
        // have it ran before the client is launched
        itr->runNow = next;
        itr = next;
    }
    // For each of the needed threads create a copy of the
    // provided settings, unsetting the report flag and add
    // to the list of threads to start
    for (int i = 1; i < clients->mThreads; i++) {
	Settings_Copy(clients, &next, 1);
	// printf("*****port/thread = %d/%d\n", next->mPort + i, i);
	if (next) {
	    if (isIncrSrcIP(clients) && (clients->mLocalhost != NULL)) {
		next->incrsrcip = i;
	    }
	    if (isIncrDstIP(clients)) {
		next->incrdstip = i;
		// force a setHostname
		SockAddr_zeroAddress(&next->peer);
	    } else if (clients->mBindPort) {
		// Increment the source port of none of the quintuple is being change or the user requests it
		if ((!isIncrDstPort(clients) && !isIncrDstIP(clients) && !isIncrSrcIP(clients)) || isIncrSrcPort(clients)) {
		    // case -B with src port and -P > 1
		    next->incrsrcport = i;
		}
	    }
	    if (isIncrDstPort(clients)) {
		next->mPort += i;
		SockAddr_zeroAddress(&next->peer);
	    }
	}
	itr->runNow = next;
	itr = next;
    }
    if (isBounceBack(clients) && (isWorkingLoadUp(clients) || isWorkingLoadDown(clients))) {
	int bbwlthreads = (clients->mBounceBackCongestThreads == 0) ? 1 : clients->mBounceBackCongestThreads;
	while (bbwlthreads--) {
	    Settings_Copy(clients, &next, 1);
	    if (next != NULL) {
		unsetBounceBack(next);
		unsetPeriodicBurst(next);
		unsetTxHoldback(next); // don't delay working load threads
		next->mTOS = 0; // disable any QoS on the congestion stream
		if (isWorkingLoadUp(clients) && isWorkingLoadDown(clients)) {
		    setFullDuplex(next);
		} else if (isWorkingLoadDown(clients)) {
		    setReverse(next);
		}
		if (isBounceBack(clients) && (clients->mBounceBackCongestThreads > 1)) {
		    Iperf_push_host(clients);
		}
		// Bump the bounceback time to include the delay time
		if (next->txholdback_timer.tv_sec || next->txholdback_timer.tv_usec) {
		    // mAmount units are 10 ms
		    next->mAmount += (next->txholdback_timer.tv_sec * 100);
		    next->mAmount += (next->txholdback_timer.tv_usec / 10000);
		}
		itr->runNow = next;
		itr = next;
	    }
	}
    }
#else
    if (next != NULL) {
        // We don't have threads and we need to start a listener so
        // have it ran after the client is finished
        itr->runNext = next;
    }
#endif
}

void listeners_init(struct thread_Settings *listener) {
    struct thread_Settings *itr = listener;
    struct thread_Settings *next = NULL;
    for (int ix = 1; ix < (listener->mPortLast - listener->mPort + 1); ix++)  {
	Settings_Copy(listener, &next, 1);
	if (next != NULL) {
	    setNoSettReport(next);
	    next->mPort = listener->mPort + ix;
	    next->mThreadMode = kMode_Listener;
	    itr->runNow = next;
	    itr = next;
	}
    }
}
