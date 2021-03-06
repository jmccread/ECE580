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


%find delta t
clear all;
%only ocillating equation is y3 with a highest w of 12, per Nyquist the
%minimum sampling rate is 1/(2*w)
dt = 1/24;
dt = dt * 0.01; %oversample for smoothing and to get y2 close to 8

%set up t vector 0 to 20 with a Ts of 24
t = [0:dt:20];

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

clc %clear display

%find y3(3) and y3(5) and display
disp(['y3(3)=',num2str(y3(3))])
disp(['y3(5)=',num2str(y3(5))])

%find minimum and maximum values of y3(t)
disp(['y3(t) maximum value is ',num2str(max(y3))])
disp(['y3(t) minmum value is ',num2str(min(y3))])

%find  t where y2(t) = 8
y28 = min(abs(y2-8)); %find position of value closest to 8
t8 = find(y2 == (y28+8)); %find the positon of the corresponding t
y2at8 = t(t8); %find value of t
disp(['y2(t) = ~8 [',num2str(y2(t8)),'] at t = ',num2str(y2at8)]) %display the value






%------------- END OF CODE --------------