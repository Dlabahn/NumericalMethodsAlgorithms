# False Position Algorithm
The false position algorithm is a method to find the zero of a function. This algorithm allows the user to define a function, the limiting bracket which must encompass the root, the percent error stopping criteria and the limiting number of iterations. 
## Inputs
func = function where the root is to be determined
xl = lower bound(x value below root)
xu = upper bound(x value above the root)
es = desired accuracy of estimate(%)
maxiter = maximum number of iterations the algorithm will perform
## Outputs
root = estimated root of the function
ea = approximate relative percent error(%)
iter = number of iterations performed
### Additional Information
If no input is recieved for es or maxiter the algorithm will default to:
es = .0001
maxiter = 200
