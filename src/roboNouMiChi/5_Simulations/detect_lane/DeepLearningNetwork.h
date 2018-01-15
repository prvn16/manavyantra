//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: DeepLearningNetwork.h
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
//
#ifndef DEEPLEARNINGNETWORK_H
#define DEEPLEARNINGNETWORK_H

// Include Files
#include <cmath>
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "detect_lane_types.h"

// Type Definitions
#include "cnn_api.hpp"

// Function Declarations
extern void DeepLearningNetwork_predict(c_lanenet *obj, const real32_T
  inputdata[154587], real32_T outT[6]);
extern void DeepLearningNetwork_setup(c_lanenet *obj);

#endif

//
// File trailer for DeepLearningNetwork.h
//
// [EOF]
//
