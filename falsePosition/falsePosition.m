function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
%Created by: Derek LaBahn
%Created on: 28 Feb 2019
%purpose: Calculated the root of a function using the flase position bracketed method
%inputs:
%func = name of function to be tested
%xl = lower bracket
%xu = upper bracket
%es = desired % accuracy of relative error(defaults to 0.0001%)
%maxiter = maximum number of iterations to be run(defaults to 200)
%outputs:
%root = calculated function root
%fx = function value at calculated root
%ea = approximate relative error percent
%iter = number of iterations to calculate root

%% default checks
%check if minimum inputs exist for function(error if not)
if nargin<3
    error('At least 3 input arguments required. \n')
end
%if only 3 inputs default es and maxiter
if nargin == 3
   es = .0001;
   maxiter = 200;
end
%if only 4 inputs default maxiter
if nargin == 4
    maxiter = 200;
end

%% variables
%starting variables
iter = 0;%iterations
ea = 100;%ea start at 100%
fxl = func(xl);%function value at lower bound
fxu = func(xu);%function value at upper bound
xr = xl;%use lower bound as baseline root

%% Test
%test to confirm root between bounds
test = fxl * fxu; %multiply function values at lower and upper bounds
if test > 0%if result is positive there are 0 or multiple roots between bounds
    error('There are 0 or multiple roots between the bounds. \n')
end
%% loop
%create while loop to perform iterations
while ea >= es & iter < maxiter%do until ea or max iterations reach input thresholds
    
iter = iter + 1;%increase iteration count
xrold = xr;%keep last xr value to calculate ea


%calculate equation of line between xl and xu (form y = mx + b)
fxl = func(xl);%function value at lower bound
fxu = func(xu);%function value at upper bound

m = (fxu - fxl)/(xu - xl);%slope of line (using m = (y(xu)-y(xl))/(xu-xl))
b = fxl - m * xl;%y intercept (using y(xl) = m * xl + b)
xr = -b / m;%x intercept of line is root estimate (using 0 = m*x + b) 
fx = func(xr);%function value at calculated root


%calculate relative error except for first iteration
if iter ~= 1
ea = abs((xr - xrold)/xr) * 100;
end

%run test to see where root lies
test = fx * fxl;%fuction value at current root * function value at lower bound

if test < 0%if test negative root is xl<root<xr
    xu = xr;%make xr the new upper bound
elseif test > 0%if test is positive root is xr<root<xu
        xl = xr;%make xr new lower bound
else%if test is 0 xr is the root
    ea = 0; %error is 0 and loop will break
end
    

end

%% outputs
root = xr;%root is final xr value
fx = func(xr);%function value at final root
%output final root and function values
fprintf('The calculated root occurs at x = %.7f with a value of y = %.7f. \n',root,fx)
%output approximate error and total number of iterations
fprintf('This calculation took %.0f iterations and has an approximate relative error of %.7f percent. \n',iter,ea)

end

