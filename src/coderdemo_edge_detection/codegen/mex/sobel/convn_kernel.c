/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * convn_kernel.c
 *
 * Code generation for function 'convn_kernel'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "sobel.h"
#include "convn_kernel.h"
#include "blas.h"

/* Function Definitions */
void eml_conv2(emxArray_real_T *C, const emxArray_real_T *A, const real_T B[9],
               int32_T lastRowC, int32_T lastColC, boolean_T AContainsNonFinites)
{
  int32_T ma;
  int32_T na;
  int32_T firstColB;
  int32_T lastColB;
  int32_T firstRowB;
  int32_T lastRowB;
  int32_T lastColA;
  int32_T k;
  int32_T b_firstColB;
  int32_T iC;
  int32_T iA;
  int32_T iB;
  int32_T i;
  int32_T firstRowA;
  int32_T b_i;
  int32_T a_length;
  real_T BiB;
  boolean_T b2;
  int32_T cidx;
  int32_T r;
  ptrdiff_t n_t;
  ptrdiff_t incx_t;
  ptrdiff_t incy_t;
  ma = A->size[0];
  na = A->size[1] - 1;
  if (A->size[1] < 1) {
    firstColB = 2;
  } else {
    firstColB = 0;
  }

  if (3 <= lastColC) {
    lastColB = 2;
  } else {
    lastColB = lastColC;
  }

  if (A->size[0] < 1) {
    firstRowB = 2;
  } else {
    firstRowB = 0;
  }

  if (3 <= lastRowC) {
    lastRowB = 2;
  } else {
    lastRowB = lastRowC;
  }

  while (firstColB <= lastColB) {
    if (firstColB + na < lastColC) {
      lastColA = na;
    } else {
      lastColA = lastColC - firstColB;
    }

    for (k = (firstColB < 1); k <= lastColA; k++) {
      if (firstColB + k > 1) {
        b_firstColB = (firstColB + k) - 1;
      } else {
        b_firstColB = 0;
      }

      iC = b_firstColB * lastRowC;
      iA = k * ma;
      iB = firstRowB + firstColB * 3;
      for (i = firstRowB; i <= lastRowB; i++) {
        firstRowA = (i < 1);
        if (i + ma <= lastRowC) {
          b_i = ma;
        } else {
          b_i = (lastRowC - i) + 1;
        }

        a_length = b_i - firstRowA;
        BiB = B[iB];
        if ((B[iB] == 0.0) && AContainsNonFinites) {
          b2 = true;
        } else {
          b2 = false;
        }

        if ((!b2) && (a_length >= 32)) {
          n_t = (ptrdiff_t)a_length;
          incx_t = (ptrdiff_t)1;
          incy_t = (ptrdiff_t)1;
          daxpy(&n_t, &BiB, &A->data[iA + firstRowA], &incx_t, &C->data[iC],
                &incy_t);
        } else {
          firstRowA += iA;
          cidx = iC;
          for (r = 1; r <= a_length; r++) {
            C->data[cidx] += BiB * A->data[firstRowA];
            firstRowA++;
            cidx++;
          }
        }

        iB++;
        if (i >= 1) {
          iC++;
        }
      }
    }

    firstColB++;
  }
}

/* End of code generation (convn_kernel.c) */
