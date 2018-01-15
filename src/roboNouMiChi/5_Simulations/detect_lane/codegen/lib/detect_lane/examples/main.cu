//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: main.cu
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
//

//***********************************************************************
// This automatically generated example C main file shows how to call
// entry-point functions that MATLAB Coder generated. You must customize
// this file for your application. Do not modify this file directly.
// Instead, make a copy of this file, modify it, and integrate it into
// your development environment.
//
// This file initializes entry-point function arguments to a default
// size and value before calling the entry-point functions. It does
// not store or use any values returned from the entry-point functions.
// If necessary, it does pre-allocate memory for returned values.
// You can use this file as a starting point for a main function that
// you can deploy in your application.
//
// After you copy the file, and before you deploy it, you must make the
// following changes:
// * For variable-size function arguments, change the example sizes to
// the sizes that your application requires.
// * Change the example values of function arguments to the values that
// your application requires.
// * If the entry-point functions return values, store these values or
// otherwise use them as required by your application.
//
//***********************************************************************
// Include Files
#include "rt_nonfinite.h"
#include "detect_lane.h"
#include "main.h"
#include "detect_lane_terminate.h"
#include "detect_lane_initialize.h"

// Function Declarations
static void argInit_1x6_real_T(real_T result[6]);
static void argInit_227x227x3_real32_T(real32_T result[154587]);
static real32_T argInit_real32_T();
static real_T argInit_real_T();
static void main_detect_lane();

// Function Definitions

//
// Arguments    : real_T result[6]
// Return Type  : void
//
static void argInit_1x6_real_T(real_T result[6])
{
  int32_T idx1;

  // Loop over the array to initialize each element.
  for (idx1 = 0; idx1 < 6; idx1++) {
    // Set the value of the array element.
    // Change this value to the value that the application requires.
    result[idx1] = argInit_real_T();
  }
}

//
// Arguments    : real32_T result[154587]
// Return Type  : void
//
static void argInit_227x227x3_real32_T(real32_T result[154587])
{
  int32_T idx0;
  int32_T idx1;
  int32_T idx2;

  // Loop over the array to initialize each element.
  for (idx0 = 0; idx0 < 227; idx0++) {
    for (idx1 = 0; idx1 < 227; idx1++) {
      for (idx2 = 0; idx2 < 3; idx2++) {
        // Set the value of the array element.
        // Change this value to the value that the application requires.
        result[(idx0 + 227 * idx1) + 51529 * idx2] = argInit_real32_T();
      }
    }
  }
}

//
// Arguments    : void
// Return Type  : real32_T
//
static real32_T argInit_real32_T()
{
  return 0.0F;
}

//
// Arguments    : void
// Return Type  : real_T
//
static real_T argInit_real_T()
{
  return 0.0;
}

//
// Arguments    : void
// Return Type  : void
//
static void main_detect_lane()
{
  boolean_T laneFound;
  real32_T ltPts[56];
  real32_T rtPts[56];
  static real32_T b[154587];
  real_T c[6];
  real_T d[6];

  // Initialize function 'detect_lane' input arguments.
  // Initialize function input argument 'frame'.
  // Initialize function input argument 'laneCoeffMeans'.
  // Initialize function input argument 'laneCoeffStds'.
  // Call the entry-point 'detect_lane'.
  argInit_227x227x3_real32_T(b);
  argInit_1x6_real_T(c);
  argInit_1x6_real_T(d);
  detect_lane(b, c, d, &laneFound, ltPts, rtPts);
}

//
// Arguments    : int32_T argc
//                const char * const argv[]
// Return Type  : int32_T
//
int32_T main(int32_T, const char * const [])
{
  // Initialize the application.
  // You do not need to do this more than one time.
  detect_lane_initialize();

  // Invoke the entry-point functions.
  // You can call entry-point functions multiple times.
  main_detect_lane();

  // Terminate the application.
  // You do not need to do this more than one time.
  detect_lane_terminate();
  return 0;
}

//
// File trailer for main.cu
//
// [EOF]
//
