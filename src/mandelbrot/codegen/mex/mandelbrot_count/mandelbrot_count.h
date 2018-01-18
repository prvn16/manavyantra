/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mandelbrot_count.h
 *
 * Code generation for function 'mandelbrot_count'
 *
 */

#ifndef MANDELBROT_COUNT_H
#define MANDELBROT_COUNT_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "mandelbrot_count_types.h"

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void mandelbrot_count(real_T maxIterations, const real_T xGrid[1000000],
    const real_T yGrid[1000000], real_T count[1000000]);

#ifdef __cplusplus

}
#endif
#endif

/* End of code generation (mandelbrot_count.h) */
