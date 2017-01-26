function x = quasinewton(f,x0)
% QUASINEWTON  Quasi-Newton for nonlinear equations or least-squares.
% Input:
%   f        function that computes residual 
%   x0       initial root approximation
% Output       
%   x        array of approximations (one per column, last is best)

% Operating parameters.
fd_delta = 1e-9;
funtol = 10*fd_delta;  xtol = 10*fd_delta;  maxiter = 40;

x = x0(:);  r = f(x0);
h = Inf;    y = Inf;
k = 1;
Jk = fdjac(x(:,1),r,fd_delta);   % start with FD Jacobian

while (norm(h) > xtol) && (norm(y) > funtol)
  h = -(Jk\r);   % Newton step
  
  % Line search.
  decreased = false;  
  t = 2;  i = 1;
  while ~decreased && (i < 16) 
      t = t/2;
      xnew = x(:,k) + t*h;
      rnew = f(xnew);
      decreased = (norm(rnew) < norm(r));
      if t < 1e-3
          % Reset to use steepest descent instead.
          h = -Jk'*r;
          t = 1/norm(h);
      end
      i = i+1;
  end
  
  % Keep results.
  x(:,k+1) = xnew;
  y = rnew - r;
  r = rnew;
  i
  % Broyden update or new FD?
  if i < 6
      Jk = Jk + (y-t*Jk*h)*h'/(t*h'*h);
  else
      Jk = fdjac(xnew,rnew,fd_delta);
  end
  
  k = k+1;
  if k==maxiter
    warning('Maximum number of iterations reached.')
    break
  end
end

    % Finite-difference Jacobian calculation.
    function J = fdjac(x,fx,delta)
        m = length(fx);  n = length(x);
        J = zeros(m,n);  
        I = eye(n);
        for j = 1:n
            J(:,j) = ( f(x+delta*I(:,j)) - fx) / delta;
        end
    end

end

