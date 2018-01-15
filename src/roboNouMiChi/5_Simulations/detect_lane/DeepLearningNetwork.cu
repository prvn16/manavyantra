//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: DeepLearningNetwork.cu
//
// GPU Coder version                    : 1.0
// CUDA/C/C++ source code generated on  : 07-Jan-2018 02:03:56
//

// Include Files
#include "rt_nonfinite.h"
#include "detect_lane.h"
#include "DeepLearningNetwork.h"

// Type Definitions
#include "cnn_api.hpp"

// Function Declarations
static __global__ void c_DeepLearningNetwork_predict_k(const real32_T *inputdata,
  real32_T *inputT);
static __global__ void d_DeepLearningNetwork_predict_k(real32_T *out, real32_T
  *outT);

// Function Definitions

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                const real32_T *inputdata
//                real32_T *inputT
// Return Type  : void
//
static __global__ __launch_bounds__(512, 1) void c_DeepLearningNetwork_predict_k
  (const real32_T *inputdata, real32_T *inputT)
{
  uint32_T threadId;
  int32_T i1;
  int32_T i2;
  int32_T p;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  p = (int32_T)(threadId / 51529U);
  i2 = (int32_T)((threadId - (uint32_T)p * 51529U) / 227U);
  i1 = (int32_T)((threadId - (uint32_T)i2 * 227U) - (uint32_T)p * 51529U);
  if (((int32_T)((!(int32_T)(i1 >= 227)) && (!(int32_T)(i2 >= 227)))) &&
      (!(int32_T)(p >= 3))) {
    inputT[(i1 + 227 * i2) + 51529 * p] = inputdata[(i2 + 227 * i1) + 51529 * p];
  }
}

//
// Arguments    : MWCNNLayer *this
// Return Type  : void
//

//
// Arguments    : MWConvLayer *this
//                MWCNNLayer *previousLayer
//                int32_T FilterSizeH
//                int32_T FilterSizeW
//                int32_T NumChannels
//                int32_T NumFilters
//                int32_T StrideH
//                int32_T StrideW
//                int32_T PaddingH
//                int32_T PaddingW
//                int32_T NumGroups
// Return Type  : void
//

//
// Arguments    : MWFCLayer *this
//                MWCNNLayer *previousLayer
//                int32_T InputSize
//                int32_T OutputSize
// Return Type  : void
//

//
// Arguments    : MWInputLayer *this
//                int32_T n
//                int32_T h
//                int32_T w
//                int32_T c
//                boolean_T withAvg
// Return Type  : void
//

//
// Arguments    : MWMaxPoolingLayer *this
//                MWCNNLayer *previousLayer
//                int32_T PoolSizeH
//                int32_T PoolSizeW
//                int32_T StrideH
//                int32_T StrideW
//                int32_T PaddingH
//                int32_T PaddingW
// Return Type  : void
//

//
// Arguments    : MWNormLayer *this
//                MWCNNLayer *previousLayer
//                int32_T WindowSize
//                real_T Alpha
//                real_T Beta
//                real_T K
// Return Type  : void
//

//
// Arguments    : MWOutputLayer *this
//                MWCNNLayer *previousLayer
// Return Type  : void
//

//
// Arguments    : MWPassthroughLayer *this
//                MWCNNLayer *previousLayer
// Return Type  : void
//

//
// Arguments    : MWReLULayer *this
//                MWCNNLayer *previousLayer
// Return Type  : void
//

//
// Arguments    : MWCNNLayer *this
//                real32_T **handle
// Return Type  : void
//

//
// Arguments    : uint3 blockArg
//                uint3 gridArg
//                real32_T *out
//                real32_T *outT
// Return Type  : void
//
static __global__ __launch_bounds__(32, 1) void d_DeepLearningNetwork_predict_k
  (real32_T *out, real32_T *outT)
{
  int32_T i1;
  ;
  ;
  i1 = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                    + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                   threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                  blockDim.x) + threadIdx.x);
  if (!(int32_T)(i1 >= 6)) {
    outT[i1] = out[i1];
  }
}

//
// Arguments    : MWCNNLayer *this
// Return Type  : void
//

//
// Arguments    : MWInputLayer *this
//                const char * fileName
// Return Type  : void
//

//
// Arguments    : MWConvLayer *this
//                const char * fileName
// Return Type  : void
//

//
// Arguments    : MWFCLayer *this
//                const char * fileName
// Return Type  : void
//

//
// Arguments    : MWFCLayer *this
//                const char * fileName
// Return Type  : void
//

//
// Arguments    : MWConvLayer *this
//                const char * fileName
// Return Type  : void
//

//
// Arguments    : MWCNNLayer *this
// Return Type  : void
//

//
// Arguments    : MWCNNLayer *this
//                cublasHandle_t *handle
// Return Type  : void
//

