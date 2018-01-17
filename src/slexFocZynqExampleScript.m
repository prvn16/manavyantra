%% Multicore Programming of a Field-Oriented Control on Zynq
%
% This example demonstrates how to implement a control algorithm containing
% multiple rates on Zynq. To take advantage of both the cores and the FPGA
% hardware, the example uses graphical partitioning approach such that code
% from different partitions are distributed across the cores and the
% hardware.
%
% Copyright 2015 The MathWorks, Inc.

%% Introduction
% In this example, we show a workflow for generating code for a motor
% control algorithm, and testing the generated code on a Xilinx(R) 
% Zynq(TM)-7000 SoC ZC702 evaluation board. Motor control algorithm in the
% example is a Field-Oriented Control algorithm composed of a speed controller (fast component) and a torque
% controller (slow component). One typical workflow is to
% generate code for these two components of the controller, upload the generated
% code to an evaluation board and connect the evaluation board to a real-world motor.
% The purpose of this example is to show how to follow this workflow. This is illustrated
% in the block diagram below 
%
% <<slexFocZynqWorkflow1.png>>
%
% In order for this example to be self-contained and since there is redundant 
% computer power on the target processor, we model the motor using one of the 
% tasks of the CPU of the evaluation board.
%
% <<slexFocZynqWorkflow2.png>>
%
% The example assumes that a Xilinx(R) Zynq(TM)-7000 SoC ZC702 evaluation 
% board is connected to your computer. You can find the connection and installation steps in the 
% <matlab:web(fullfile(docroot,'hdlcoder/examples/getting-started-with-hardware-software-codesign-workflow-for-xilinx-zynq-platform.html')) documentation>
% .
%
% This example requires Embedded Coder(TM) to generate 
% multi-threaded code, HDL Coder (TM) to generate HDL code and Simscape(TM) 
% to model the permanent magnet synchronous machine in the example. You
% cannot generate HDL code on Macintosh systems.

%% Example Model
%
% The example model consists of two Simulink areas. In the Permanent Magnet  
% Synchronous Machine area, there are two blocks: "Speed and Torque Inputs"
% block which provides the reference inputs to the feedback system, and
% "Invertor and Motor" block which is the plant we aim to control in this example.
% The "Invertor and Motor" block also contains peripherals: a scope that can be
% used for investigating the simulation results and a UDP sender. The generated 
% code for the UDP sender is responsible for sending the simulation data from the
% Zynq ZC702 evaluation board to the host machine. The Field-Oriented
% Control contains the controller blocks "Speed controller" and
% "Torque controller". Load the model by typing

slexFocZynqExample

%% Architecture Definition
% 
% The target architecture in the example is Xilinx Zynq ZC702 evaluation
% kit. This can be verified by accessing the "Concurrent Execution" dialog
% box following the steps:
%
% - Go to Simulation>Model Configuration Parameters,
%
% - Click "Configure Tasks" at the Solver pane, under the Additional
% Options section.
%
% <<slexFocZynqTargetArch.png>>
%
% The evaluation board has an ARM Cortex-A9 CPU and a field-programmable gate array (FPGA).
% There are two tasks running on the ARM CPU. "Torque controller" is mapped
% to the first task and the blocks that constitute the plant ("Speed and Torque Inputs" block and "Invertor and
% Motor") are mapped to the second task. "Speed controller" operating at high 
% frequency in the control loop is mapped to the FPGA. These 
% settings can be changed in the "Tasks and Mapping" section of the "Concurrent
% Execution" dialog box.
%
% <<slexFocZynqMapBlockToTask.png>>

%% Generate Multi-threaded and HDL Code
%
% Press Ctrl-B or click on "Deploy to Hardware" to generate the
% multi-threaded and HDL code. The generated executable and the FPGA
% bitstream will be uploaded to Zynq board automatically. In order to perform 
% this step, Zynq board should be connected to the computer and the
% environment should be set properly. You can consult to the
% <matlab:web(fullfile(docroot,'hdlcoder/examples/getting-started-with-hardware-software-codesign-workflow-for-xilinx-zynq-platform.html')) documentation>
% for additional information.

%% Receive Data from the Zynq
%
% First, open the scope by double-clicking
% "View Simulation Results", and run the simulation (Simulation>Run) to obtain the
% following output:
%
% <<slexFocZynqOutput1.png>>
%
% Compare this simulation output with the output of the executable that 
% runs on the Zynq ZC702 board. In order to make this comparison, access the UDP receiver model by double-clicking on the "View Deployment Results". 
% When the UDP receiver model is selected, run the simulation
% (Simulation>Run). The run command will send a signal to the Zynq ZC702
% board to start running the executable on the board. The simulation data will be
% sent via UDP from the Zynq ZC702 board to the host machine. The captured 
% UDP signal is displayed on the scope of the UDP Receiver model.
%
% <<slexFocZynqOutput2.png>>
%
%% Close the Model
close_system('slexFocZynqExample', 0);

displayEndOfDemoMessage(mfilename)
