function p = horner(c,x)
% HORNER  Evaluate polynomial using Horner's rule. 
% Input:
%   c     Coefficients of polynomial, in descending order (vector)
%   x     Evaluation point (scalar)
% Output:
%   p     Value of the polynomial at x (scalar)

n = length(c);
p = c(1);
for k = 2:n
  p = x*p + c(k);
end
