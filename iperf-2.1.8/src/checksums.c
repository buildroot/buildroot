/*---------------------------------------------------------------
 * Copyright (c) 2018
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
 * UDP checksums v4 and v6
 *
 * The checksum calculation is defined in RFC 768
 * hints as to how to calculate it efficiently are in RFC 1071
 *
 * by Robert J. McMahon (rjmcmahon@rjmcmahon.com, bob.mcmahon@broadcom.com)
 * -------------------------------------------------------------------
 */
#include "headers.h"

/*
 *
 * Compute Internet Checksum for UDP packets (assumes 32 bit system)
 *
 * IPV4 Notes:
 *
 *                     User Datagram Header Format
 *                 0      7 8     15 16    23 24    31
 *                +--------+--------+--------+--------+
 *                |     Source      |   Destination   |
 *                |      Port       |      Port       |
 *                +--------+--------+--------+--------+
 *                |                 |                 |
 *                |     Length      |    Checksum     |
 *                +--------+--------+--------+--------+
 *                |
 *                |          data octets ...
 *                +---------------- ...
 *
 *
 * Checksum is the 16-bit one's complement of the one's complement sum of a
 * pseudo header of information from the IP header, the UDP header, and the
 * data,  padded  with zero octets  at the end (if  necessary)  to  make  a
 * multiple of two octets.
 *
 * The ipv4 pseudo  header  conceptually prefixed to the UDP header contains the
 * source  address,  the destination  address,  the protocol,  and the  UDP
 * length.   This information gives protection against misrouted datagrams.
 * This checksum procedure is the same as is used in TCP.
 *
 *                 0      7 8     15 16    23 24    31
 *                +--------+--------+--------+--------+
 *                |          source address           |
 *                +--------+--------+--------+--------+
 *                |        destination address        |
 *                +--------+--------+--------+--------+
 *                |  zero  |protocol|   UDP length    |
 *                +--------+--------+--------+--------+
 *
 * If the computed  checksum  is zero,  it is transmitted  as all ones (the
 * equivalent  in one's complement  arithmetic).   An all zero  transmitted
 * checksum  value means that the transmitter  generated  no checksum  (for
 * debugging or for higher level protocols that don't care).
 *
 *
 *  IPV6 Notes:
 *
 *  Any transport or other upper-layer protocol that includes the
 *  addresses from the IP header in its checksum computation must be
 *  modified for use over IPv6, to include the 128-bit IPv6 addresses
 *  instead of 32-bit IPv4 addresses.  In particular, the following
 *  illustration shows the TCP and UDP "pseudo-header" for IPv6:
 *
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |                                                               |
 *  +                                                               +
 *  |                                                               |
 *  +                         Source Address                        +
 *  |                                                               |
 *  +                                                               +
 *  |                                                               |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |                                                               |
 *  +                                                               +
 *  |                                                               |
 *  +                      Destination Address                      +
 *  |                                                               |
 *  +                                                               +
 *  |                                                               |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |                   Upper-Layer Packet Length                   |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *  |                      zero                     |  Next Header  |
 *  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 *
 *     o  If the IPv6 packet contains a Routing header, the Destination
 *        Address used in the pseudo-header is that of the final
 *        destination.  At the originating node, that address will be in
 *        the last element of the Routing header; at the recipient(s),
 *        that address will be in the Destination Address field of the
 *        IPv6 header.
 *
 *     o  The Next Header value in the pseudo-header identifies the
 *        upper-layer protocol (e.g., 6 for TCP, or 17 for UDP).  It will
 *        differ from the Next Header value in the IPv6 header if there
 *        are extension headers between the IPv6 header and the upper-
 *        layer header.
 *
 *     o  The Upper-Layer Packet Length in the pseudo-header is the
 *        length of the upper-layer header and data (e.g., TCP header
 *        plus TCP data).  Some upper-layer protocols carry their own
 *        length information (e.g., the Length field in the UDP header);
 *        for such protocols, that is the length used in the pseudo-
 *        header.  Other protocols (such as TCP) do not carry their own
 *        length information, in which case the length used in the
 *        pseudo-header is the Payload Length from the IPv6 header, minus
 *        the length of any extension headers present between the IPv6
 *        header and the upper-layer header.
 *
 *     o  Unlike IPv4, when UDP packets are originated by an IPv6 node,
 *        the UDP checksum is not optional.  That is, whenever
 *        originating a UDP packet, an IPv6 node must compute a UDP
 *        checksum over the packet and the pseudo-header, and, if that
 *        computation yields a result of zero, it must be changed to hex
 *        FFFF for placement in the UDP header.  IPv6 receivers must
 *        discard UDP packets containing a zero checksum, and should log
 *        the error.
 *
 *
 *  Returns zero on checksum success, non zero otherwise
 */

#define IPV4SRCOFFSET 12  // the ipv4 source address offset from the l3 pdu
#define IPV6SRCOFFSET 8 // the ipv6 source address offset
#define IPV6SIZE 8 // units is number of 16 bits, i.e. 128 bits is eight 16 bits
#define IPV4SIZE 2 // v4 is two 16 bits (32 bits)
#define UDPPROTO 17 // UDP protocol value for psuedo header
uint32_t udpchecksum(const void *l3pdu, const void *l4pdu, int udplen, int v6) {
    register uint32_t sum = 0;
    const uint16_t *data;
    int i;

    const struct udphdr *udp_hdr = (const struct udphdr *)l4pdu;
    if (!udp_hdr->check) {
	if (v6)
	    // v6 requires checksums
	    return -1;
	else
	    // v4 checksums are optional
	    return 0;
    }

    /*
     *	Build pseudo headers, partially from the packet
     *  (which are in network byte order) and
     *  the protocol of UDP (value of 17).  Also, the IP dst
     *  addr immediately follows the src so double the size
     *  per each loop to cover both addrs
     */
    if (v6) {
	// skip to the ip header v6 src field, offset 8 (see ipv6 header)
	data = (const uint16_t *)((char *)l3pdu + IPV6SRCOFFSET);
	for (i = 0; i < (2 * IPV6SIZE); i++) {
	    sum += *data++;
	}
    } else {
	// skip to the ip header v4 src field, offset 12 (see ipv4 header)
	data = (const uint16_t *)((char *)l3pdu + IPV4SRCOFFSET);
	for (i = 0; i < (2 * IPV4SIZE); i++) {
	    sum += *data++;
	}
    }
    //  These should work for both v4 and v6 even though
    //  v6 psuedo header uses 32 bit values because the
    //  uppers in v6 will be zero
    sum += htons(UDPPROTO); // proto of UDP is 17
    sum += htons(udplen); // For UDP, the pseudo hdr len equals udp len

    /*
     * UDP hdr + payload
     */
    data = (const uint16_t *) l4pdu;
    while( udplen > 1 )  {
	sum += *data++;
	udplen -= 2;
    }
    /*  Add left-over byte, if any */
    if( udplen > 0 )
	sum += * (uint8_t *) data;

    /*  Fold 32-bit sum to 16 bits */
    while (sum>>16)
	sum = (sum & 0xffff) + (sum >> 16);

    /* return ones complement */
    sum = (sum ^ 0xffff);
    return sum;
}
