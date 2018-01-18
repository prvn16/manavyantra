/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * convn_kernel.h
 *
 * Code generation for function 'convn_kernel'
 *
 */

#ifndef CONVN_KERNEL_H
#define CONVN_KERNEL_H

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
extern void eml_conv2(emxArray_real_T *C, const emxArray_real_T *A, const real_T
                      B[9], int32_T lastRowC, int32_T lastColC, boolean_T
                      AContainsNonFinites);

#endif

/* End of code generation (convn_kernel.h) */
