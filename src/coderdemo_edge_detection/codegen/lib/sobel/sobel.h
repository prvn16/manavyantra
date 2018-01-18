/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: sobel.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 24-Dec-2017 01:17:22
 */

#ifndef SOBEL_H
#define SOBEL_H

/* Include Files */
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rtwtypes.h"
#include "sobel_types.h"

/* Function Declarations */
extern void sobel(const emxArray_real_T *originalImage, double threshold,
                  emxArray_uint8_T *edgeImage);

#endif

/*
 * File trailer for sobel.h
 *
 * [EOF]
 */
