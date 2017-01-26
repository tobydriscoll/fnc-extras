function x = newtondamped(f,dfdx,x0)
% NEWTONSYS   Newton's method for a system of equations.
% Input:
%   f        function that computes residual 
%   dfdx     function that computes the Jacobian matrix
%   x0       initial root approximation
% Output       
%   x        array of approximations (one per column, last is best)

% Operating parameters.
funtol = 1000*eps;  xtol = 1000*eps;  maxiter = 40;

x = x0(:);  
y = f(x0);
dx = Inf;
k = 1;
normresid = norm(y);

while (norm(dx) > xtol) && (norm(y) > funtol)
  Jn = dfdx(x(:,k));
  dx = -(Jn\y);   % Newton step
  x(:,k+1) = x(:,k) + dx;
  y = f(x(:,k+1));
  
  t = 1;
  while norm(y) >= normresid(k) && t>2^(-30)
      t = t/2;
        x(:,k+1) = x(:,k) + t*dx;
        y = f(x(:,k+1));
  end
  k = k+1;
  normresid = [normresid; norm(y)];
  if k==maxiter
    warning('Maximum number of iterations reached.')
    break
  end

end
