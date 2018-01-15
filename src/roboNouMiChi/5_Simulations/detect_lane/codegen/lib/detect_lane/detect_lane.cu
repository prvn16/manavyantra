//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: detect_lane.cu
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
//

// Include Files
#include "rt_nonfinite.h"
#include "detect_lane.h"
#include "DeepLearningNetwork.h"

// Variable Definitions
static c_lanenet b_lanenet;
static boolean_T lanenet_not_empty;

// Function Definitions

//
// From the networks output,
//  compute left and right lane points in the image coordinates
//  The camera coordinates are described by the caltech mono camera model.
// Arguments    : const real32_T frame[154587]
//                const real_T laneCoeffMeans[6]
//                const real_T laneCoeffStds[6]
//                boolean_T *laneFound
//                real32_T ltPts[56]
//                real32_T rtPts[56]
// Return Type  : void
//
void detect_lane(const real32_T frame[154587], const real_T laneCoeffMeans[6],
                 const real_T laneCoeffStds[6], boolean_T *laneFound, real32_T
                 ltPts[56], real32_T rtPts[56])
{
  uint8_T outsz[3];
  static real32_T b[154587];
  int32_T iwork[3];
  int32_T i0;
  int32_T k;
  int32_T inc[3];
  static const int8_T iv0[3] = { 1, 0, 2 };

  int32_T idest;
  int32_T isrc;
  real32_T lanecoeffsNetworkOutput[6];
  real32_T rt_y[28];
  real32_T lt_y[28];
  real32_T X[84];
  real32_T varargin_1[56];
  real32_T U[84];
  static const real32_T fv0[9] = { 309.430603F, -309.436188F, 168.170944F,
    166.611893F, -1.02020358E-14F, 863.843445F, 0.970295727F, -5.94134783E-17F,
    0.527341366F };

  int32_T initAuxVar;
  int32_T exitg1;

  // METHOD1 Summary of this method goes here
  //    Detailed explanation goes here
  if (!lanenet_not_empty) {
    DeepLearningNetwork_setup(&b_lanenet);
    lanenet_not_empty = true;
  }

  outsz[0] = 227;
  outsz[1] = 227;
  outsz[2] = 3;
  for (i0 = 0; i0 < 3; i0++) {
    iwork[i0] = 1;
  }

  for (k = 0; k < 2; k++) {
    iwork[k + 1] = iwork[k] * 227;
  }

  for (i0 = 0; i0 < 3; i0++) {
    inc[i0] = iwork[iv0[i0]];
  }

  for (i0 = 0; i0 < 3; i0++) {
    iwork[i0] = 0;
  }

  idest = 0;
  do {
    isrc = 0;
    for (k = 0; k < 2; k++) {
      isrc += iwork[k + 1] * inc[k + 1];
    }

    initAuxVar = idest;
    for (k = 0; k < 227; k++) {
      idest = initAuxVar + k;
      b[idest] = frame[isrc];
      idest++;
      isrc += inc[0];
    }

    k = 1;
    do {
      exitg1 = 0;
      iwork[k]++;
      if (iwork[k] < outsz[k]) {
        exitg1 = 2;
      } else if (k + 1 == 3) {
        exitg1 = 1;
      } else {
        iwork[1] = 0;
        k = 2;
      }
    } while (exitg1 == 0);
  } while (!(exitg1 == 1));

  DeepLearningNetwork_predict(&b_lanenet, b, lanecoeffsNetworkOutput);

  //  Recover original coeffs by reversing the normalization steps
  for (i0 = 0; i0 < 6; i0++) {
    lanecoeffsNetworkOutput[i0] = lanecoeffsNetworkOutput[i0] * (real32_T)
      laneCoeffStds[i0] + (real32_T)laneCoeffMeans[i0];
  }

  // c should be more than 0.5 for it to be a right lane
  // meters, ahead of the sensor
  if ((std::abs(lanecoeffsNetworkOutput[5]) > 0.5F) && (std::abs
       (lanecoeffsNetworkOutput[2]) > 6.5F)) {
    for (i0 = 0; i0 < 28; i0++) {
      rt_y[i0] = lanecoeffsNetworkOutput[3];
    }

    for (k = 0; k < 2; k++) {
      for (i0 = 0; i0 < 28; i0++) {
        rt_y[i0] = (3.0F + (real32_T)i0) * rt_y[i0] + lanecoeffsNetworkOutput[k
          + 4];
      }
    }

    for (i0 = 0; i0 < 28; i0++) {
      lt_y[i0] = lanecoeffsNetworkOutput[0];
    }

    for (k = 0; k < 2; k++) {
      for (i0 = 0; i0 < 28; i0++) {
        lt_y[i0] = (3.0F + (real32_T)i0) * lt_y[i0] + lanecoeffsNetworkOutput[k
          + 1];
      }
    }

    //  Visualize lane boundaries of the ego vehicle
    //  map vehicle to image coordinates
    for (idest = 0; idest < 28; idest++) {
      varargin_1[idest] = 3.0F + (real32_T)idest;
      varargin_1[28 + idest] = lt_y[idest];
      X[56 + idest] = 1.0F;
    }

    for (isrc = 0; isrc < 2; isrc++) {
      for (idest = 0; idest < 28; idest++) {
        X[idest + 28 * isrc] = varargin_1[idest + 28 * isrc];
      }
    }

    for (i0 = 0; i0 < 28; i0++) {
      for (idest = 0; idest < 3; idest++) {
        U[i0 + 28 * idest] = 0.0F;
        for (isrc = 0; isrc < 3; isrc++) {
          U[i0 + 28 * idest] += X[i0 + 28 * isrc] * fv0[isrc + 3 * idest];
        }
      }
    }

    for (idest = 0; idest < 2; idest++) {
      isrc = idest * 28;
      for (k = 0; k < 28; k++) {
        varargin_1[isrc + k] = U[56 + k];
      }
    }

    for (i0 = 0; i0 < 2; i0++) {
      for (idest = 0; idest < 28; idest++) {
        U[idest + 28 * i0] /= varargin_1[idest + 28 * i0];
        ltPts[idest + 28 * i0] = U[idest + 28 * i0];
      }
    }

    for (idest = 0; idest < 28; idest++) {
      varargin_1[idest] = 3.0F + (real32_T)idest;
      varargin_1[28 + idest] = rt_y[idest];
      X[56 + idest] = 1.0F;
    }

    for (isrc = 0; isrc < 2; isrc++) {
      for (idest = 0; idest < 28; idest++) {
        X[idest + 28 * isrc] = varargin_1[idest + 28 * isrc];
      }
    }

    for (i0 = 0; i0 < 28; i0++) {
      for (idest = 0; idest < 3; idest++) {
        U[i0 + 28 * idest] = 0.0F;
        for (isrc = 0; isrc < 3; isrc++) {
          U[i0 + 28 * idest] += X[i0 + 28 * isrc] * fv0[isrc + 3 * idest];
        }
      }
    }

    for (idest = 0; idest < 2; idest++) {
      isrc = idest * 28;
      for (k = 0; k < 28; k++) {
        varargin_1[isrc + k] = U[56 + k];
      }
    }

    for (i0 = 0; i0 < 2; i0++) {
      for (idest = 0; idest < 28; idest++) {
        U[idest + 28 * i0] /= varargin_1[idest + 28 * i0];
        rtPts[idest + 28 * i0] = U[idest + 28 * i0];
      }
    }

    *laneFound = true;
  } else {
    *laneFound = false;
  }
}

//
// Arguments    : void
// Return Type  : void
//
void detect_lane_init()
{
  lanenet_not_empty = false;
}

//
// File trailer for detect_lane.cu
//
// [EOF]
//
