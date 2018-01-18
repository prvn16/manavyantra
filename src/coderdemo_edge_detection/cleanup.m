if isempty(currentFigures), currentFigures = []; end;
close(setdiff(findall(0, 'type', 'figure'), currentFigures))
clear mex
delete *.mexw64
[~,~,~] = rmdir('C:\Sumpurn\src\coderdemo_edge_detection\codegen','s');
clear C:\Sumpurn\src\coderdemo_edge_detection\sobel.m
delete C:\Sumpurn\src\coderdemo_edge_detection\sobel.m
delete C:\Sumpurn\src\coderdemo_edge_detection\hello.jpg
clear
load old_workspace
delete old_workspace.mat
delete C:\Sumpurn\src\coderdemo_edge_detection\cleanup.m
cd C:\Sumpurn\src
rmdir('C:\Sumpurn\src\coderdemo_edge_detection','s');
