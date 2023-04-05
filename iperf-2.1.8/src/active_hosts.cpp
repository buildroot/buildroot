/*---------------------------------------------------------------
 * Copyrig h(c) 1999,2000,2001,2002,2003
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
 * active_hosts.c (was List.cpp)
 * rewrite by Robert McMahon
 *
 * This is a list to hold active traffic and create sum groups
 * sum groups are traffic sessions from the same client host
 * -------------------------------------------------------------------
 */

#include "active_hosts.h"
#include "Mutex.h"
#include "SocketAddr.h"
#include "Reporter.h"

/*
 * Global table with active hosts, their sum reports and active thread counts
 */
static struct Iperf_Table active_table;
static bool Iperf_host_port_present (iperf_sockaddr *find);
static struct Iperf_ListEntry* Iperf_host_present (iperf_sockaddr *find);

#if HAVE_THREAD_DEBUG
static void active_table_show_entry(const char *action, Iperf_ListEntry *entry, int found) {
    assert(action != NULL);
    assert(entry != NULL);
    char tmpaddr[200];
    size_t len=200;
    unsigned short port = SockAddr_getPort(&(entry->host));
    SockAddr_getHostAddress(&(entry->host), tmpaddr, len);
    thread_debug("active table: %s %s port %d (flag=%d) rootp=%p entryp=%p totcnt/activecnt/hostcnt = %d/%d/%d", \
		 action, tmpaddr, port, found, (void *) active_table.root, (void *) entry, active_table.total_count, \
		 active_table.count, entry->thread_count);
}
static void active_table_show_compare(const char *action, Iperf_ListEntry *entry, iperf_sockaddr *host, const char *type) {
    assert(action != NULL);
    assert(entry != NULL);
    char lookupaddr[200];
    char findaddr[200];
    size_t len=200;
    unsigned short port = SockAddr_getPort(&(entry->host));
    unsigned short findport = SockAddr_getPort(host);
    SockAddr_getHostAddress(&(entry->host), lookupaddr, len);
    SockAddr_getHostAddress(host, findaddr, len);
    thread_debug("active table: compare table entry %s %s/%d against host %s/%d (%s)", type, lookupaddr, port, findaddr, findport, action);
}
#endif

void Iperf_initialize_active_table () {
    Mutex_Initialize(&active_table.my_mutex);
    active_table.root = NULL;
    active_table.groupid = 0;
}

/*
 * Add Entry add to the list or update thread count
 */
static void active_table_update (iperf_sockaddr *host, struct thread_Settings *agent) {
    assert(host != NULL);
    assert(agent != NULL);
    Iperf_ListEntry *this_entry = Iperf_host_present(host);
    active_table.total_count++;
    if (this_entry == NULL) {
	this_entry = new Iperf_ListEntry();
	assert(this_entry != NULL);
	this_entry->host = *host;
	this_entry->next = active_table.root;
	this_entry->thread_count = 1;
	this_entry->socket = agent->mSock;
	active_table.count++;
	active_table.groupid++;
	active_table.root = this_entry;
#if HAVE_THREAD_DEBUG
	active_table_show_entry("new entry", this_entry, ((SockAddr_are_Equal(&this_entry->host, host) && SockAddr_Hostare_Equal(&this_entry->host, host))));
#endif
	this_entry->sum_report = InitSumReport(agent, active_table.total_count, 0);
	agent->mSumReport = this_entry->sum_report;
    } else {
	this_entry->thread_count++;
	agent->mSumReport = this_entry->sum_report;
#if HAVE_THREAD_DEBUG
	active_table_show_entry("incr entry", this_entry, 1);
#endif
    }
}

static inline iperf_sockaddr *active_table_get_host_key (struct thread_Settings *agent) {
    iperf_sockaddr *key = (isSumServerDstIP(agent) ? &agent->local : &agent->peer);
    return key;
}

