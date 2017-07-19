function x = newton(f,dfdx,x1)
% NEWTON   Newton's method for a scalar equation.
% Input:
%   f        objective function 
%   dfdx     derivative function
%   x1       initial root approximation
% Output       
%   x        vector of root approximations (last one is best)

% Operating parameters.
funtol = 100*eps;  xtol = 100*eps;  maxiter = 40;

x = x1;  
y = f(x1);
dx = Inf;   % for initial pass below
k = 1;

while (abs(dx) > xtol) && (abs(y) > funtol) && (k < maxiter)
  dydx = dfdx(x(k));
  dx = -y/dydx;           % Newton step
  x(k+1) = x(k) + dx;

  k = k+1;
  y = f(x(k));
end

if k==maxiter, warning('Maximum number of iterations reached.'), end

