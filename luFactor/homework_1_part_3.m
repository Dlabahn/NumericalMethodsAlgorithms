%% Homework 1
% Derek LaBahn
% MECH 105
% 26 JAN 2019

%% Question 10
z = -5:5;%create number array
f= (1/(sqrt(2*pi)))*10.^ ((-z.^2)/2);%frequency equation
plot(z,f)%create plot
title("Probability density")%plot title
xlabel("Density (N)")%x axis title
ylabel("Probablity (P)(%)")%y axis title

