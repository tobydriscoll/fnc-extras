function [a,b,r] = ratinterp(t,y)
%RATINTERP  Rational interpolant.
%Input:
%  t    vector of nodes (must have even length)
%  y    values at nodes
%Output:
%  a,b  polynomial coefficients of numerator/denominator
%  r    callable function to evaluate the interpolant

if rem(t,2)==1, error('Need an even number of nodes.'), end
n = length(t)/2; 

%*** Build the W matrix (2n by n) and Y matrix (2n by 2n)

%*** Build the matrix A (2n by 2n) and the right-side vector z (2n by 1)

%*** Solve for the coefficient vector c

%*** Define a and b from c (use *descending* degree ordering and b_n=1)

% Define a function to evaluate the interpolant
r = @(x) polyval(a,x) ./ polyval(b,x);

end