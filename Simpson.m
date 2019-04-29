function [I] = Simpson(x,y)
%Created By: Derek LaBahn
%Created on: 13 Apr 2019
%Purpose: Use Simpson's 1/3 rule to integrate experimental y data with respect to x data. Use
%trapezoidal rule for final interval if necessary.
%
%Inputs:
%x=Equally spaced independent variable data
%y=Dependent variable experimental data
%
%Outputs:
%I=Estimated integral value for experimental data
%
%%%%%%%WARNING!!!!%%%%%%%
%x value spacing must be precise
%Use fractions to represent repeating decimal x values where possible
%for example- .3333 ~= 1/3
%algorithm will produce error if fractional values are not represented
%acurately enough

%% preliminary checks

%check for 2 inputs(error if not)
if nargin ~= 2
    error('There must be exactly 2 input arguments.')
end

%get length of input arrays
lengthx = length(x);
lengthy = length(y);

%check that length of x data is equal to length of y data
%error if not
if lengthx ~= lengthy
    error('The inputs must be the same length.')
end

%create array which will be equal to x if equally spaced
%using linspace(first x pt, last x pt, length of x)
spacex= linspace(x(1),x(lengthx),length(x));

%if absolute value of the sum of fake x - the sum of real x is not extremely small,give error because x is not equally
%spaced(accounts for rounding/truncation errors)
if abs(sum(spacex)-sum(x))>.0000001
    error('The x input must be equally spaced.')
end

%check individual x values vs expected x values
%ensure spacing is equal on term by term basis rather than total sum
errorctr = 1;%counter for array values
while errorctr < lengthx
    %difference between expected term 2 - term 1 and actual term 2 - term 1
    %must be very small
    if abs((spacex(errorctr + 1)-spacex(errorctr))-(x(errorctr + 1) - x(errorctr)))>.000001
        error('The x input must be equally spaced.')
    end
    %repeat for all values of x
    errorctr = errorctr +1;
end
    
%% Determine if trap rule is needed

%divide number of terms in x by 2 
remainderx = rem(lengthx,2);
%if there is no remainder(number of terms is even), there will be an odd
%number of intervals
%if odd number of intervals give warning because the last interval must be
%approximated using the trapezoidal rule.
if remainderx == 0
    warning('Because there is an odd number of intervals in x, the trapezoidal rule will be used to calculate the last interval.')
end

%%  calculation for I using 1/3 rule only

%if even number of intervals
if remainderx ~= 0
    
    %mid point counter to sum all mid simpson rule data points(sum of all
    %even data points)
midptctr = 2; %midpoint counter starting at term 2
summid=0;%sum initially 0

%loop to sum all even data points
while midptctr < lengthx
summid =summid + y(midptctr);%sum = previous sum + current value 
midptctr = midptctr + 2;%term 2, 4 ,6 etc
end

 %end point counter to sum all end simpson rule data points(sum of all
    %odd data points excluding first and last)
endptctr =3;%endpoint counter starting at term 3
sumend = 0;%sum initially 0

%loop to sum all odd data points
while endptctr < lengthx
    sumend =sumend + y(endptctr);%sum = previous sum + current value 
    endptctr = endptctr + 2;%term 3, 5 etc (excluding last term)
end

%calculate integral estimate using
%I = (b-a)((f(a) + 4*(sum of even points) +
%2*(sum of odd data points) + f(b))/(3*n))
n = lengthx - 1; %n=data points - 1
I = (x(lengthx) - x(1))*((y(1)+4*summid + 2*sumend + y(lengthy))/(3*n));%integral formula
end

%% calculation for I using 1/3 and trap rule for last interval

%if odd number of intervals
if remainderx == 0
    
     %mid point counter to sum all mid simpson rule data points(sum of all
    %even data points)
midptctr = 2;%midpoint counter starting at term 2
summid=0;%sum initially 0

%loop to sum all even data points excluding final point(final pt uses trapp
%rule
while midptctr <= lengthx - 2
summid =summid + y(midptctr);%sum = previous sum + current value 
midptctr = midptctr + 2;%term 2,4,6 etc to term n-2
end

 %end point counter to sum all end simpson rule data points(sum of all
    %odd data points excluding first and last odd data point)
endptctr =3;%endpoint counter starting at term 3
sumend = 0;%sum initially 0

%loop to sum all odd data points excluded final odd data point
while endptctr <= lengthx - 2
    sumend =sumend + y(endptctr);%sum = previous sum + current value 
    endptctr = endptctr + 2;%term 3, 5 etc (excluding last odd term)
end

%calculate integral estimate using
%I = ((b-1)-a)((f(a) + 4*(sum of even points) +
%2*(sum of odd data points) + f(b-1))/(3*n))
n = lengthx - 2;%n=data points - 2
I = (x(lengthx-1) - x(1))*((y(1)+4*summid + 2*sumend + y(lengthy-1))/(3*n));%integral formula

%add trap rule for last interval
%I = simpsons estimate + (b-(b-1))*(f(b)+f(b-1))/2
I = I + (x(lengthx)-x(lengthx -1))*((y(lengthy)+y(lengthy -1))/2);%trap rule formula 
end

end