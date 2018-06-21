% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 2, Problem 5
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% Last revision: 21-June-2018

set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');

%% Table of Contents 
% 
% # Create Signals
% 
close all
clear 

%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
ramp =@(n) n.*(n>=0); %Ramp starting from 0 

%% Setup 
% y(n) - 0.9051y(n-1) -0.598y(n-2) -0.29y(n-3) - 0.1958y(n-4) 
% = 0.207x(n) +0.413x(n-2) + 0.207x(n-4) 
% Filter coeffiencent setup 
a = [1, -0.9051, +0.598, -0.29, +0.1958]; 
b = [0.207,   0,  0.413,     0,   0.207];

%% Part (a) Magnitude and Phase Response 
% use the filt function to create 
%h = filt(b,a); 
figure('units','normalized','outerposition',[0 0 0.95 0.95])
[FResp,W] = freqz(a,b, 10e5);
freqz(a,b, 10e5)
ax = gca;
title('Gain and Phase Response of y(n) - 0.9051y(n-1) -0.598y(n-2) -0.29y(n-3) - 0.1958y(n-4)'); 
% = 0.207x(n) +0.413x(n-2) + 0.207x(n-4) 
saveas(figure(1), 'Prob1a', 'png');
disp('This is a high pass IIR filter, with constant group delay in the passband')
figure
impz(b,a)
%% Part (b) System response to x(n) = 8sin(w1*n-pi/3)*cos(w2*n-pi/4)*u(n)
n = 0:50; 
w1 = 0.25*pi; 
w2 = 0.45*pi; 
A = w1*n-pi/3; 
B = w2*n-pi/4; 
% We can re-write the input functiont using a product identities
% sin(A)cos(B) = 0.5*(sin(A+B) +sin(A-B)
x0 = 8*sin(w1*n-pi/3).*cos(w2*n-pi/4).*u(n);
x1 = 4*(sin(0.7*pi*n-7/12*pi)+sin(-0.2*pi*n-1/12*pi)).*u(n);
x = 4*(cos(0.7*pi*n-13/12*pi)-cos(0.2*pi*n-5/12*pi)).*u(n);

y = filter(b,a, x0);
%impz(b,a)
% % Calculate the output sequence 
% syms z
% H = (0.207*z^4 + 0.413*z^2 + 0.207)/(z^4 -0.9051*z^3 -0.598*z^2 -0.29*z -0.1958); 
% Delta = 1; 
% h = Delta*H; 
% h = partfrac(h, z); 
% h = iztrans(h);
% X_z = 4*(z*(z*cos(-13/12*pi)-cos(0.7*pi+13/12*pi))/(z^2-2*cos(0.7*pi)*z+1)...
%          - z*(z*cos(-5/12*pi)-cos(0.2*pi+5/12*pi))/(z^2-2*cos(0.2*pi)*z+1));
% 
% Y = h*X_z; 
% 
% Y = partfrac(Y, z); 
% y_analytic = iztrans(Y);


fig = figure('units','normalized','outerposition',[0 0 0.95 0.95]);
subplot(2,1,1)
stem(n, x, 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'x(n) = 8sin(w1*n-pi/3)*cos(w2*n-pi/4)*u(n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 2, Problem 5 (b): Response to input', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n,y, 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob5b', 'png');

%% Part c - Find the steady state output of the system
% in order to find the transient response, we will first find the steady
% state response

% Find the indicies of W for the two input frequencies of x (0.2 and 0.7): 
I_p2pi = find(W == 0.2*pi); % Index for FResp value for 0.2pi 
I_p7pi = find(W == 0.7*pi); % Index for FResp value for 0.7pi 

% Use the fact that for steady state: y_ss = A|H(jw)|cos(wn+B+<H(jw))
% for x = Acos(wn+B). 
y_ss = 4*(abs(FResp(I_p7pi))*sin(0.7*pi*n - 7/12*pi + angle(FResp(I_p7pi)))...
         -abs(FResp(I_p2pi))*sin(-0.2*pi*n -1/12*pi + angle(FResp(I_p2pi)))).*u(n);

fig = figure('units','normalized','outerposition',[0 0 0.95 0.95]);

subplot(2,1,1)
stem(n, y_ss, 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'y(n) (steady state)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 2, Problem 5 (c): Steady State and Transient', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n,y-y_ss, 'LineWidth', 2);
hold on; 
hold off; 
ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n) (transient)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob5b', 'png');