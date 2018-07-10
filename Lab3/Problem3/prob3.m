% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 3, Problem 3
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
% # (a) Compute X(e^(jw)) using freqz and plot gain and phase
% # (b) Determine the magnitude and phase analytically plot gain and phase
% 
close all
clear all

%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
ramp =@(n) n.*(n>=0); %Ramp starting from 0 

%% Part (a) Compute X(e^(jw)) using freqz and plot gain and phase

n = 0:7; 
x = (-0.9).^n.*(u(n) - u(n-7)); 
stem(n,x); 

[H, w] = freqz(x,1);

fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
subplot(2,1,1) 
plot(w, abs(H),'Linewidth', 2); 
ax = gca; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Magnitude |X(e^{jw})|'; 
ax.YLabel.FontSize = 14; 
title('Freqz computed Magnitude and Phase Response');
subplot(2,1,2)
plot(w, angle(H)*180/pi, 'Linewidth', 2); 
ax = gca; 
ax.XLabel.String = 'Frequency(radians)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Phase <X(e^{jw}) (deg)'; 
ax.YLabel.FontSize = 14; 
saveas(fig, 'Prob3a', 'png');

%% Part (b) Analytically computed Magnitude and Phase
%Mag = abs((1-(-0.9*exp(-j*w)).^7)./(1+0.9*exp(-j*w)));
Mag = sqrt((1.2287 + 0.9566*cos(7*w))./(1.81 +1.8*cos(w)));
Phase = -atan(-(-0.9)^7*sin(7*w)./(1-(-0.9)^7*cos(7*w))) + atan(0.9*sin(w)./(1+0.9*cos(w)));
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
subplot(2,1,1) 
plot(w, Mag,'Linewidth', 2); 
ax = gca; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Magnitude |X(e^{jw})|'; 
ax.YLabel.FontSize = 14; 
title('Analytically computed Magnitude and Phase Response');
subplot(2,1,2)
plot(w, Phase*180/pi, 'Linewidth', 2); 
ax = gca; 
ax.XLabel.String = 'Frequency(radians)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Phase <X(e^{jw}) (deg)'; 
ax.YLabel.FontSize = 14; 
saveas(fig, 'Prob3b', 'png');