//
// Arguments    : MWCNNLayer *this
//                cudnnHandle_t *handle
// Return Type  : void
//

//
// Arguments    : MWCNNLayer *this
//                real32_T *handle
// Return Type  : void
//

//
// Arguments    : c_lanenet *obj
//                const real32_T inputdata[154587]
//                real32_T outT[6]
// Return Type  : void
//
void DeepLearningNetwork_predict(c_lanenet *obj, const real32_T inputdata[154587],
  real32_T outT[6])
{
  real32_T *gpu_inputT;
  real32_T *gpu_out;
  real32_T *gpu_inputdata;
  real32_T *gpu_outT;
  cudaMalloc(&gpu_outT, 24ULL);
  cudaMalloc(&gpu_out, 24ULL);
  cudaMalloc(&gpu_inputT, 618348ULL);
  cudaMalloc(&gpu_inputdata, 618348ULL);
  cudaMemcpy((void *)gpu_inputdata, (void *)&inputdata[0], 618348ULL,
             cudaMemcpyHostToDevice);
  c_DeepLearningNetwork_predict_k<<<dim3(302U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_inputdata, gpu_inputT);
  cudaMemcpy(obj->inputData, gpu_inputT, 154587ULL * sizeof(real32_T),
             cudaMemcpyDeviceToDevice);
  obj->predict();
  cudaMemcpy(gpu_out, obj->outputData, 6ULL * sizeof(real32_T),
             cudaMemcpyDeviceToDevice);
  d_DeepLearningNetwork_predict_k<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
    (gpu_out, gpu_outT);
  cudaMemcpy((void *)&outT[0], (void *)gpu_outT, 24ULL, cudaMemcpyDeviceToHost);
  cudaFree(gpu_inputdata);
  cudaFree(gpu_inputT);
  cudaFree(gpu_out);
  cudaFree(gpu_outT);
}

//
// Arguments    : c_lanenet *obj
// Return Type  : void
//
void DeepLearningNetwork_setup(c_lanenet *obj)
{
  obj->setup();
  obj->batchSize = 1;
}

//
// Arguments    : c_lanenet *this
// Return Type  : void
//
void c_lanenet::cleanup()
{
  int32_T idx;
  for (idx = 0; idx < 23; idx++) {
    this->layers[idx]->cleanup();
  }

  if (this->workSpace) {
    cudaFree(this->workSpace);
  }

  if (this->cublasHandle) {
    cublasDestroy(*this->cublasHandle);
  }

  if (this->cudnnHandle) {
    cudnnDestroy(*this->cudnnHandle);
  }
}

//
// Arguments    : c_lanenet *this
// Return Type  : void
//
c_lanenet::c_lanenet()
{
  this->numLayers = 23;
  this->cublasHandle = 0;
  this->cudnnHandle = 0;
  this->workSpace = 0;
  this->layers[0] = new MWInputLayer;
  this->layers[1] = new MWConvLayer;
  this->layers[2] = new MWReLULayer;
  this->layers[3] = new MWNormLayer;
  this->layers[4] = new MWMaxPoolingLayer;
  this->layers[5] = new MWConvLayer;
  this->layers[6] = new MWReLULayer;
  this->layers[7] = new MWNormLayer;
  this->layers[8] = new MWMaxPoolingLayer;
  this->layers[9] = new MWConvLayer;
  this->layers[10] = new MWReLULayer;
  this->layers[11] = new MWConvLayer;
  this->layers[12] = new MWReLULayer;
  this->layers[13] = new MWConvLayer;
  this->layers[14] = new MWReLULayer;
  this->layers[15] = new MWMaxPoolingLayer;
  this->layers[16] = new MWFCLayer;
  this->layers[17] = new MWReLULayer;
  this->layers[18] = new MWPassthroughLayer;
  this->layers[19] = new MWFCLayer;
  this->layers[20] = new MWReLULayer;
  this->layers[21] = new MWFCLayer;
  this->layers[22] = new MWOutputLayer;
}

//
// Arguments    : c_lanenet *this
// Return Type  : void
//
c_lanenet::~c_lanenet()
{
  int32_T idx;
  this->cleanup();
  for (idx = 0; idx < 23; idx++) {
    delete this->layers[idx];
  }
}

//
// Arguments    : c_lanenet *this
// Return Type  : void
//
void c_lanenet::predict()
{
  int32_T idx;
  for (idx = 0; idx < 23; idx++) {
    this->layers[idx]->predict();
  }
}

