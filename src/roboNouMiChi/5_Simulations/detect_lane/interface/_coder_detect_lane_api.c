/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_detect_lane_api.c
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
 */

/* Include Files */
#include "tmwtypes.h"
#include "_coder_detect_lane_api.h"
#include "_coder_detect_lane_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131451U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "detect_lane",                       /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 2045744189U, 2170104910U, 2743257031U, 4284093946U },/* fSigWrd */
  NULL                                 /* fSigMem */
};

/* Function Declarations */
static real32_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[154587];
static const mxArray *b_emlrt_marshallOut(const real32_T u[56]);
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *laneCoeffMeans, const char_T *identifier))[6];
static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[6];
static real32_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[154587];
static real32_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *frame,
  const char_T *identifier))[154587];
static const mxArray *emlrt_marshallOut(const boolean_T u);
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[6];

/* Function Definitions */

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real32_T (*)[154587]
 */
static real32_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[154587]
{
  real32_T (*y)[154587];
  y = e_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
/*
 * Arguments    : const real32_T u[56]
 * Return Type  : const mxArray *
 */
  static const mxArray *b_emlrt_marshallOut(const real32_T u[56])
{
  const mxArray *y;
  const mxArray *m1;
  static const int32_T iv0[2] = { 0, 0 };

  static const int32_T iv1[2] = { 28, 2 };

  y = NULL;
  m1 = emlrtCreateNumericArray(2, iv0, mxSINGLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m1, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m1, *(int32_T (*)[2])&iv1[0], 2);
  emlrtAssign(&y, m1);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *laneCoeffMeans
 *                const char_T *identifier
 * Return Type  : real_T (*)[6]
 */
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *laneCoeffMeans, const char_T *identifier))[6]
{
  real_T (*y)[6];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(laneCoeffMeans), &thisId);
  emlrtDestroyArray(&laneCoeffMeans);
  return y;
}
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T (*)[6]
 */
  static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[6]
{
  real_T (*y)[6];
  y = f_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real32_T (*)[154587]
 */
static real32_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[154587]
{
  real32_T (*ret)[154587];
  static const int32_T dims[3] = { 227, 227, 3 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "single", false, 3U, dims);
  ret = (real32_T (*)[154587])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *frame
 *                const char_T *identifier
 * Return Type  : real32_T (*)[154587]
 */
  static real32_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *frame,
  const char_T *identifier))[154587]
{
  real32_T (*y)[154587];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(frame), &thisId);
  emlrtDestroyArray(&frame);
  return y;
}

/*
 * Arguments    : const boolean_T u
 * Return Type  : const mxArray *
 */
static const mxArray *emlrt_marshallOut(const boolean_T u)
{
  const mxArray *y;
  const mxArray *m0;
  y = NULL;
  m0 = emlrtCreateLogicalScalar(u);
  emlrtAssign(&y, m0);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T (*)[6]
 */
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[6]
{
  real_T (*ret)[6];
  static const int32_T dims[2] = { 1, 6 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[6])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
/*
 * Arguments    : const mxArray * const prhs[3]
 *                const mxArray *plhs[3]
 * Return Type  : void
 */
  void detect_lane_api(const mxArray * const prhs[3], const mxArray *plhs[3])
{
  real32_T (*ltPts)[56];
  real32_T (*rtPts)[56];
  real32_T (*frame)[154587];
  real_T (*laneCoeffMeans)[6];
  real_T (*laneCoeffStds)[6];
  boolean_T laneFound;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  ltPts = (real32_T (*)[56])mxMalloc(sizeof(real32_T [56]));
  rtPts = (real32_T (*)[56])mxMalloc(sizeof(real32_T [56]));

  /* Marshall function inputs */
  frame = emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[0]), "frame");
  laneCoeffMeans = c_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[1]),
    "laneCoeffMeans");
  laneCoeffStds = c_emlrt_marshallIn(&st, emlrtAlias((const mxArray *)prhs[2]),
    "laneCoeffStds");

  /* Invoke the target function */
  detect_lane(*frame, *laneCoeffMeans, *laneCoeffStds, &laneFound, *ltPts,
              *rtPts);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(laneFound);
  plhs[1] = b_emlrt_marshallOut(*ltPts);
  plhs[2] = b_emlrt_marshallOut(*rtPts);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void detect_lane_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  detect_lane_xil_terminate();
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void detect_lane_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void detect_lane_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * File trailer for _coder_detect_lane_api.c
 *
 * [EOF]
 */
