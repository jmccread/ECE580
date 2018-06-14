% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab 1, Problem 5
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% June 2018; Last revision: 03-June-2018

%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
% operating on n

%% Part a - convolution of two shifted impulse functions 
n = -6:10;
x1 = conv(delta(n-3), delta(n+2)); % Compute the convolution using conv function

% The new index will be of a different length than the input - according to
% the new length will be max(length(A)+length(B) -1, length(A), length(B)).
% In our case n is 17, so the new length will be 33. 
n_x1 = -12:20;

fig = figure(1);
stem(n_x1, x1);
ax = gca; 
ax.XLabel.String = 'Sample n'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'x_1(n) = \delta(n-3) * \delta(n+2)'; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 5 (a)', 'FontSize', 16, 'FontWeight', 'bold');
saveas(fig, 'Prob5a', 'png');

%% Part 2 - shifted and scaled delta function 
n = 300:350;
x2 = 2*delta(n-320); % Use delta function handle

fig = figure(2);
stem(n, x2);
ax = gca; 
ax.XLabel.String = 'Sample n'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'x_2(n) = 2\delta(n-320))'; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 5 (b)', 'FontSize', 16, 'FontWeight', 'bold');
saveas(fig, 'Prob5b', 'png');

%% Part c - shifted and scaled delta function 
n = -12:8;
x3 = 3.6*delta(n+6) + 2.4*delta(n-5); % Use delta function handle

fig = figure(3);
stem(n, x3);
ax = gca; 
ax.XLabel.String = 'Sample n'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'x_3(n) = 3.6\delta(n-320) + 2.4\delta(n-5)'; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 5 (c)', 'FontSize', 16, 'FontWeight', 'bold');
saveas(fig, 'Prob5c', 'png');

%% Part d - shifted step functions 
n = -10:20;
x4 = u(-n+2).*u(2*n+9); % Use delta function handle

fig = figure(4);
stem(n, x4);
ax = gca; 
ax.XLabel.String = 'Sample n'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'x_4(n) = u(-n+2)u(2*n+9)'; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 5 (d)', 'FontSize', 16, 'FontWeight', 'bold');
saveas(fig, 'Prob5d', 'png');

%% Part 3 - convolution of pulse functions
n = -12:12;
n5 = -24:24;
x5 = conv(pulse(n,4), pulse(n, 2)); % Use delta function handle
fig = figure(5);
stem(n5, x5);
ax = gca; 
ax.XLabel.String = 'Sample n'; 
ax.XLabel.FontSize = 14; 
ax.YLabel.String = 'x_5(n) = pulse_4(n) * pulse_2(n)'; 
ax.YLabel.FontSize = 14; 
title('Lab Assignment 1, Problem 5 (d)', 'FontSize', 16, 'FontWeight', 'bold');
saveas(fig, 'Prob5e', 'png');
