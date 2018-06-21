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
% # initialize
% # Define variables
% # Create Signals
% # Create plot
% 
%*****************************************************************
%initialize
clear vars
clc
close all

%define variables
n = [-5:10]';
a = [4 -10];
b = 1;
x = zeros(size(n));
x(n>=0) = 1;
y = zeros(size(n));
y(5) = 4;
y(4) = -10;

%create signals

ind_n = find(n==0) - 3;
lenx = length(x);

for i=ind_n:lenx
       
    ys(i) = 0.3.*y(i-1) + 0.4.*y(i-2) + x(i) + 0.75.*x(i-1) -2.5.*x(i-2);
end

%create plot
fig = figure(1);

stem(n(1:end), ys(1:end), 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'x(n) = u(n) (no units)'; 
ax.XLabel.FontSize = 10; 
ax.YLabel.FontSize = 10; 
ax.YLabel.String = 'y(n) = 0.3y(n-1)+0:4y(n-2)+x(n)+0.75x(n-1)-2.5x(n-2)(no units)';
title('Lab Assignment 2, Problem 2 : Difference Equation', 'FontSize', 16, 'FontWeight', 'bold');

saveas(fig, 'Prob12', 'png');
