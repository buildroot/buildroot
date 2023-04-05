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
 * util.h
 * by Mark Gates <mgates@nlanr.net>
 * -------------------------------------------------------------------
 * various C utility functions.
 * ------------------------------------------------------------------- */

#ifndef UTIL_H
#define UTIL_H

#ifdef HAVE_CONFIG_H
    #include "config.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

extern int sInterupted;

/* -------------------------------------------------------------------
 * set/getsockopt wrappers for SO_RCVBUF and SO_SNDBUF; TCP_MAXSEG
 * socket.c
 * ------------------------------------------------------------------- */
int setsock_tcp_windowsize(int inSock, int inTCPWin, int inSend);
int getsock_tcp_windowsize(int inSock, int inSend);

bool setsock_blocking(int fd, bool blocking);
#if HAVE_DECL_TCP_WINDOW_CLAMP
int  getsock_tcp_windowclamp(int inSock);
int  setsock_tcp_windowclamp(int inSock, int clampsize);
#endif
#if HAVE_DECL_TCP_NOTSENT_LOWAT
int  getsock_tcp_notsent_low_watermark(int inSock);
int  setsock_tcp_notsent_low_watermark(int inSock, int clampsize);
#endif
int recvn(int inSock, char *outBuf, int inLen, int flags);
int writen(int inSock, const void *inBuf, int inLen, int *count);

void disarm_itimer(void);
int set_itimer(int);
/* -------------------------------------------------------------------
 * signal handlers
 * signal.c
 * ------------------------------------------------------------------- */
typedef void Sigfunc(int);
void sig_exit(int inSigno);

typedef Sigfunc *SigfuncPtr;

SigfuncPtr my_signal(int inSigno, SigfuncPtr inFunc);

#ifdef WIN32

#ifdef HAVE_SIGNAL_H
  #define _NSIG NSIG
#else
/* under windows, emulate unix signals */
enum {
    SIGINT,
    SIGTERM,
    SIGPIPE,
    _NSIG
};
#endif

BOOL WINAPI sig_dispatcher(DWORD type);

#endif

/* -------------------------------------------------------------------
 * error handlers
 * error.c
 * ------------------------------------------------------------------- */
void warn      (const char *inMessage, const char *inFile, int inLine);
void warn_errno(const char *inMessage, const char *inFile, int inLine);

#if defined(HAVE_POSIX_THREAD) || defined(HAVE_WIN32_THREAD)
#define FAIL(cond, msg, settings)             \
  do {                                          \
    if (cond) {                               \
      warn(msg, __FILE__, __LINE__);          \
      thread_stop(settings);                    \
    }                                           \
  } while(0)
#else
#define FAIL(cond, msg, settings)             \
  do {                                          \
    if (cond) {                               \
      warn(msg, __FILE__, __LINE__);          \
      exit(1);                                \
    }                                           \
  } while(0)
#endif

#define WARN(cond, msg)                       \
  do {                                          \
    if (cond) {                               \
      warn(msg, __FILE__, __LINE__);          \
    }                                           \
  } while(0)

#if defined(HAVE_POSIX_THREAD) || defined(HAVE_WIN32_THREAD)
#define FAIL_errno(cond, msg, settings)       \
  do {                                          \
    if (cond) {                               \
      warn_errno(msg, __FILE__, __LINE__);    \
      thread_stop(settings);                    \
    }                                           \
  } while(0)
#else
#define FAIL_errno(cond, msg, settings)       \
  do {                                          \
    if (cond) {                               \
      warn_errno(msg, __FILE__, __LINE__);    \
      exit(1);                                \
    }                                           \
  } while(0)
#endif

#define WARN_errno(cond, msg)                 \
  do {                                          \
    if (cond) {                               \
      warn_errno(msg, __FILE__, __LINE__);    \
    }                                           \
  } while(0)

/* -------------------------------------------------------------------
 * initialize buffer to a pattern
 * ------------------------------------------------------------------- */
