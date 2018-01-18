/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: sobel.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 24-Dec-2017 01:17:22
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "sobel.h"
#include "sobel_emxutil.h"
#include "sqrt.h"
#include "conv2.h"

/* Function Definitions */

/*
 * Arguments    : const emxArray_real_T *originalImage
 *                double threshold
 *                emxArray_uint8_T *edgeImage
 * Return Type  : void
 */
void sobel(const emxArray_real_T *originalImage, double threshold,
           emxArray_uint8_T *edgeImage)
{
  emxArray_real_T *H;
  emxArray_real_T *V;
  int b_H;
  int c_H;
  emxInit_real_T(&H, 2);
  emxInit_real_T(&V, 2);

  /*  edgeImage = sobel(originalImage, threshold) */
  /*  Sobel edge detection. Given a normalized image (with double values) */
  /*  return an image where the edges are detected w.r.t. threshold value. */
  conv2(originalImage, H);
  b_conv2(originalImage, V);
  b_H = H->size[0] * H->size[1];
  emxEnsureCapacity_real_T(H, b_H);
  b_H = H->size[0];
  c_H = H->size[1];
  c_H *= b_H;
  for (b_H = 0; b_H < c_H; b_H++) {
    H->data[b_H] = H->data[b_H] * H->data[b_H] + V->data[b_H] * V->data[b_H];
  }

  emxFree_real_T(&V);
  b_sqrt(H);
  b_H = edgeImage->size[0] * edgeImage->size[1];
  edgeImage->size[0] = H->size[0];
  edgeImage->size[1] = H->size[1];
  emxEnsureCapacity_uint8_T(edgeImage, b_H);
  c_H = H->size[0] * H->size[1];
  for (b_H = 0; b_H < c_H; b_H++) {
    edgeImage->data[b_H] = (unsigned char)((H->data[b_H] > threshold) * 255U);
  }

  emxFree_real_T(&H);
}

/*
 * File trailer for sobel.c
 *
 * [EOF]
 */
