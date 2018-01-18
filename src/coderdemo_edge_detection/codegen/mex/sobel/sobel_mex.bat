@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=sobel_mex
set MEX_NAME=sobel_mex
set MEX_EXT=.mexw64
call "C:\PROGRA~1\MATLAB\R2017b\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for sobel > sobel_mex.mki
echo COMPILER=%COMPILER%>> sobel_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> sobel_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> sobel_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> sobel_mex.mki
echo LINKER=%LINKER%>> sobel_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> sobel_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> sobel_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> sobel_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> sobel_mex.mki
echo OMPFLAGS= >> sobel_mex.mki
echo OMPLINKFLAGS= >> sobel_mex.mki
echo EMC_COMPILER=lcc64>> sobel_mex.mki
echo EMC_CONFIG=optim>> sobel_mex.mki
"C:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f sobel_mex.mk
