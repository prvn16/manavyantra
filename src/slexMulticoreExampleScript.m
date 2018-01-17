%% Assigning Tasks to Cores for Multicore Programming
%
% This example shows how to take advantage of executing code on a multicore processor by graphical partitioning.
% This example requires Simulink Coder(TM) to generate multithreaded code.
                        
% Copyright 2015 The MathWorks, Inc.
                        
%% Introduction
%
% Multicore programming allows you to make use of the processing power of modern
% multicore processors to create high-performance applications.  Simulink(TM) allows
% you to take advantage of multicore programming by allowing you to graphically
% partition your algorithms and to assign the code generated from those
% partitions to parallel threads on your multicore processor.
%
% The parallel threads are typically scheduled by an operating system, assigning
% threads to cores dynamically.  This allows the scheduler to make good use
% of the cores while providing a notion of fairness.  However, in many 
% applications, you may need additional control on how the cores are used
% or you may want to dedicate a set of cores to specific logic, for example
% to improve determinism.  This level of control is achievable through 
% graphical partitioning and is illustrated in this example.
%


%% Try the Example
%
% A typical situation for multicore consists of a multi-rate model for which
% you want to assign code for the fast rates to one core and the code for the
% slower rates to other cores. This may allow you to add more logic to these
% faster rates or to achieve more determinism.  
% More generally, you may want to dedicate cores
% to application logic with the greatest demand on resources.  
% To begin, open the multicore project:
%
% <matlab:slexMulticoreExample slexMulticoreExample>
%
% <<slexMulticoreExample.png>>

%% Generate Multithreaded Code
%
% This application model is already partitioned into four concurrent tasks
% through the Concurrent Execution dialog which you may access from the 
% Solvers pane of the model's Configuration Parameters. Use this
% dialog to specify logic, task and core assignments. In this example, we
% have partitioned the application logic as:
%
% <<slexMulticoreExampleMapping.png>>
%
% Double-click on the 'Generate Code and Profile Report' button to generate
% multi-threaded code, and profile its execution. 
% This action runs and instruments the generated executable and produces
% both profiling results and a core occupancy map, the latter illustrated
% below.  The illustration shows how the cores were utilized at each
% time step of execution.  In this example, the first core was used for the
% fast rates (Task1 and Task2) and the second core was used for the slower rates
% (Task3 and Task4).
% 
% You may go back to the Concurrent Execution dialog to try out different
% core assignments.  In particular, you may try to specify no core affinity
% by leaving the 'Affinity' property as '[]'. This is the default setting
% which allows Simulink(TM) to generate multi-threaded code suitable for 
% dynamic scheduling on your multicore processor.
%
% <<slexMulticoreExampleProfile.png>>

displayEndOfDemoMessage(mfilename)
