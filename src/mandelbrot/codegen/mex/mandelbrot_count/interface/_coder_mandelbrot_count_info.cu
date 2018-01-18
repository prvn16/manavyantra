/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_mandelbrot_count_info.cu
 *
 * Code generation for function '_coder_mandelbrot_count_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "_coder_mandelbrot_count_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("mandelbrot_count"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.3.0.713579 (R2017b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[25] = {
    "789ced5d5d6ce35815ceccce2e3b8c160c0b2cab5dd8d9151a012335cddf2499172649d3fcf427bf6d93544bebd88ee3d67fb11d27a978e80b681f07de9040bc"
    "22d06a4120ed207828120ffb8c0442bb2fbc20f1c80b3ce3c4b96decc96d32b5e3d4ee3d52e5b8a7b9dff5e9b9dfb93ef7fad8772bb775cbe7f37d41fb191e3f",
    "f8876f24afe9071f363edef619c5acbf353e7ecb740ee465df1dc3f780fe67e32321f00ad557f41396e1a9ed2ed7a424ed84c739eabc1952e0181ee795ea40a4"
    "7c12250bac4a91234d8b61a92ac3519bc2c44996d14eb8f509d5f9c95035fc9c6a53c471a5cbf9a4b67cd15d76f2c437619fa790ebbf33a77dfc10fb6026fd7e",
    "fafdd463bfd62fb12bf17e5922fc1cce9314db940465e2e30121747965853befdfe104fead89765f99d2bf49fd2dc811c85ddfab93bd7d02f0fa90f6a6d9631a"
    "de97207898494f71ec01a768ff37f9a04db1e2c8338632ebba67f5c32cb07e000178cfae8807daafccc003fafddc666de40a4549a0259cbb3ff459d9bf95a86e",
    "2692fe727035106dfa1541609b42dfaf19c9cf324dcd3f14166ffa0551f63f6737cd5726afe310d24f1bfde50ffffdf46f0967fdd3d1eb5b2a9ed5f1f735081e"
    "66d2938d011e6e12786d2d8c274e8474953baa8beb17fd28cec099d50f1fe4dca9f63f817c7f5e3be290f631937e01e3f95d42e038813f2086910c842d705d22",
    "a4dff3fae36dd33990bba6eb1bc969e589fea17a1e1f4e21edcf6bd77720f898494f08a4660b469b44483cceae3072b2cbb04a8ed7a61194c41096e304c07fc5"
    "747ed11f5d430add264bd917276a33ae1fe85fd8af863f0f4756f33f0466f39bcdb6c239c76ba71fa338e1fe3851503ba9442babc6aaa5f08048737c70bdc166",
    "bd132726e7ff57b1a337e6fff76d9bffbf0ec1c34c7a9ddf69b1bb72ac5115c5b6bafce8f76e9dffefcec003fafddcfcb42eb7718922fd3aa98fa97d7cd00ce7"
    "3f37dcf016c0417ff9a972efef88d71784e714afd3d9e36643598d3673d108931e64e9c05e2e9ef20eafa3f13cfd08c4e07fa7ebb6f1ff1b103ccca4bfe07f9a",
    "52326237cde3da3c9b5c1aff9f5d110fb4df988107f436fa8bc170e33490937ec3ff248ae280dbe34061bb24e7cbb560b81ba9f613bc28767a858287f240687e"
    "3f94ef3eb1caaba0fd972078d8588337f58cd5b2f233bfb4889781e219f556f27ea320efd72ce5a81f9c9eed3c40f918b7f375a7d9245b61b159a8162b524908",
    "6432ec6638e91dbe46e3d728b03ccd29a43d94879f0f0fe5e1bdc9c34ee3a13cbc3ded23de378ad1df566de3fd37217898496fe27d99c0595c5a01b37bf7e6e9"
    "17b64f672aef3fd4ed36f699c9eb3884f4d346defff1678f11efbb9df78f2299124d967673f1f5ed407cb7598ad0ada287f2f488f78d02e3fd0f20edcd6ba7f7",
    "207898496fe27d5c14d941654462eb5d9e5018415fa69db91f69de7e7d7146bf80be35463f68e33ca9dd08d895b7df9f810ff4f6c48329e6747eff66ef1ecadb"
    "bb3e2e248ab4c287fb91aa488ae5dc66496a6c37a21e8a0b6790efa3716d14a31fe66cbb4ff806040f33e94df1a22b53455c6a09524ae0e5e1d31f76e587ee98",
    "ce2ffaa36b88363e7a84c0f9f57f3bfcc7683667d7ff4f2bfb8f503c707b3c187438315e8be7d9f02ed32e51c96c5f55eb6bde8907683c4f3f0231fa5fccb638"
    "f016040f33e94d71403b65787a5d9032c59d91deadf9a2ea0c3ca0b7c76f26cda64f201c8c03bf6ba038e0fa38d00e45e938dd4b2b5465b75be42274b1982c78",
    "e8be008de7e9472046ff5b41fb3aaf8807da47fb3a178e37929b8287f675dad3fe19e4fb283f6414a31f6edb765ff04d081e66d20f9f6fd6cc70a0dd0bb18220"
    "1e082a25b558a1a73fddbcbcfb82b32be281f60f4de7663ca0b7b4eea4bbd325f673741fd19ffef5328a0b6e8f0bf246ba9f5e3b3929e6fbc1f0567035554a04",
    "56d3de890bff867c7f5e3bfe08d23e66d22f7a5cbf7bf91f9c17cd71d65f33b63d47302b9fcfc8ad61ad27dbc6c78bddbf5cec77e549aa9fe315dbf62baccfe8"
    "07d05fc9bf5a4c9f224541ebbd7f683f87f38ecfd03e53f7c787ca4064b848a7bc17609a6438d72815b702aa87d611d0f8350a6cbf9108696f5e3bbd06c1c34c",
    "7a46e6f52df1cab002e0f2d68b7f6311af00c533eaadfbc584bd9cdd8ff6e1de9b88dfddceef99d0f1a0d2a11936554d1d973b49ba7abc93f610bfa3f9ff22fd"
    "3567dbfc7fd6f35edaa57378dfbdf1200fc533eaaded4bd63ef8754b39bf4e70faec8dbb281fe4f678207556c523460e27b847c5285f6cd6421bbbb2879e2746",
    "f16081fe7aea6c3c6078140fe68b070cbf8478f047140fdc1f0f68bc1e2d84f6b63bd166424945f042980a9732de89076790efa37563a31879debe75e3ebf2fc"
    "f1bc71c7eeba13e8f9636ff2b3d378e8f9637bda47e379fa1188d1ff22b6ed279dd7ff4c71a04fb2b838082e8fffafed3ac1547f199bcbd97582fd4f11efbb9e",
    "f7652210daa9b59aa93815ab16a35263578d573db47ff429e4fb37ab2ee8c57a2f0ccfaebaa0ac408f8ecbe26df7d419d12ce5ac1ffc19d505753f5fafe59241"
    "72af9d106abd6831410f5663c2d19e87f23668fc1ac5e86fdfb62d3ff336040f33e99fab0bba267038c3a7254930e4cd458bfdb15a1fc8eafdddce0c7ca0b7ab",
    "4ee884194777780efad1cfff9944f9fbeb1a07be0ac1c34c7a766bab990e8452911e4310695954db757ac3e79d3880c6f3f42310a3ff3db26d7effaae91c0836"
    "d630b22ce2924cb9352fb30dc533eaadcc0f86161ace1080ad1caef3f30be27f689e7f5df97dde797e842d677bc2562c13dac9d2512275922fe72a1edaaf83e6",
    "f94681bdc7c5aabf7d05828799f4a6793e659edf1f5aec87d375dd1652f7ff92820ee753014a9f0238c8f72ffdf5019acfbb9deff96abd8407ebd9464855bbe9"
    "9a1a087179c643ebaf88ef8d723debfe83ecbd7bebb82d679d5ef799c9eb3884f4d346bff9c1efef23de773befc74b787c95ea6e6c77ca3bd9584f3ce6b976c8",
    "43cf6921de370a8cf79f42da9bd74edf81e06126fdecbaff39bec8e20435fefbeb92dfffc4227e73063ed02f6c3fefd8ac4ba8f396fa6104c509b7c789cdfc06"
    "51ef14e389fa56589283221354a3790fc50934beadf8e3c57e4d181ecaffeb82f2ff76e3e97253f050fedf9ef611df5bf1c7a86df922f4fe17189e51effef745",
    "a0f7bf2c120fbdffc59ef6515cb0e28ff6bd0f06d57dbe1c0fe851dd6777f2b5d378a8eeb33deda3f860c51fe39e5b6706f837a3be035a67f61a1e5a67b6a77d"
    "349ea71f8118fdef6ddbd60b3e07c1c3c61a89c2d96181cf65e587acae176c40f18c7aebf5dcc69672be7ecfe7bf8eeab9b99edf4f32bbf9607b2d5ced9602bd",
    "2033d8da896cb63db45e80c6f1f4fe1bfdeef139af8b90f6e6b5d73d081e66d20ff31780e387e2d6758017795ea068cd414489517185f24f98cec93c8fef2354"
    "dfdffd7ccf56b6e9d57a3914a846764f54b2908fb57abc87eaf6a0f13cfd08c4e87ff7979dd769b102ae6c69bf63c77ab7c6813214cfa8b7e73ef0c26c4ba8e3",
    "fc2b1407dc1f07d458281ca5f21b85d65a5c6944f1f2668ae1b2280e80f6505ee76a769bb50f949348466548d7ee0375a24ebf20ca7e60a795f10d9983fef0e1"
    "67ef7b3aaff3db65c62fa7eafcf4eb8d469a4e305227ac72e948b59e281de13eeff03b1ac7d3fb6ff4bbff7ccfb17cbd7e994b5b97b5ea0f39289e516fd51f80",
    "3b8ca7ed4ecedb7ffd5609cddbddceebb15ea9b5530b3f8a6655b61c5f8bc536851dc28778fdba8c6358fe7c5ebfbb0de9ff5dd375e8f2de13fdf8c0b63cce3b"
    "107ccca47faebe67b2cbb04a8edfd6df3eebdafd390ba9ff7349fd3fa3d91cddb7f9317a1ffbf58d07f3e6710a6a27956865d558b5141e10698e0fae37580fe5",
    "71dc1e0f0e21fd5b54ddb753487bf3daeb3e040f33e9a7eccfa4fa624ae0445c6134465e16ff9f59c4ab43f18c7a7bf8ff39b32dc37fbeff97d73d9def592a9e"
    "5371a04d8a52a3769226e8e8da667410eae289520cede3b96171e0621f8f55bffb32040f33e94d7140bb7afdf76ecd032d6cbfd754fed7cce5fc7a0fe2fb05e2",
    "39f61ede6472404643e974a31f54b31b5566ad2e953d30efff3f32d7c569", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 55456U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_mandelbrot_count_info.cu) */
