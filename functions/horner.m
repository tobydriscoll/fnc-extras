function y = horner(c,x)
% HORNER   Evaluate a polynomial using Horner's rule. 
% Input:
%   c     Coefficients of polynomial, in descending order (vector)
%   x     Evaluation point (scalar)
% Output:
%   y     Value of the polynomial at x (scalar)

n = length(c);
y = c(1);
for k = 2:n
  y = x*y + c(k);
end
