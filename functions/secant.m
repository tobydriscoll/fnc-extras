function x = secant(f,x1,x2)
% SECANT   Secant method for a scalar equation.
% Input:
%   f        objective function 
%   x1,x2    initial root approximations
% Output       
%   x        vector of root approximations (last is best)

% Operating parameters.
funtol = 100*eps;  xtol = 100*eps;  maxiter = 40;

x = [x1 x2];
dx = Inf;  y1 = f(x1);
k = 2;  y2 = 100;

while (abs(dx) > xtol) && (abs(y2) > funtol) && (k < maxiter)
  y2 = f(x(k));
  dx = -y2 * (x(k)-x(k-1)) / (y2-y1);   % secant step
  x(k+1) = x(k) + dx;
  
  k = k+1;
  y1 = y2;    % current f-value becomes the old one next time    
end

if k==maxiter, warning('Maximum number of iterations reached.'), end
