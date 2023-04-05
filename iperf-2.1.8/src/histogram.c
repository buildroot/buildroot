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
 * histograms.c
 * Suppport for histograms
 *
 * by Robert J. McMahon (rjmcmahon@rjmcmahon.com, bob.mcmahon@broadcom.com)
 * -------------------------------------------------------------------
 */
#include "headers.h"
#include "histogram.h"
#ifdef HAVE_THREAD_DEBUG
// needed for thread_debug
#include "Thread.h"
#endif
struct histogram *histogram_init(unsigned int bincount, unsigned int binwidth, float offset, float units,\
			    double ci_lower, double ci_upper, unsigned int id, char *name) {
    struct histogram *this = (struct histogram *) malloc(sizeof(struct histogram));
    if (!this) {
        fprintf(stderr,"Malloc failure in histogram init\n");
        return(NULL);
    }
    if (!bincount)
	bincount = 1000;
    this->mybins = (unsigned int *) malloc(sizeof(unsigned int) * bincount);
    if (!this->mybins) {
        fprintf(stderr,"Malloc failure in histogram init b\n");
        free(this);
        return(NULL);
    }
    this->myname = (char *) malloc(sizeof(strlen(name)));
    if (!this->myname) {
        fprintf(stderr,"Malloc failure in histogram init n\n");
        free(this->mybins);
        free(this);
        return(NULL);
    }
    this->outbuf = (char *) malloc(120 + (32*bincount) + strlen(name));
    if (!this->outbuf) {
        fprintf(stderr,"Malloc failure in histogram init o\n");
        free(this->myname);
        free(this->mybins);
        free(this);
        return(NULL);
    }
    memset(this->mybins, 0, bincount * sizeof(unsigned int));
    strcpy(this->myname, name);
    this->id = id;
    this->bincount = bincount;
    this->binwidth = binwidth;
    this->populationcnt = 0;
    this->offset=offset;
    this->units=units;
    this->cntloweroutofbounds=0;
    this->cntupperoutofbounds=0;
    this->ci_lower = ci_lower;
    this->ci_upper = ci_upper;
    this->prev = NULL;
    this->maxbin = -1;
    this->fmaxbin = -1;
    this->maxts.tv_sec = 0;
    this->maxts.tv_usec = 0;
    this->fmaxts.tv_sec = 0;
    this->fmaxts.tv_usec = 0;
#ifdef HAVE_THREAD_DEBUG
    thread_debug("histo create %p", (void *) this);
#endif
    return this;
}

void histogram_delete(struct histogram *h) {
#ifdef HAVE_THREAD_DEBUG
  thread_debug("histo delete %p", (void *) h);
#endif
  if (h) {
    if (h->prev)
	histogram_delete(h->prev);
    if (h->mybins)
	free(h->mybins);
    if (h->myname)
	free(h->myname);
    free(h);
  }
}

// value is units seconds
int histogram_insert(struct histogram *h, float value, struct timeval *ts) {
    int bin;
    // calculate the bin, convert the value units from seconds to units of interest
    bin = (int) (h->units  * (value - h->offset) / h->binwidth);
    h->populationcnt++;
    if (ts && (value > h->maxval)) {
        h->maxbin = bin;
        h->maxval = value;
        h->maxts.tv_sec = ts->tv_sec;
        h->maxts.tv_usec = ts->tv_usec;
	// printf("imax=%ld.%ld %f\n",h->maxts.tv_sec, h->maxts.tv_usec, value);
	if (value > h->fmaxval) {
	  h->fmaxbin = bin;
          h->fmaxval = value;
	  h->fmaxts.tv_sec = ts->tv_sec;
	  h->fmaxts.tv_usec = ts->tv_usec;
	  // printf("fmax=%ld.%ld %f\n",h->fmaxts.tv_sec, h->fmaxts.tv_usec, value);
	}
    }
    if (bin < 0) {
	h->cntloweroutofbounds++;
	return(-1);
    } else if (bin > (int) h->bincount) {
	h->cntupperoutofbounds++;
	return(-2);
    }
    else {
	h->mybins[bin]++;
	return(h->mybins[bin]);
    }
}

void histogram_clear(struct histogram *h) {
    memset(h->mybins, 0, (h->bincount * sizeof(unsigned int)));
    h->populationcnt = 0;
    h->cntloweroutofbounds=0;
    h->cntupperoutofbounds=0;
    h->maxbin = 0;
    h->maxts.tv_sec = 0;
    h->maxts.tv_usec = 0;
    if (h->prev)
	histogram_clear(h->prev);
    h->prev = NULL;
}

