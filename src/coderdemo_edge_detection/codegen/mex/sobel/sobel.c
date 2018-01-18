/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sobel.c
 *
 * Code generation for function 'sobel'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "sobel.h"
#include "sobel_emxutil.h"
#include "sqrt.h"
#include "conv2.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 10,    /* lineNo */
  "sobel",                             /* fcnName */
  "C:\\Sumpurn\\src\\coderdemo_edge_detection\\sobel.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 11,  /* lineNo */
  "sobel",                             /* fcnName */
  "C:\\Sumpurn\\src\\coderdemo_edge_detection\\sobel.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 12,  /* lineNo */
  "sobel",                             /* fcnName */
  "C:\\Sumpurn\\src\\coderdemo_edge_detection\\sobel.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 4,   /* lineNo */
  22,                                  /* colNo */
  "sobel",                             /* fName */
  "C:\\Sumpurn\\src\\coderdemo_edge_detection\\sobel.m"/* pName */
};

static emlrtRTEInfo b_emlrtRTEI = { 10,/* lineNo */
  1,                                   /* colNo */
  "sobel",                             /* fName */
  "C:\\Sumpurn\\src\\coderdemo_edge_detection\\sobel.m"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 11,/* lineNo */
  1,                                   /* colNo */
  "sobel",                             /* fName */
  "C:\\Sumpurn\\src\\coderdemo_edge_detection\\sobel.m"/* pName */
};

static emlrtECInfo emlrtECI = { 2,     /* nDims */
  12,                                  /* lineNo */
  10,                                  /* colNo */
  "sobel",                             /* fName */
  "C:\\Sumpurn\\src\\coderdemo_edge_detection\\sobel.m"/* pName */
};

/* Function Definitions */
void sobel(const emlrtStack *sp, const emxArray_real_T *originalImage, real_T
           threshold, emxArray_uint8_T *edgeImage)
{
  emxArray_real_T *H;
  emxArray_real_T *V;
  int32_T b_H;
  int32_T c_H;
  int32_T d_H[2];
  int32_T b_V[2];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &H, 2, &b_emlrtRTEI, true);
  emxInit_real_T(sp, &V, 2, &c_emlrtRTEI, true);

  /*  edgeImage = sobel(originalImage, threshold) */
  /*  Sobel edge detection. Given a normalized image (with double values) */
  /*  return an image where the edges are detected w.r.t. threshold value. */
  st.site = &emlrtRSI;
  conv2(&st, originalImage, H);
  st.site = &b_emlrtRSI;
  b_conv2(&st, originalImage, V);
  b_H = H->size[0] * H->size[1];
  emxEnsureCapacity_real_T(sp, H, b_H, &emlrtRTEI);
  b_H = H->size[0];
  c_H = H->size[1];
  c_H *= b_H;
  for (b_H = 0; b_H < c_H; b_H++) {
    H->data[b_H] *= H->data[b_H];
  }

  b_H = V->size[0] * V->size[1];
  emxEnsureCapacity_real_T(sp, V, b_H, &emlrtRTEI);
  b_H = V->size[0];
  c_H = V->size[1];
  c_H *= b_H;
  for (b_H = 0; b_H < c_H; b_H++) {
    V->data[b_H] *= V->data[b_H];
  }

  for (b_H = 0; b_H < 2; b_H++) {
    d_H[b_H] = H->size[b_H];
  }

  for (b_H = 0; b_H < 2; b_H++) {
    b_V[b_H] = V->size[b_H];
  }

  if ((d_H[0] != b_V[0]) || (d_H[1] != b_V[1])) {
    emlrtSizeEqCheckNDR2012b(&d_H[0], &b_V[0], &emlrtECI, sp);
  }

  b_H = H->size[0] * H->size[1];
  emxEnsureCapacity_real_T(sp, H, b_H, &emlrtRTEI);
  b_H = H->size[0];
  c_H = H->size[1];
  c_H *= b_H;
  for (b_H = 0; b_H < c_H; b_H++) {
    H->data[b_H] += V->data[b_H];
  }

  emxFree_real_T(&V);
  st.site = &c_emlrtRSI;
  b_sqrt(&st, H);
  b_H = edgeImage->size[0] * edgeImage->size[1];
  edgeImage->size[0] = H->size[0];
  edgeImage->size[1] = H->size[1];
  emxEnsureCapacity_uint8_T(sp, edgeImage, b_H, &emlrtRTEI);
  c_H = H->size[0] * H->size[1];
  for (b_H = 0; b_H < c_H; b_H++) {
    edgeImage->data[b_H] = (uint8_T)((H->data[b_H] > threshold) * 255U);
  }

  emxFree_real_T(&H);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (sobel.c) */
