% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 3, Problem 7
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
% # Part c. Find the the Frequency response and Group Delay of H
% # Part a. Plot x_a(t) for 0 to 4 seconds
% # Part b. Plot x(n) with f_samp = 75 Hz
% # Part d. Find output y(n) by filtering x(n) with H
% # Part e. Spectral Comparison 
% # Find and Plot the Group Delay 
% 
close all
clear all

%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
ramp =@(n) n.*(n>=0); %Ramp starting from 0 


%% Part c. Find the the Frequency response and Group Delay of H
a = [1, -0.521, 0.121];
b = [9.88, -15.6, 6.2];

[H, w] = freqz(b,a,1024);

fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
subplot(2,1,1) 
plot(w/pi, abs(H),'Linewidth', 2); 
ax = gca; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Magnitude |X(e^{jw})|'; 
ax.YLabel.FontSize = 14; 
title('Freqz computed Magnitude and Phase Response of H(e^{jw})');
subplot(2,1,2)
plot(w/pi, angle(H)*180/pi, 'Linewidth', 2); 
ax = gca; 
ax.XLabel.String ='Normalized Frequency (\pi rad/sample)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Phase \langle X(e^{jw}) (deg)'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 1];
saveas(fig, 'Prob7c1', 'png');

%% Find and Plot the Group Delay 
[Gd,w] = grpdelay(b,a,1024); 
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
plot(w/pi, Gd, 'Linewidth', 2); 
title('Group Delay of H(e^{jw})');
ax = gca; 
ax.XLabel.String = 'Normalized Frequency (\pi rad/sample)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Group Delay (samples)'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 1];
saveas(fig, 'Prob7c2', 'png');


%% Plot x_a(t) for 0 to 4 seconds
t = 0:0.0001:4; 
f = 4; 
k = 2; 
% Create Analog Signal
xa = k*exp(-2*(t-2).^2).*cos(2*pi*f*(t-2)).*u(t-2);
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
subplot(3,1,1)
plot(t, xa, 'Linewidth', 2); 
title('Signals for Problem 7, parts a, b, d'); 
ax = gca; 
ax.XLabel.String ='Time (s)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'x_a(t)'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 4];

%% Part b. Plot x(n) with f_samp = 75 Hz
dT = 1/75; 
n = 0:size(0:dT:4,2)-1; 
% Write exponents in terms of a^n and a^(n^2)
a = exp(-2*dT^2); 
q = 2/dT; % 150
% Calculate digital frequency 
w_dig = 2*pi*f*dT; 
xn = k*a.^((n-q).^2).*cos(w_dig*(n-q)).*u(n-q);

subplot(3,1,2)
stem(n, xn, 'Linewidth', 2); 
ax = gca; 


%ax.XLabel.String ='n (sample)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'x(n)'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 300];

%% Part d. Find output y(n) by filtering x(n) with H
yn = filter(b,a,xn); 
subplot(3,1,3)
stem(n, yn, 'r', 'Linewidth', 2); 
ax = gca; 
ax.XLabel.String ='n (sample)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n) = h(n)*x(n)'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 300];
saveas(fig, 'Prob7abd', 'png');

%% Part e. Spectral Comparison 
[H, w] = freqz(xn,1);

fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');

%Plot |X|
subplot(2,1,1) 
plot(w/pi, abs(H),'Linewidth', 2); 
ax = gca; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Magnitude |X(e^{jw})|'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 1];
title('Spectra of the input (top) and output (bottom) signals');
%Plot angle X
% subplot(2,2,3)
% plot(w/pi, angle(H)*180/pi, 'Linewidth', 2); 
% ax = gca; 
% ax.XLabel.String = 'Normalized Frequency (\pi rad/sample)'; 
% ax.XLabel.FontSize = 14; 
% ax.YLabel.String = 'Phase <X(e^{jw}) (deg)'; 
% ax.YLabel.FontSize = 14; 
% ax.XLim= [0 1];

% Find Y spectra
[H, w] = freqz(yn,1);

% Plot |Y|
subplot(2,1,2) 
plot(w/pi, abs(H),'Linewidth', 2); 
ax = gca; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Magnitude |Y(e^{jw})|'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 1];

% Plot angle Y
% subplot(2,2,4)
% plot(w/pi, angle(H)*180/pi, 'Linewidth', 2); 
% ax = gca; 
ax.XLabel.String = 'Normalized Frequency (\pi rad/sample)'; 
% ax.XLabel.FontSize = 14; 
% ax.YLabel.String = 'Phase <Y(e^{jw}) (deg)'; 
% ax.YLabel.FontSize = 14; 
% ax.XLim= [0 1];
saveas(fig, 'Prob7e', 'png');

%% Determine center of the frequency band of the signal
[H, w] = freqz(xn,1); 
E_tr = sum(abs(H).^2); % calculate energy
E_tr_cum = cumsum(abs(H).^2); % calculate cumulative sum of energy
E_tr_cum_per = E_tr_cum/E_tr; % calculate decimal percentage 
figure; 
plot(w/pi, E_tr_cum_per, 'Linewidth', 2);
title('Determining the center of the frequency band of the input signal'); 
ax = gca; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = '\int_{0}^\omega |X(e^{jw})|^2 / \int_{0}^\pi |Y(e^{jw})|^2'; 
ax.XLabel.String = 'Normalized Frequency (\pi rad/sample)'; 
ax.YLabel.FontSize = 14; 
ax.XLim= [0 1];
I_dead = find(1-E_tr_cum_per <= 0.05); % use find to see when <=5% energy remains
I_dead(1) % First sample to reach steady state 