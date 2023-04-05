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
 * List.h
 * by Kevin Gibbs <kgibbs@ncsa.uiuc.edu>
 *
 * renamed to active_hosts.h
 * -------------------------------------------------------------------
 */

#ifndef Iperf_LIST_H
#define Iperf_LIST_H

#include "headers.h"
#include "Settings.hpp"
#include "Mutex.h"

/*
 * A List entry that consists of a sockaddr
 * a pointer to the Audience that sockaddr is
 * associated with and a pointer to the next
 * entry
 */
struct Iperf_ListEntry {
    iperf_sockaddr host;
    struct SumReport *sum_report;
    int thread_count;
#if WIN32
    SOCKET socket;
#else
    int socket;
#endif
    struct Iperf_ListEntry *next;
};

struct Iperf_Table {
    Mutex my_mutex;
    struct Iperf_ListEntry *root;
    int count;
    int total_count;
    int groupid;
};

/*
 * Functions to modify or search the list
 */
void Iperf_initialize_active_table (void);
void Iperf_destroy_active_table (void);
int Iperf_push_host (struct thread_Settings *agent);
int Iperf_push_host_port_conditional (struct thread_Settings *agent);
void Iperf_remove_host (struct thread_Settings *agent);
#endif
