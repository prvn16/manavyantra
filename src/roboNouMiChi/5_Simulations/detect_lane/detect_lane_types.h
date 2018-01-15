//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: detect_lane_types.h
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
//
#ifndef DETECT_LANE_TYPES_H
#define DETECT_LANE_TYPES_H

// Include Files
#include "rtwtypes.h"

// Type Definitions
#include "cnn_api.hpp"

class c_lanenet
{
 public:
  int32_T batchSize;
  int32_T numLayers;
  real32_T *inputData;
  real32_T *outputData;
  MWCNNLayer *layers[23];
 private:
  cublasHandle_t *cublasHandle;
  cudnnHandle_t *cudnnHandle;
  uint32_T workSpaceSize;
  real32_T *workSpace;
 public:
  c_lanenet();
  void setup();
  void predict();
  void cleanup();
  ~c_lanenet();
};

#endif

//
// File trailer for detect_lane_types.h
//
// [EOF]
//
