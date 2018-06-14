% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab 1, Problem 9
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% June 2018; Last revision: 03-June-2018

%% 7. Consider the following discrete-time exponential signal x(n) = 75(-0:95)^n*u(n -? 3).
set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');
u = @(n) n >= 0; % Step starting from 0, operating on n
%% (a) Plot x(n) over the range n = 0; 1; 2; : : : ; 20.
n = 0:20; 
x = 75*(-0.95).^n.*u(n-3);
fig = figure(1);
stem(n, x, 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'Sample n'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'x(n) = 75(-0.95)^n u(n-3))'; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 9', 'FontSize', 16, 'FontWeight', 'bold');
saveas(fig, 'Prob9', 'png');

%% (b) Find the sum of the sequence for the above range. Hence, verify the result using the closed form.
sum(x)

%% (d) Find the energy of x(n)
sum(abs(x).^2)