void pattern(char *outBuf, int inBytes);

/* -------------------------------------------------------------------
 * input and output numbers, converting with kilo, mega, giga
 * stdio.c
 * ------------------------------------------------------------------- */
double byte_atof(const char *inString);
double bitorbyte_atof(const char *inString);
intmax_t byte_atoi(const char  *inString);
uintmax_t bitorbyte_atoi(const char *inString);
void byte_snprintf(char* outString, int inLen, double inNum, char inFormat);

/*
 * Time macros for C-code (not the include Timestamp.hpp)
 */
#define rMillion 1000000

#define TimeZero(timeval) ((timeval.tv_sec == 0) && (timeval.tv_usec == 0))

#define TimeDifference(left, right) ((left.tv_sec  - right.tv_sec) +	\
				     (left.tv_usec - right.tv_usec) / ((double) rMillion))

#define TimeDifferenceUsec(left, right)  ((1e6 * (left.tv_sec  - right.tv_sec)) + \
					  (double) (left.tv_usec - right.tv_usec))

#define TimeDouble(timeval) (timeval.tv_sec + timeval.tv_usec / ((double) rMillion))

#define TimeAdd(left, right)  do {                                    \
                                    left.tv_usec += right.tv_usec;      \
                                    if (left.tv_usec > rMillion) {    \
                                        left.tv_usec -= rMillion;       \
                                        left.tv_sec++;                  \
                                    }                                   \
                                    left.tv_sec += right.tv_sec;        \
                                } while (0)

/* -------------------------------------------------------------------
 * redirect the stdout to a specified file
 * stdio.c
 * ------------------------------------------------------------------- */
void redirect(const char *inOutputFileName);

/* -------------------------------------------------------------------
 * delete macro
 * ------------------------------------------------------------------- */
#define DELETE_PTR(ptr)                       \
  do {                                          \
    if (ptr != NULL) {                        \
      delete ptr;                               \
      ptr = NULL;                               \
    }                                           \
  } while(false)

#define DELETE_ARRAY(ptr)                     \
  do {                                          \
    if (ptr != NULL) {                        \
      delete [] ptr;                            \
      ptr = NULL;                               \
    }                                           \
  } while(false)

#define FREE_ARRAY(ptr)                     \
  do {                                          \
    if (ptr != NULL) {                        \
      free(ptr); \
      ptr = NULL;                               \
    }                                           \
  } while(false)


// Readn and write error macros
// Define fatal and nonfatal write errors
#ifdef WIN32
#define FATALTCPREADERR(errno) (WSAGetLastError() != WSAEWOULDBLOCK)
#define FATALUDPREADERR(errno)  (((errno = WSAGetLastError()) != WSAEWOULDBLOCK))
#define FATALTCPWRITERR(errno)  ((errno = WSAGetLastError()) != WSAETIMEDOUT)
#define NONFATALTCPWRITERR(errno) ((errno = WSAGetLastError()) == WSAETIMEDOUT)
#define FATALUDPWRITERR(errno)  (((errno = WSAGetLastError()) != WSAETIMEDOUT) \
				 && (errno != WSAECONNREFUSED))
#else
#define FATALTCPREADERR(errno) ((errno != EAGAIN) && (errno != EWOULDBLOCK) && (errno != EINTR))
#define FATALUDPREADERR(errno) ((errno != EAGAIN) && (errno != EWOULDBLOCK) && \
				(errno != EINTR))
#define FATALTCPWRITERR(errno)  (errno != EAGAIN && errno != EWOULDBLOCK && errno != EINTR)
#define NONFATALTCPWRITERR(errno)  (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)
#define FATALUDPWRITERR(errno) 	((errno != EAGAIN) && (errno != EWOULDBLOCK) && (errno != EINTR) \
				 && (errno != ECONNREFUSED) && (errno != ENOBUFS))
#endif

#ifdef WIN32
#else
#endif

#ifdef __cplusplus
} /* end extern "C" */
#endif

#endif /* UTIL_H */
