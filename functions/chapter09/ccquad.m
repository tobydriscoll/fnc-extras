function [I,x] = ccquad(f,n)
% CCQUAD  Clenshaw-Curtis quadrature over [-1,1].
% Input:
%   f     integrand (function)
%   n     one less than the number of nodes (even)
% Output:
%   I     estimate of int(f,-1..1)
%   x     evaluation nodes of f (vector, for information only)

% Find Chebyshev extreme nodes.
theta = pi*(0:n)'/n;
x = -cos(theta);

% Compute the C-C weights.
c = zeros(1,n+1); 
c([1 n+1]) = 1/(n^2-1); 
theta = theta(2:n); 
v = ones(n-1,1);
for k = 1:n/2-1
  v = v - 2*cos(2*k*theta)/(4*k^2-1);
end
v = v - cos(n*theta)/(n^2-1);
c(2:n) = 2*v/n;

% Evaluate integrand and integral.
I = c*f(x);   % use vector inner product