% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 2, Problem 1
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% Month Year; Last revision: 21-June-2018

%% Table of Contents 
% 
% # Create Signals
% # Filter Coeffiecent Setup
% # Part (a) x(n) = delta(n) 
% # Part (b) x(n) = u(n-3) 
% # Part (c) x(n) = u(n)u(-n+23)
% # Part (d) ramp(n)-ramp(n-23)
% 

%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
ramp =@(n) n.*(n>=0); %Ramp starting from 0 

% Question 1 
% Consider the dierence equation given as follows:
% y(n) = 0.75y(n - 1) - x(n) + 4 choose 3 * x(n-1), n>= 0 
% Find and plot x(n) and y(n) and hence find the energy of y(n) for the
% following cases


%% Filter Coeffiecent Setup
n = 0:150; % Choose n such that signal length allows transient to to die off
a = [1, -0.75]; 
b = [-1, 4]; 

%% Part (a) x(n) = delta(n) 
n = 0:100; 
x = delta(n); 
y = filter(b,a,x);
Ey = sum(y.^2)    % Finite energy <-> x is absolutely summable  
% Plotting
fig = figure(1);
subplot(2,1,1)
stem(n(1:end), x(1:end), 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'x(n) = \delta(n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 1 (a): Impulse Repsonse', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n(1:end),y(1:end), 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)=0.75y(n-1)-x(n)+4x(n-1)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob1a', 'png');

%% Part (b) x(n) = u(n-3) 
n = 0:100; 
x = u(n-3); 
y = filter(b,a,x); 
Ey = sum(y.^2); % infinite energy <-> x is NOT absolutely summable 
disp('In part b, x(n) is infinite duration and not absolutely summable, it follows that y(n) is a power signal'); 
% Plotting
fig = figure(1);
subplot(2,1,1)
stem(n(1:end), x(1:end), 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'x(n)=u(n-3)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 1 (b): Shifted Step Repsonse', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n(1:end),y(1:end), 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)=0.75y(n-1)-x(n)+4x(n-1)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob1b', 'png');



%% Part (c) x(n) = u(n)u(-n+23) 
n = 0:100; 
x = u(n).*u(-n+23); 
y = filter(b,a,x); 
Ey = sum(y.^2) % finite energy <-> x is absolutely summable 
% Plotting
fig = figure(1);
subplot(2,1,1)
stem(n(1:end), x(1:end), 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'x(n)=u(n)u(-n+23)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 1 (c): Response to input', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n(1:end),y(1:end), 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)=0.75y(n-1)-x(n)+4x(n-1)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob1c', 'png');

%% Part (d) ramp(n)-ramp(n-23)
n = 0:200; 
x = ramp(n)-ramp(n-23); 
y = filter(b,a,x); 
Ey = sum(y.^2); % Infinite energy <-> x is NOT absolutely summable
disp('In part d, x(n) is infinite duration and not absolutely summable, it follows that y(n) is a power signal'); 
% Plotting
fig = figure(1);
subplot(2,1,1)
stem(n(1:end), x(1:end), 'LineWidth', 2);
ax = gca; 
ax.YLabel.String = 'x(n)=r(n)-r(n-23)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 1 (d): Response to input', 'FontSize', 16, 'FontWeight', 'bold');
subplot(2,1,2)
stem(n(1:end),y(1:end), 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'Sample Index (n)'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'y(n)=0.75y(n-1)-x(n)+4x(n-1)'; 
ax.YLabel.FontSize = 14; 
%axis([min(n), max(n), -10, 10])
saveas(fig, 'Prob1d', 'png');