% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 2, Problem 3
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% Month Year; Last revision: 21-June-2018
close all 
clear all
% Problem 3: 
% y(n) = 0.75y(n-2)+x(n)+2x(n-1)-x(n-2)
%% Table of Contents 
% 
% # Create Signals
% # Filter Coeffiecent Setup
% # Part (a) Block Diagram
% # Part (b) Impulse Response
% # Part (c) Step Response
% # Part (d) Convulved Pulse Response
% # Part (e) Energy of Signals 
% 

%% Filter Coeffiecent Setup
n = 0:100; % Choose n such that signal length allows transient to to die off
a = [1 0 -0.75]; 
b = [1, 2, -1]; 
%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
ramp =@(n) n.*(n>=0); %Ramp starting from 0 

%% Part (a) Create Block Diagram
%print -dpng -block_diagram block_diagram.png
syms z
%% Part (b)
% Y(Z)*(1 -0.75z^-2) = X(Z)(1 + 2z^-1 -z^-2)
% Y(Z)(z^2 - 0.75) = X(Z)(z^2+2z-1)
H = (z^2+2*z-1)/(z^2-0.75); 
Delta = 1; 
Y_b = Delta*H; 
Y_b = partfrac(Y_b, z); 
y_b_n = iztrans(Y_b)
%simplify(y_b_n, n)


disp('The response is called the impulse response.'); 

x = delta(n); 
y = filter(b,a,x);
Ey_b = sum(y.^2)
y_analytic = 4/3*delta(n) + (1-1/(4*3^.5)).*sqrt(3/4).^(n-1)...
    +(1+1/(4*3^.5)).*(-sqrt(3/4)).^(n-1);
%Ey_a = sum(y.^2);    % Finite energy <-> x is absolutely summable  
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95])
subplot(2,1,1)
stem(n(1:end), x(1:end), 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'x(n)=\delta(n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 2, Problem 3 (b): Impulse Response', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n(1:end),y(1:end), 'LineWidth', 2);
hold on; 

stem(n,y_analytic)

hold off; 
ax = gca; 
legend('impz', 'analytic');
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob3b', 'png');

%% Part (c) unit step response 

Step = z/(z-1); 
Y_c = Step*H; 
Y_c = partfrac(Y_c, z); 
y_c_n = iztrans(Y_c)

x = u(n); 
y = filter(b,a,x);
Ey_c = sum(y.^2);
y_analytic = 8 - ((5/2+ 7*sqrt(3)/4)*sqrt(3/4).^(n-1) + (5/2 -7*sqrt(3)/4)*(-sqrt(3/4)).^(n-1));
%Ey_a = sum(y.^2);    % Finite energy <-> x is absolutely summable  
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95])
subplot(2,1,1)
stem(n, x, 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'x(n)= u(n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 2, Problem 3 (c): Step Response', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n(1:end),y(1:end), 'LineWidth', 2);
hold on; 

stem(n,y_analytic)

hold off; 
ax = gca; 
legend('impz', 'analytic');
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob3c', 'png');

%% Part d
Step = z/(z-1); 
Xzd = (Step*z^-2 - Step*z^-7)*(Step-Step*z^-10);
Y_d = Xzd*H; 
Y_d = partfrac(Y_d, z); 
y_d_n = iztrans(Y_d);

x = conv(pulse(n-2,5),pulse(n,10)); 
x = x(1:101);

y = filter(b,a,x);
Ey_d = sum(y.^2)
%y_analytic = 8 - ((5/2+ 7*sqrt(3)/4)*sqrt(3/4).^(n-1) + (5/2 -7*sqrt(3)/4)*(-sqrt(3/4)).^(n-1));
%Ey_a = sum(y.^2);    % Finite energy <-> x is absolutely summable  
fig = figure('units','normalized','outerposition',[0 0 0.95 0.95]);
subplot(2,1,1)
stem(n, x, 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'x(n)= p_{5}(n-2)*p_{10}(10)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 2, Problem 3 (d): Convolved Pulse Response', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n(1:end),y(1:end), 'LineWidth', 2);
hold on; 

%stem(n,y_analytic)

hold off; 
ax = gca; 
legend('impz', 'analytic');
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob3d', 'png');

%% Part d. Print out all the computed energies 

Ey_b 
Ey_c
Ey_d