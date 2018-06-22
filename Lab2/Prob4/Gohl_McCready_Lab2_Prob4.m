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
% # initialize
% # Define variables
% # Create Signals
% # Create plot
% # Part a-d
% 
%*****************************************************************
%initialize
clear vars
clc
close all

%define variables
n = -5:10;
x = zeros(size(n));
x(n>=0) = 1;
y = zeros(size(n));
ys = zeros(size(n));
yt = zeros(size(n));


%create signals

ind_n = find(n==0) - 3;
lenx = length(x);

for i=ind_n:lenx
       
    ys(i) = -1.77.*y(i-1) - 0.81.*y(i-2) + x(i) - 0.5.*x(i-1);
end

for i=ind_n:lenx
       
    if(ys(i) ~= 0)
    if(ys(i) == ys(i+1))
        G0 = ys(i);
        break
    end
    end
end
 %Print answer to part a
 disp('Part (a)')
 disp(['G0 = ',num2str(G0)])
 disp(' ')
 
 %part (b)
 
 %calculate yt(n)
 
 for i=ind_n:lenx
       
    yt(i) = ys(i) - G0;
end

%create plot
fig = figure(1);
subplot(2,1,1)
stem(n(1:end), ys(1:end), 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'x(n) = u(n) (no units)'; 
ax.XLabel.FontSize = 10; 
ax.YLabel.FontSize = 10; 
ax.YLabel.String = 'yt(n) = y(n)-1.77y(i-1)-0.81y(i-2)+x(i)-0.5x(i-1) (no units)';
title('Lab Assignment 2, Problem 4 Part (a) : y(n)', 'FontSize', 16, 'FontWeight', 'bold');

subplot(2,1,2)
stem(n(1:end), yt(1:end), 'LineWidth', 2);
ax = gca; 
ax.XLabel.String = 'x(n) = u(n) (no units)'; 
ax.XLabel.FontSize = 10; 
ax.YLabel.FontSize = 10; 
ax.YLabel.String = 'yt(n) = y(n) - G0(no units)';
title('Lab Assignment 2, Problem 4 Part (b) : Transient Response', 'FontSize', 16, 'FontWeight', 'bold');
saveas(fig, 'Prob4', 'png');
%part(b)
disp(' ')
disp('Part (b)')
disp('See fig. 1')
disp(' ')
%part(c)
y_energy = trapz(yt);
disp('Part (c) Find the Energy')
disp('The energy of the signal is the area under the curve which is the integral,')
disp(['the numerical integration of y(n) yields ', num2str(y_energy)])

%part(d)

for i=1:10
       
    if(yt(i)==yt(i+1) && y(i)==y(i+2) && y(i)==y(i+3) )
        y_steady = yt(i);
        initial_steady = n(i);
        break
    end
    
end

disp(' ')
disp('Part (d) Find the beginning of the steady state')
disp(['yt(n) reaches steady state at sample ', num2str(i)])





