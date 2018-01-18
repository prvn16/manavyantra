@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=mandelbrot_count_mex
set MEX_NAME=mandelbrot_count_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for mandelbrot_count > mandelbrot_count_mex.mki
echo COMPILER=%COMPILER%>> mandelbrot_count_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> mandelbrot_count_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> mandelbrot_count_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> mandelbrot_count_mex.mki
echo LINKER=%LINKER%>> mandelbrot_count_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> mandelbrot_count_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> mandelbrot_count_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> mandelbrot_count_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> mandelbrot_count_mex.mki
echo BORLAND=%BORLAND%>> mandelbrot_count_mex.mki
echo NVCC=nvcc >> mandelbrot_count_mex.mki
echo CUDA_FLAGS= -c -rdc=true -Xcompiler "/wd 4819" -Xcudafe "--diag_suppress=unsigned_compare_with_zero --diag_suppress=useless_type_qualifier_on_return_type" -D_GNU_SOURCE -DMATLAB_MEX_FILE >> mandelbrot_count_mex.mki
echo LD=nvcc >> mandelbrot_count_mex.mki
echo MAPLIBS=libemlrt.lib,libcovrt.lib,libut.lib,libmwmathutil.lib,/export:mexFunction,/export:emlrtMexFcnProperties,/export:mandelbrot_count,/export:mandelbrot_count_initialize,/export:mandelbrot_count_terminate,/export:mandelbrot_count_atexit >> mandelbrot_count_mex.mki
echo OMPFLAGS= >> mandelbrot_count_mex.mki
echo OMPLINKFLAGS= >> mandelbrot_count_mex.mki
echo EMC_COMPILER=msvc140>> mandelbrot_count_mex.mki
echo EMC_CONFIG=optim>> mandelbrot_count_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f mandelbrot_count_mex.mk
