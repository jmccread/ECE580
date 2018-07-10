% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 3, Problem 5
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
% # Find and Plot the Frequency Response of the Composite system
% # Find and Plot the Group Delay 
% 
close all
clear all

%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
ramp =@(n) n.*(n>=0); %Ramp starting from 0 

%% Find and Plot the Frequency Response of the Composite system
a1 = [1 1.297 0.695];
a2 = [1 1.069 0.37]; 
a3 = [1 0.997 0.257]; 
a = (a1 + a2 + a3)/3; 

b1 = [0.287 0.447]; 
b2 = [-2.142 -1.145];
b3 = [1.856 0.63]; 
b = (b1+b2+b3)/3;

[H, w] = freqz(b,a,1024);

fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
subplot(2,1,1) 
plot(w/pi, abs(H),'Linewidth', 2); 
ax = gca; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Magnitude |X(e^{jw})|'; 
ax.YLabel.FontSize = 14; 
title('Freqz computed Magnitude and Phase Response of Composite System');
subplot(2,1,2)
plot(w/pi, angle(H)*180/pi, 'Linewidth', 2); 
ax = gca; 
ax.XLabel.String ='Normalized Frequency (\pi rad/sample)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Phase \langle X(e^{jw}) (deg)'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 1];
saveas(fig, 'Prob5a', 'png');

%% Find and Plot the Group Delay 
[Gd,w] = grpdelay(b,a,1024); 
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
plot(w/pi, Gd, 'Linewidth', 2); 
title('Group Delay of the Composite System');
ax = gca; 
ax.XLabel.String = 'Normalized Frequency (\pi rad/sample)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Group Delay (samples)'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 1];
saveas(fig, 'Prob5b', 'png');