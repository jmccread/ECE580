% Class:            ECE 580, Digital Signal Processing 
% Assignment:       Lab Assignment 2, Problem 3
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% Month Year; Last revision: 21-June-2018

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

%% Create signals
delta = @(n) n == 0; % Impulse function operating on n. 
u = @(n) n >= 0; % Step starting from 0, operating on n
pulse =@(n, l) u(n) - u(n -l); %Impulse train of lenth l, starting from 0, 
ramp =@(n) n.*(n>=0); %Ramp starting from 0 

%% Part (a) Create Block Diagram
print -dpng -sblock_diagram block_diagram.png

%% Part (b)
