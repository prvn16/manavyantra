function [I] = manavyantra(inputArg1,inputArg2, inputArg3)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inputArg1;
outputArg2 = inputArg2;

rr = RoboNouMiChiClass(1,2);
I = rr.rangeFilter(true(3));
end

