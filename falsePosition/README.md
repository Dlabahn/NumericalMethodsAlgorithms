# False Position Algorithm
The false position algorithm is a method to find the zero of a function. This algorithm allows the user to define a function, the limiting bracket which must encompass the root, the percent error stopping criteria and the limiting number of iterations. 
## Inputs
1. func = function where the root is to be determined
2. xl = lower bound(x value below root)
3. xu = upper bound(x value above the root)
4. es = desired accuracy of estimate(%)
5. maxiter = maximum number of iterations the algorithm will perform
## Outputs
1. root = estimated root of the function
2. ea = approximate relative percent error(%)
3. iter = number of iterations performed
### Additional Information
If no input is recieved for es or maxiter the algorithm will default to:
1. es = .0001
2. maxiter = 200
