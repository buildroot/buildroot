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
 * Listener.hpp
 * by Mark Gates <mgates@nlanr.net>
 * -------------------------------------------------------------------
 * Listener sets up a socket listening on the server host. For each
 * connected socket that accept() returns, this creates a Server
 * socket and spawns a thread for it.
 * ------------------------------------------------------------------- */

#ifndef LISTENER_H
#define LISTENER_H

#include "Thread.h"
#include "Settings.hpp"
#include "Timestamp.hpp"

class Listener;

class Listener {
public:
    // stores server port and TCP/UDP mode
    Listener(thread_Settings *inSettings);
    // destroy the server object
    ~Listener();
    // accepts connections and starts Servers
    void Run(void);

private:
    int mClients;
    struct ether_header *eth_hdr;
    struct iphdr *ip_hdr;
    struct udphdr *udp_hdr;
    thread_Settings *mSettings;
    thread_Settings *server;
    Timestamp mEndTime;
    bool apply_client_settings_udp(thread_Settings *server);
    bool apply_client_settings_tcp(thread_Settings *server);
    bool apply_client_settings(thread_Settings *server);
    int client_test_ack(thread_Settings *server);
    void my_multicast_join(void);
    void my_listen(void);
    int my_accept(thread_Settings *server);
    int udp_accept(thread_Settings *server);
    int tuntap_accept(thread_Settings *server);
    bool L2_setup(thread_Settings *server, int sockfd);
    bool tap_setup(thread_Settings *server, int sockfd);
    void UDPSingleServer(thread_Settings *server);
    bool test_permit_key(uint32_t flags, thread_Settings *server, int keyoffset);
#if WIN32
    SOCKET ListenSocket;
#else
    int ListenSocket;
#endif
}; // end class Listener

#endif // LISTENER_H
