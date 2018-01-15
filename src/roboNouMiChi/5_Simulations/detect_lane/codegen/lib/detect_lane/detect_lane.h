//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: detect_lane.h
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
//
#ifndef DETECT_LANE_H
#define DETECT_LANE_H

// Include Files
#include <cmath>
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "detect_lane_types.h"

// Function Declarations
extern void detect_lane(const real32_T frame[154587], const real_T
  laneCoeffMeans[6], const real_T laneCoeffStds[6], boolean_T *laneFound,
  real32_T ltPts[56], real32_T rtPts[56]);
extern void detect_lane_init();

#endif

//
// File trailer for detect_lane.h
//
// [EOF]
//
