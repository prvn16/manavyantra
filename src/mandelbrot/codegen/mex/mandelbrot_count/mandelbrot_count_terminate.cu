/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mandelbrot_count_terminate.cu
 *
 * Code generation for function 'mandelbrot_count_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "mandelbrot_count_terminate.h"
#include "_coder_mandelbrot_count_mex.h"
#include "mandelbrot_count_data.h"

/* Function Definitions */
void mandelbrot_count_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void mandelbrot_count_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (mandelbrot_count_terminate.cu) */
