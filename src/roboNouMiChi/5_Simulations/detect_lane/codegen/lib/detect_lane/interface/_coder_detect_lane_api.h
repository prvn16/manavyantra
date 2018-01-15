/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_detect_lane_api.h
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
 */

#ifndef _CODER_DETECT_LANE_API_H
#define _CODER_DETECT_LANE_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_detect_lane_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void detect_lane(real32_T frame[154587], real_T laneCoeffMeans[6], real_T
  laneCoeffStds[6], boolean_T *laneFound, real32_T ltPts[56], real32_T rtPts[56]);
extern void detect_lane_api(const mxArray * const prhs[3], const mxArray *plhs[3]);
extern void detect_lane_atexit(void);
extern void detect_lane_initialize(void);
extern void detect_lane_terminate(void);
extern void detect_lane_xil_terminate(void);

#endif

/*
 * File trailer for _coder_detect_lane_api.h
 *
 * [EOF]
 */
