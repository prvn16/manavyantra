/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * conv2.c
 *
 * Code generation for function 'conv2'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "sobel.h"
#include "conv2.h"
#include "convn_kernel.h"
#include "sobel_emxutil.h"
#include "anyNonFinite.h"

/* Variable Definitions */
static emlrtRSInfo d_emlrtRSI = { 41,  /* lineNo */
  "conv2",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\datafun\\conv2.m"/* pathName */
};

static emlrtRTEInfo d_emlrtRTEI = { 1, /* lineNo */
  14,                                  /* colNo */
  "conv2",                             /* fName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\datafun\\conv2.m"/* pName */
};

/* Function Definitions */
void b_conv2(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *c)
{
  int32_T a_idx_0;
  int32_T loop_ub;
  boolean_T b1;
  static const real_T B[9] = { 1.0, 2.0, 1.0, 0.0, 0.0, 0.0, -1.0, -2.0, -1.0 };

  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &d_emlrtRSI;
  a_idx_0 = c->size[0] * c->size[1];
  c->size[0] = a->size[0];
  c->size[1] = a->size[1];
  emxEnsureCapacity_real_T(&st, c, a_idx_0, &d_emlrtRTEI);
  loop_ub = a->size[0] * a->size[1];
  for (a_idx_0 = 0; a_idx_0 < loop_ub; a_idx_0++) {
    c->data[a_idx_0] = 0.0;
  }

  b1 = ((a->size[0] == 0) || (a->size[1] == 0));
  if (!b1) {
    a_idx_0 = a->size[0];
    loop_ub = a->size[1];
    eml_conv2(c, a, B, a_idx_0, loop_ub, anyNonFinite(a));
  }
}

void conv2(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *c)
{
  int32_T a_idx_0;
  int32_T loop_ub;
  boolean_T b0;
  static const real_T dv0[9] = { 1.0, 0.0, -1.0, 2.0, 0.0, -2.0, 1.0, 0.0, -1.0
  };

  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &d_emlrtRSI;
  a_idx_0 = c->size[0] * c->size[1];
  c->size[0] = a->size[0];
  c->size[1] = a->size[1];
  emxEnsureCapacity_real_T(&st, c, a_idx_0, &d_emlrtRTEI);
  loop_ub = a->size[0] * a->size[1];
  for (a_idx_0 = 0; a_idx_0 < loop_ub; a_idx_0++) {
    c->data[a_idx_0] = 0.0;
  }

  b0 = ((a->size[0] == 0) || (a->size[1] == 0));
  if (!b0) {
    a_idx_0 = a->size[0];
    loop_ub = a->size[1];
    eml_conv2(c, a, dv0, a_idx_0, loop_ub, anyNonFinite(a));
  }
}

/* End of code generation (conv2.c) */