void histogram_add(struct histogram *to, struct histogram *from) {
    int ix;
    for (ix=0; ix < to->bincount; ix ++) {
	to->mybins[ix] += from->mybins[ix];
    }
}

void histogram_print(struct histogram *h, double start, double end) {
    if (h->final && h->prev) {
	histogram_clear(h->prev);
    }
    if (!h->prev) {
	h->prev = histogram_init(h->bincount, h->binwidth, h->offset, h->units, h->ci_lower, h->ci_upper, h->id, h->myname);
    }
    int n = 0, ix, delta, lowerci, upperci, outliercnt, fence_lower, fence_upper, upper3stdev;
    int running=0;
    int intervalpopulation, oob_u, oob_l;
    intervalpopulation = h->populationcnt - h->prev->populationcnt;
    strcpy(h->outbuf, h->myname);
    sprintf(h->outbuf, "[%3d] " IPERFTimeFrmt " sec %s%s%s bin(w=%d%s):cnt(%d)=", h->id, start, end, h->myname, (h->final ? "(f)" : ""), "-PDF:",h->binwidth, ((h->units == 1e3) ? "ms" : "us"), intervalpopulation);
    n = strlen(h->outbuf);
    lowerci=0;
    upperci=0;
    upper3stdev = 0;
    outliercnt=0;
    fence_lower = 0;
    fence_upper = 0;
    int outside3fences = 0;
    h->prev->populationcnt = h->populationcnt;
    oob_l = h->cntloweroutofbounds - h->prev->cntloweroutofbounds;
    h->prev->cntloweroutofbounds = h->cntloweroutofbounds;
    oob_u = h->cntupperoutofbounds - h->prev->cntupperoutofbounds;
    h->prev->cntupperoutofbounds = h->cntupperoutofbounds;

    for (ix = 0; ix < h->bincount; ix++) {
	delta = h->mybins[ix] - h->prev->mybins[ix];
	if (delta > 0) {
	    running+=delta;
	    if (!lowerci && ((float)running/intervalpopulation > h->ci_lower/100.0)) {
		lowerci = ix+1;
	    }
	    // use 10% and 90% for inner fence post, then 3 times for outlier
	    if ((float)running/intervalpopulation < 0.1) {
		fence_lower=ix+1;
	    }
	    if ((float)running/intervalpopulation < 0.9) {
		fence_upper=ix+1;
	    } else if (!outside3fences) {
		outside3fences = fence_upper + (3 * (fence_upper - fence_lower));
	    } else if (ix > outside3fences) {
		outliercnt += delta;
	    }
	    if (!upperci && ((float)running/intervalpopulation > h->ci_upper/100.0)) {
		upperci = ix+1;
	    }
	    if (!upper3stdev && ((float)running/intervalpopulation > 99.7/100.0)) {
		upper3stdev = ix+1;
	    }
	    n += sprintf(h->outbuf + n,"%d:%d,", ix+1, delta);
	    h->prev->mybins[ix] = h->mybins[ix];
	}
    }
    h->outbuf[strlen(h->outbuf)-1] = '\0';
    if (!upperci)
       upperci=h->bincount;
    if (!upper3stdev)
       upper3stdev=h->bincount;
    if (h->ci_upper > 99.7)
      fprintf(stdout, "%s (%.2f/99.7/%.2f/%%=%d/%d/%d,Outliers=%d,obl/obu=%d/%d)", \
	      h->outbuf, h->ci_lower, h->ci_upper, lowerci, upper3stdev, upperci, outliercnt, oob_l, oob_u);
    else
      fprintf(stdout, "%s (%.2f/%.2f/99.7%%=%d/%d/%d,Outliers=%d,obl/obu=%d/%d)", \
	      h->outbuf, h->ci_lower, h->ci_upper, lowerci, upperci, upper3stdev, outliercnt, oob_l, oob_u);
    if (!h->final && (h->maxval > 0) && ((h->maxts.tv_sec > 0) || h->maxts.tv_usec > 0)) {
	fprintf(stdout, " (%0.3f ms/%ld.%ld)\n", (h->maxval * 1e3), (long) h->maxts.tv_sec, (long) h->maxts.tv_usec);
      h->maxbin = -1;
      h->maxval = 0;
    } else if (h->final && (h->fmaxval > 0) && ((h->maxts.tv_sec > 0) || h->maxts.tv_usec > 0)) {
	fprintf(stdout, " (%0.3f ms/%ld.%ld)\n", (h->fmaxval * 1e3), (long) h->fmaxts.tv_sec, (long) h->fmaxts.tv_usec);
    } else {
      fprintf(stdout, "\n");
    }
}
