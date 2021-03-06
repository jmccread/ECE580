% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab 1, Problem 1
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% June 2018; Last revision: 29-May-2018

%% Problem 1 (a)
% What is the range of the variable x, which makes y real?

syms x y u

eqn1 = y == 20*((20 - (x + 5)/5 - (x+5)^2/25)/(4 + (15 - x)^2/25))^(1/2);

% The range of the variable that makes y real will be the range that makes
% the argument of the square root positive.

% We need only consider the numerator of the argument because, the
% denominator will always be positive. 

u = x+5; % Substitution 
arg_num = 500 - 5*u - u^2; % Factoring
roots( [1, 5, -500] ); % Factoring
arg_num = (u - 20)*(u + 25); % Factored, print in terms of x
arg_num = (x - 15)*(x+30); % Factored, in terms of x, x<15, the numerator is <0.

% For x<15, the numerator of the square root is negative, therefore y is
% imaginary. For x>=15, y is real. 

%%  Problem 1 (b)
% Sketch the curve and estimate the global maximum (only real values of y).
eqn2 = 20*(arg_num/(100 + (15 - x)^2))^(1/2);
fig = figure(1);
x_num = 15:0.1:1000;
plot (x_num, 20*(((x_num+30).*(x_num-15))./(100 + (15 - x_num).^2)).^(1/2), 'LineWidth',2 )
ax = gca; 
ax.XLabel.String = 'Variable X, for real valued Y only'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'Variable Y = f(X)'; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 1', 'FontSize', 16, 'FontWeight', 'bold');
l = legend( '$Y = f(x) = 20\sqrt{\frac{(x - 15)(x + 30)}{(x - 15)^2 + 100)}}$');
set(l, 'interpreter', 'latex')
%% Problem 1 (c)
% Find the value of this maximum and the corresponding value of x at the maximum.
dydx = diff(eqn2); 
max = solve(dydx == 0, x);

d2ydx2 = diff(dydx);

