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
 * pdfs.c
 * Produce probability distribution functions, expected to be used
 * for iperf client traffic emulations
 *
 * Implements the Polar form of the Box-Muller Transformation
 *
 * by Robert J. McMahon (rjmcmahon@rjmcmahon.com, bob.mcmahon@broadcom.com)
 * & Tim Auckland
 * -------------------------------------------------------------------
 */
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include "headers.h"
#include "pdfs.h"

#define FALSE 0
#define TRUE 1
float box_muller(void) {
    float x1, x2, w, y1;
    static float y2;
    static int generate = FALSE;
    /* Each iteration produces two values, if one exists use the value from previous call */
    generate = !generate;
    if (!generate) {
	y1 = y2;
    } else {
	int loopcontrol=100;
	do {
	    x1 = 2.0 * (float)rand()/(float)(RAND_MAX) - 1.0;
	    x2 = 2.0 * (float)rand()/(float)(RAND_MAX) - 1.0;
	    w = x1 * x1 + x2 * x2;
	} while ( w >= 1.0 && --loopcontrol > 0);
	if (w >= 1.0) {
	    fprintf(stderr, "pdf box_muller() rand() error\n");
	    return 0;
	} else {
	    w = sqrt( (-2.0 * logf( w ) ) / w );
	    y1 = x1 * w;
	    y2 = x2 * w;
	}
    }
    return(y1);
}

float normal(float mean, float variance) {
    return (box_muller() * variance + mean);
}

float lognormal(float mu, float sigma) {
    float phi = sqrtf((mu * mu) + (sigma * sigma));
    float mu_prime = logf(((mu * mu)/phi));
    float sigma_prime = sqrtf(logf((phi * phi)/(mu * mu)));
    return (expf(normal(mu_prime,sigma_prime)));
}
