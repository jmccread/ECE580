% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 2, Problem 1
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% Month Year; Last revision: 21-June-2018

%% Table of Contents 
% 
% # Define variables
% # Create Signals
% # Filter Coeffiecent Setup
% # Part (a) x(n) = delta(n) 
% # Part (b) x(n) = u(n-3) 
% # Part (c) x(n) = u(n)u(-n+23)
% # Part (d) ramp(n)-ramp(n-23)
% 
%*****************************************************************
%define variables
n = [-5:30]';
a = [4 -10];
b = 1;
x = zeros(size(n));
x(n>=0) = 1;
y = zeros(size(n));
y(5) = 4;
y(4) = -10;

%create signals

ind_n = find(n==0);
lenx = length(x);

for i=ind_n:lenx
       
    ys(i) = 0.3.*y(i-1) + 0.4.*y(i-2) + x(i) + 0.75.*x(i-1) -2.5.*x(i-2);
end

stem(n,ys)
