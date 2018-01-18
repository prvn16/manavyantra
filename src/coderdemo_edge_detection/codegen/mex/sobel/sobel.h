/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sobel.h
 *
 * Code generation for function 'sobel'
 *
 */

#ifndef SOBEL_H
#define SOBEL_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "sobel_types.h"

/* Function Declarations */
extern void sobel(const emlrtStack *sp, const emxArray_real_T *originalImage,
                  real_T threshold, emxArray_uint8_T *edgeImage);

#endif

/* End of code generation (sobel.h) */
