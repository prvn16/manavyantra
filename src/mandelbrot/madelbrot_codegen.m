% GPU code generation for getting started example (mandelbrot_count.m)
%% Create configuration object of class 'coder.MexCodeConfig'.
% cfg = coder.config('mex');
% cfg.GenerateReport = true;
% cfg.GpuConfig.CompilerFlags = '--fmad=false';
cfg = coder.gpuConfig('mex');
cfg.GpuConfig.CompilerFlags = '--fmad=false';
cfg.GenerateReport = true;

%% Define argument types for entry-point 'mandelbrot_count'.
ARGS = cell(1,1);
ARGS{1} = cell(3,1);
ARGS{1}{1} = coder.typeof(0);
ARGS{1}{2} = coder.typeof(0,[1000 1000]);
ARGS{1}{3} = coder.typeof(0,[1000 1000]);

%% Invoke GPU Coder.
% codegen -config cfg mandelbrot_count -args ARGS{1}
codegen -config cfg RoboNouMiChiClass.rangeFilter -args ARGS{1}