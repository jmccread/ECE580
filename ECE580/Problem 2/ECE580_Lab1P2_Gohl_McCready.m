% Class:            ECE 580, Digital Signal Processing 
% Assignment:       <Assignment>
% Author:           Jonathan Gohl, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jrgohl@umich.edu
% Author:           Joshua McCready, Electrical Engineering M.S.E. Student
% University of Michigan Dearborn, Electrical and Computer Engineering
% email address:    jmccread@umich.edu
% Month Year; Last revision: XX-Month-Year

%------------- BEGIN CODE --------------

%Problem 2 
%Requirement 1
%Plot the following functions on the same graph with black, red, and brown
%colors respectively.
%
%Requirement 2
%Take the interval 0 <= t <= 20 and choose a suitable delta t. (eg 0.01s)
%
%Requirement 3
%Limit Y axis from -7 to 16
%
%Requirement 4
%Limit X axis from 0 to 15
%
%Requirement 5
%
%Determine {y3(3), y3(5), y3 min and max, t where y(t)=8;
%
%Requirement 6
% Use legend to identify curves

%define variables
syms t y1 y2 y3

t = [0:0.01:20];

%define equations
%(a)
y1 = 6.*(exp(-t/2));
y2 = 12.*(exp((-0.25).*t));
y3 = 12.*(exp(-t/4)).*cos(12.*t + (pi/3)) + 6.*(exp(-t/2));

%Plot functions
plot(t,y1, t,y2, t,y3); %set up plot
color_handler = plot(t,y1, t,y2, t,y3); %set color of lines
set(color_handler,{'color'},{[0 0 0];[1 0 0];[0.2 0 0]}); %set color of lines (req 1)
legend('y1 = 6e^{-t/2}','y2 = 12e^{-0.25t}','y3 = 12e^{-t/4}cos(12t+\pi/3)+6e^{-t/2}') %draw legend
title('ECE580 Lab 1 Problem 2') %draw title
xlabel('Time(s)') %label x axis
ylabel('y(t)') %label y axis
xlim([0 15]) %set x axis limits
ylim([-7 16])%set y axis limits




%------------- END OF CODE --------------