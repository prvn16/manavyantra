//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: detect_lane_initialize.cu
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
//

// Include Files
#include "rt_nonfinite.h"
#include "detect_lane.h"
#include "detect_lane_initialize.h"

// Function Definitions

//
// Arguments    : void
// Return Type  : void
//
void detect_lane_initialize()
{
  rt_InitInfAndNaN(8U);
  detect_lane_init();
}

//
// File trailer for detect_lane_initialize.cu
//
// [EOF]
//
