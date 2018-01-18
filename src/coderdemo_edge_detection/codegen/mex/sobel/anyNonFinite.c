/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * anyNonFinite.c
 *
 * Code generation for function 'anyNonFinite'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "sobel.h"
#include "anyNonFinite.h"

/* Function Definitions */
boolean_T anyNonFinite(const emxArray_real_T *x)
{
  boolean_T p;
  int32_T nx;
  int32_T k;
  nx = x->size[0] * x->size[1];
  p = true;
  for (k = 0; k + 1 <= nx; k++) {
    if (p && ((!muDoubleScalarIsInf(x->data[k])) && (!muDoubleScalarIsNaN
          (x->data[k])))) {
      p = true;
    } else {
      p = false;
    }
  }

  return !p;
}

/* End of code generation (anyNonFinite.c) */