//
// Arguments    : c_lanenet *this
// Return Type  : void
//
void c_lanenet::setup()
{
  int32_T idx_handles;
  int32_T idx_ws;
  this->cublasHandle = new cublasHandle_t;
  cublasCreate(this->cublasHandle);
  this->cudnnHandle = new cudnnHandle_t;
  cudnnCreate(this->cudnnHandle);
  for (idx_handles = 0; idx_handles < 23; idx_handles++) {
    this->layers[idx_handles]->setCublasHandle(this->cublasHandle);
    this->layers[idx_handles]->setCudnnHandle(this->cudnnHandle);
  }

  this->layers[0]->createInputLayer(1, 227, 227, 3, 1);
  this->layers[0]->loadAvg("./codegen/lib/detect_lane/cnn_lanenet_avg");
  this->layers[1]->createConvLayer(this->layers[0], 11, 11, 3, 96, 4, 4, 0, 0, 1);
  this->layers[1]->loadWeights(
    "./codegen/lib/detect_lane/cnn_lanenet_conv1_w");
  this->layers[1]->loadBias("./codegen/lib/detect_lane/cnn_lanenet_conv1_b");
  this->layers[2]->createReLULayer(this->layers[1]);
  this->layers[3]->createNormLayer(this->layers[2], 5, 0.0001, 0.75, 1.0);
  this->layers[4]->createMaxPoolingLayer(this->layers[3], 3, 3, 2, 2, 0, 0);
  this->layers[5]->createConvLayer(this->layers[4], 5, 5, 48, 128, 1, 1, 2, 2, 2);
  this->layers[5]->loadWeights(
    "./codegen/lib/detect_lane/cnn_lanenet_conv2_w");
  this->layers[5]->loadBias("./codegen/lib/detect_lane/cnn_lanenet_conv2_b");
  this->layers[6]->createReLULayer(this->layers[5]);
  this->layers[7]->createNormLayer(this->layers[6], 5, 0.0001, 0.75, 1.0);
  this->layers[8]->createMaxPoolingLayer(this->layers[7], 3, 3, 2, 2, 0, 0);
  this->layers[9]->createConvLayer(this->layers[8], 3, 3, 256, 384, 1, 1, 1, 1,
    1);
  this->layers[9]->loadWeights(
    "./codegen/lib/detect_lane/cnn_lanenet_conv3_w");
  this->layers[9]->loadBias("./codegen/lib/detect_lane/cnn_lanenet_conv3_b");
  this->layers[10]->createReLULayer(this->layers[9]);
  this->layers[11]->createConvLayer(this->layers[10], 3, 3, 192, 192, 1, 1, 1, 1,
    2);
  this->layers[11]->loadWeights(
    "./codegen/lib/detect_lane/cnn_lanenet_conv4_w");
  this->layers[11]->loadBias("./codegen/lib/detect_lane/cnn_lanenet_conv4_b");
  this->layers[12]->createReLULayer(this->layers[11]);
  this->layers[13]->createConvLayer(this->layers[12], 3, 3, 192, 128, 1, 1, 1, 1,
    2);
  this->layers[13]->loadWeights(
    "./codegen/lib/detect_lane/cnn_lanenet_conv5_w");
  this->layers[13]->loadBias("./codegen/lib/detect_lane/cnn_lanenet_conv5_b");
  this->layers[14]->createReLULayer(this->layers[13]);
  this->layers[15]->createMaxPoolingLayer(this->layers[14], 3, 3, 2, 2, 0, 0);
  this->layers[16]->createFCLayer(this->layers[15], 9216, 4096);
  this->layers[16]->loadWeights(
    "./codegen/lib/detect_lane/cnn_lanenet_fc6_w");
  this->layers[16]->loadBias("./codegen/lib/detect_lane/cnn_lanenet_fc6_b");
  this->layers[17]->createReLULayer(this->layers[16]);
  this->layers[18]->createPassthroughLayer(this->layers[17]);
  this->layers[19]->createFCLayer(this->layers[18], 4096, 16);
  this->layers[19]->loadWeights(
    "./codegen/lib/detect_lane/cnn_lanenet_fcLane1_w");
  this->layers[19]->loadBias(
    "./codegen/lib/detect_lane/cnn_lanenet_fcLane1_b");
  this->layers[20]->createReLULayer(this->layers[19]);
  this->layers[21]->createFCLayer(this->layers[20], 16, 6);
  this->layers[21]->loadWeights(
    "./codegen/lib/detect_lane/cnn_lanenet_fcLane2_w");
  this->layers[21]->loadBias(
    "./codegen/lib/detect_lane/cnn_lanenet_fcLane2_b");
  this->layers[22]->createOutputLayer(this->layers[21]);
  this->layers[22]->createWorkSpace((&this->workSpace));
  for (idx_ws = 0; idx_ws < 23; idx_ws++) {
    this->layers[idx_ws]->setWorkSpace(this->workSpace);
  }

  this->inputData = this->layers[0]->getData();
  this->outputData = this->layers[22]->getData();
}

//
// File trailer for DeepLearningNetwork.cu
//
// [EOF]
//
