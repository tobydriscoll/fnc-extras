function [T,t,y] = trapezoid(f,a,b,n)
%TRAPEZOID   Trapezoid formula for numerical integration.
% Input:
%   f     integrand (function)
%   a,b   interval of integration (scalars)
%   n     number of interval divisions
% Output:
%   T     approximation to the integral of f over (a,b)
%   t     vector of nodes used
%   y     vector of function values at nodes

h = (b-a)/n;
t = a + h*(0:n)';
y = f(t);
T = h * ( sum(y(2:n)) + 0.5*(y(1) + y(n+1)) ); 
