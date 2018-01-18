/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mandelbrot_count_initialize.cu
 *
 * Code generation for function 'mandelbrot_count_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "mandelbrot_count_initialize.h"
#include "_coder_mandelbrot_count_mex.h"
#include "mandelbrot_count_data.h"

/* Function Definitions */
void mandelbrot_count_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (mandelbrot_count_initialize.cu) */