// Thread access to store a host
int Iperf_push_host (struct thread_Settings *agent) {
    iperf_sockaddr *host = active_table_get_host_key(agent);
    Mutex_Lock(&active_table.my_mutex);
    active_table_update(host, agent);
    int groupid = active_table.groupid;
    Mutex_Unlock(&active_table.my_mutex);
    return groupid;
}

// Used for UDP push of a new host, returns negative value if the host/port is already present
// This is critical because UDP is connectionless and designed to be stateless
int Iperf_push_host_port_conditional (struct thread_Settings *agent) {
    iperf_sockaddr *host = active_table_get_host_key(agent);
    int rc = -1;
    Mutex_Lock(&active_table.my_mutex);
    if (!Iperf_host_port_present(host)) {
	active_table_update(host, agent);
	rc = active_table.groupid;
    }
    Mutex_Unlock(&active_table.my_mutex);
    return (rc);
}

/*
 * Remove a host from the table
 */
void Iperf_remove_host (struct thread_Settings *agent) {
    iperf_sockaddr *del = active_table_get_host_key(agent);
    // remove_list_entry(entry) {
    //     indirect = &head;
    //     while ((*indirect) != entry) {
    //	       indirect = &(*indirect)->next;
    //     }
    //     *indirect = entry->next
    Mutex_Lock(&active_table.my_mutex);
    Iperf_ListEntry **tmp = &active_table.root;
    while ((*tmp) && !(SockAddr_Hostare_Equal(&(*tmp)->host, del))) {
#if HAVE_THREAD_DEBUG
        active_table_show_compare("miss", *tmp, del, "client ip");
#endif
	tmp = &(*tmp)->next;
    }
    if (*tmp) {
	if (--(*tmp)->thread_count == 0) {
	    Iperf_ListEntry *remove = (*tmp);
	    active_table.count--;
#if HAVE_THREAD_DEBUG
	    active_table_show_entry("delete", remove, 1);
#endif
	    *tmp = remove->next;
	    delete remove;
	} else {
#if HAVE_THREAD_DEBUG
	    active_table_show_entry("decr", (*tmp), 1);
#endif
	}
    }
    Mutex_Unlock(&active_table.my_mutex);
}

/*
 * Destroy the table
 */
void Iperf_destroy_active_table () {
    Iperf_ListEntry *itr1 = active_table.root, *itr2;
    while (itr1 != NULL) {
        itr2 = itr1->next;
        delete itr1;
        itr1 = itr2;
    }
    Mutex_Destroy(&active_table.my_mutex);
    active_table.root = NULL;
    active_table.count = 0;
    active_table.total_count = 0;
}

/*
 * Check if the host and port are present in the active table
 */
bool Iperf_host_port_present (iperf_sockaddr *find) {
    Iperf_ListEntry *itr = active_table.root;
    bool rc = false;
    while (itr != NULL) {
        if (SockAddr_are_Equal(&itr->host, find)) {
#if HAVE_THREAD_DEBUG
	    active_table_show_compare("match", itr, find, "client ip/port");
#endif
	    rc = true;
            break;
        } else {
#if HAVE_THREAD_DEBUG
	    active_table_show_compare("miss", itr, find, "client ip/port");
#endif
	    itr = itr->next;
	}
    }
    return rc;
}

/*
 * Check if the host is present in the active table
 */
static Iperf_ListEntry* Iperf_host_present (iperf_sockaddr *find) {
    Iperf_ListEntry *itr = active_table.root;
    while (itr != NULL) {
        if (SockAddr_Hostare_Equal(&itr->host, find)) {
#if HAVE_THREAD_DEBUG
	    active_table_show_compare("match", itr, find, "client ip");
#endif
            break;
        } else {
#if HAVE_THREAD_DEBUG
	    active_table_show_compare("miss", itr, find, "client ip");
#endif
	    itr = itr->next;
	}
    }
    return itr;
}
