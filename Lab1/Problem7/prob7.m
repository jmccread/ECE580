% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab 1, Problem 7
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% June 2018; Last revision: 03-June-2018

set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');
%% 7. Generate a sampled sinusoid with the following data:
%  Signal frequency = 0.25 kHz,
%  Sampling frequency = 16 kHz,
%  Inial phase = 45 degrees,
%  Starting time = 0 sec.,
%  Amplitude = 10,
%  Ending time = 10 msec
dT = 1/(16*1000);
t = 0:dT:10e-3;
n = 1:size(t,2);
x = 10*sin(2*pi*0.25*1000*t+pi/4);

fig = figure(1);
subplot(2,1,1)
plot(t*1000, x, 'LineWidth', 2);
ax = gca;
ax.XLabel.String = 'Time (mS)'; 
ax.YLabel.String = '10sin(2\pi25000t + \pi/4)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 7', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n,x, 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = '10sin(2\pi25000t + \pi/4)'; 
ax.YLabel.FontSize = 14; 
axis([min(n), 161, -10, 10])
saveas(fig, 'Prob7', 'png');

