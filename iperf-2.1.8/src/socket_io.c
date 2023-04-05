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
 * socket.c
 * by Mark Gates <mgates@nlanr.net>
 * -------------------------------------------------------------------
 * set/getsockopt and read/write wrappers
 * ------------------------------------------------------------------- */

#include "headers.h"
#include "util.h"

#ifdef __cplusplus
extern "C" {
#endif

/* -------------------------------------------------------------------
 * Attempts to reads n bytes from a socket.
 * Returns number actually read, or -1 on error.
 * If number read < inLen then we reached EOF.
 *
 * from Stevens, 1998, section 3.9
 * ------------------------------------------------------------------- */
ssize_t readn (int inSock, void *outBuf, size_t inLen) {
    size_t  nleft;
    ssize_t nread;
    char *ptr;

    assert(inSock >= 0);
    assert(outBuf != NULL);
    assert(inLen > 0);

    ptr   = (char*) outBuf;
    nleft = inLen;

    while (nleft > 0) {
        nread = read(inSock, ptr, nleft);
        if (nread < 0) {
            if (errno == EINTR)
                nread = 0;  /* interupted, call read again */
            else
                return -1;  /* error */
        } else if (nread == 0)
            break;        /* EOF */

        nleft -= nread;
        ptr   += nread;
    }

    return(inLen - nleft);
} /* end readn */

/* -------------------------------------------------------------------
 * Similar to read but supports recv flags
 * Returns number actually read, or -1 on error.
 * If number read < inLen then we reached EOF.
 * from Stevens, 1998, section 3.9
 * ------------------------------------------------------------------- */
int recvn (int inSock, char *outBuf, int inLen, int flags) {
    int  nleft;
    int nread = 0;
    char *ptr;

    assert(inSock >= 0);
    assert(outBuf != NULL);
    assert(inLen > 0);

    ptr   = outBuf;
    nleft = inLen;
#if (HAVE_DECL_MSG_PEEK)
    if (flags & MSG_PEEK) {
	while ((nleft != nread) && !sInterupted) {
	    nread = recv(inSock, ptr, nleft, flags);
	    switch (nread) {
	    case SOCKET_ERROR :
		// Note: use TCP fatal error codes even for UDP
		if (FATALTCPREADERR(errno)) {
		    WARN_errno(1, "recvn peek");
		    nread = -1;
		    sInterupted = 1;
		    goto DONE;
		}
#ifdef HAVE_THREAD_DEBUG
		WARN_errno(1, "recvn peek non-fatal");
#endif
		break;
	    case 0:
#ifdef HAVE_THREAD_DEBUG
		WARN(1, "recvn peek peer close");
#endif
		goto DONE;
		break;
	    default :
		break;
	    }
	}
    } else
#endif
    {
	while ((nleft > 0) && !sInterupted) {
#if (HAVE_DECL_MSG_WAITALL)
	    nread = recv(inSock, ptr, nleft, MSG_WAITALL);
#else
	    nread = recv(inSock, ptr, nleft, 0);
#endif
	    switch (nread) {
	    case SOCKET_ERROR :
		// Note: use TCP fatal error codes even for UDP
		if (FATALTCPREADERR(errno)) {
		    WARN_errno(1, "recvn");
		    nread = -1;
		    sInterupted = 1;
		    goto DONE;
		} else {
		    nread = -2;
		    goto DONE;
		}
#ifdef HAVE_THREAD_DEBUG
		WARN_errno(1, "recvn non-fatal");
#endif
		break;
	    case 0:
#ifdef HAVE_THREAD_DEBUG
		WARN(1, "recvn peer close");
#endif
		nread = inLen - nleft;
		goto DONE;
		break;
	    default :
		nleft -= nread;
		ptr   += nread;
		break;
	    }
	    nread = inLen - nleft;
	}
    }
  DONE:
    return(nread);
} /* end readn */

/* -------------------------------------------------------------------
 * Attempts to write  n bytes to a socket.
 * returns number actually written, or -1 on error.
 * number written is always inLen if there is not an error.
 *
 * from Stevens, 1998, section 3.9
 * ------------------------------------------------------------------- */

int writen (int inSock, const void *inBuf, int inLen, int *count) {
    int nleft;
    int nwritten;
    const char *ptr;

    assert(inSock >= 0);
    assert(inBuf != NULL);
    assert(inLen > 0);
    assert(count != NULL);

    ptr   = (char*) inBuf;
    nleft = inLen;
    nwritten = 0;
    *count = 0;

    while ((nleft > 0) && !sInterupted) {
        nwritten = write(inSock, ptr, nleft);
	(*count)++;
	switch (nwritten) {
	case SOCKET_ERROR :
	    if (!(errno == EINTR) || (errno == EAGAIN) || (errno == EWOULDBLOCK)) {
		nwritten = inLen - nleft;
		WARN_errno(1, "writen fatal");
		sInterupted = 1;
		goto DONE;
	    }
	    break;
	case 0:
	    // write timeout - retry
	    break;
	default :
	    nleft -= nwritten;
	    ptr   += nwritten;
	    break;
	}
	nwritten = inLen - nleft;
    }
  DONE:
    return (nwritten);
} /* end writen */



#ifdef __cplusplus
} /* end extern "C" */
#endif
