% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab 1, Problem 3
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% June 2018; Last revision: 29-May-2018
set(groot, 'defaultAxesTickLabelInterpreter','latex'); set(groot, 'defaultLegendInterpreter','latex');

%% Problem 3 (a)
%Plot x(t). Hence, and the its max. value and the time where the max. occurs.
t = 0:0.0001:1/0.3*12; % Create time vector for plot 
fig = figure(1);
x_num = 15:0.1:1000;
x = 128.*t.^2.*exp(-0.3466.*t).*cos(0.6*pi.*t +pi/3);
plot (t, x, 'LineWidth',2 )
ax = gca; 
ax.XLabel.String = 'Time, t, (seconds)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Variable X = f(t)'; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 3', 'FontSize', 16, 'FontWeight', 'bold');
saveas(fig, 'Prob3', 'png');
% Use the findpeaks function to determine the maximum
[pks, locs] = findpeaks(x);
x_max = max(pks)

index = find(x_max == x);
t_max = t(index)

%% (b) The integral from 0 to infinity of x(t)

syms t % Create symbolic vars to calculate the max value of x(t)
u = t>=0; 
eqn1 = 128 .* t^2 .* exp(-0.3466.*t) .* cos(0.6.*pi.*t +pi/3); % write x(t) = eqn1 

% Use the int function to integrate eqn1 from 0 to infinity. 
A = int(eqn1, [0,inf]);


%% (c) he integral from 0 to t0 of x(t) S.T.  = 0.4A
syms t0 positive 
B = int(eqn1, [0,t0]);
tic
real_t0 = solve(B == 0.4*A, t0)
toc


%% (d) Energy of x(t)
tic
E = vpaintegral(abs(eqn1)^2, 0,inf);
toc
