% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 3, Problem 1
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% Month Year; Last revision: 12-July-2018
set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');

%% Table of Contents 
% 
% # Create Signals
% # (a) Plot the sequence for L = 7
% # (b) Find the Fourier TF of the sequence, Y(ejw), find expressions for
% magnitude and phase
% # (c) Plots of magnitude and phase responses, Determination of delta w.
% # (d) Sketch of the signal y(n) * y(n-9)
% # (e) Plot the magnitude and phase spectra of z(n) 
% 
close all
clear all

%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
ramp =@(n) n.*(n>=0); %Ramp starting from 0 

%% Part (a) Plot the sequence y(n) = 4(u(n)u(-(n+L)sin(n\pi +\pi/6)
L = 7; 
n = -2:9; 
y = 4*u(n).*u(-n+L).*sin(n*pi + pi/6); % Create y signal
y_alt = 2*(cos(n*pi).*u(n) - u(n-8).*cos((n-8)*pi)); 

fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
stem(n, y, 'LineWidth', 2);
hold on;
stem(n, y_alt, 'LineWidth', 1);
ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)'; 
ax.YLabel.FontSize = 14; 
title('y(n) = 4[u(n)u(-n+L)]sin(n\pi + \pi/6)');
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob1a', 'png');

