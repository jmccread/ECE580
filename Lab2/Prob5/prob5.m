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
% # Set up filter
% # Part a: Magnitude and Phase Response
% # Part b: System Response to Input
% # Part c: Steady State and Transient
% # Part d: Steady State and Transient Periods 
% # Pard e: Spectra of Input and Output
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
a = [1, -0.9051, 0.598, -0.29, 0.1958]; 
b = [0.207,   0,  0.413,     0,   0.207];

%% Part (a) Magnitude and Phase Response 
% use the filt function to create 
%h = filt(b,a); 
figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'off')
[FResp,W] = freqz(b,a, 10e5);
freqz(b,a, 10e5)
ax = gca;
title('Gain and Phase Response of y(n) - 0.9051y(n-1) +0.598y(n-2) -0.29y(n-3) + 0.1958y(n-4) = 0.207x(n) +0.413x(n-2) + 0.207x(n-4)')
saveas(figure(1), 'Prob5a', 'png');

%% Part (b) System response to x(n) = 8sin(w1*n-pi/3)*cos(w2*n-pi/4)*u(n)
n = 0:100; 
w1 = 0.25*pi; 
w2 = 0.45*pi; 
A = w1*n-pi/3; 
B = w2*n-pi/4; 
% We can re-write the input functiont using a product identities
% sin(A)cos(B) = 0.5*(sin(A+B) +sin(A-B)

x0 = 8*sin(w1*n-pi/3).*cos(w2*n-pi/4).*u(n);
x1 = 4*(sin(A+B)+sin(A-B)).*u(n);
x2 = 4*(cos(A+B+pi/2) +cos(A-B+pi/2)).*u(n);

figure
stem(n,x0, 'r', 'LineWidth', 2); hold on
stem(n,x1, 'b', 'LineWidth', 1); hold on
legend('given', 'sin sum');
x = x0;
y = filter(b,a, x);

fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
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
 
y_ss  = 4*(abs(FResp(I_p7pi))*sin(A+B+ angle(FResp(I_p7pi)))...
    -abs(FResp(I_p2pi))*sin(A-B + angle(FResp(I_p2pi))));
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
y_tr = y-y_ss;
subplot(2,1,1)
stem(n, y_ss, 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'y(n) (steady state)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 2, Problem 5 (c): Steady State and Transient', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)

stem(n,(y-y_ss) , 'LineWidth', 2);

ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n) (transient)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob5c', 'png');

%% Part d: Steady State and Transient Periods
% Lets consider that the energy of the transient response after it has
% "died" must be less than 0.05 of the total. 

E_tr = sum(y_tr.^2); % calculate energy
E_tr_cum = cumsum(y_tr.^2); % calculate cumulative sum of energy
E_tr_cum_per = E_tr_cum/E_tr; % calculate decimal percentage 
I_dead = find(1-E_tr_cum_per <= 0.05); % use find to see when <=5% energy remains
I_dead(1) % First sample to reach steady state 

%% Part e: Plot magnitude spectra of input and output
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95], 'Visible', 'on');
%plot first half of DFT (normalised frequency)
Y_mags = abs(fft(y));
num_bins = length(Y_mags);
stem([0:1/(num_bins/2 -1):1], Y_mags(1:num_bins/2), 'LineWidth',2),grid on;
hold on;
X_mags = abs(fft(x));
num_bins = length(X_mags);
stem([0:1/(num_bins/2 -1):1], X_mags(1:num_bins/2), 'LineWidth', 1)
title('Magnitude spectrum of Input and Output');
xlabel('Normalized frequency (\pi rads/sample)');
ylabel('Magnitude');
legend('Output y', 'Input x'); 

saveas(fig, 'Prob5e', 'png');