function x = levenberg(f,x1,tol)
% QUASINEWTON  Quasi-Newton for nonlinear equations or least-squares.
% Input:
%   f        objective function 
%   x1       initial root approximation
%   tol      stopping tolerance (default is 1e-12)
% Output       
%   x        array of approximations (one per column, last column is best)

% Operating parameters.
if nargin < 3, tol = 1e-12; end
ftol = tol;  xtol = tol;  maxiter = 40;

x = x1(:);     fk = f(x1);
k = 1;  s = Inf;        
Ak = fdjac(f,x(:,1),fk);   % start with FD Jacobian
is_fd = true;
I = eye(length(x));

lambda = 10; 
while (norm(s) > xtol) && (norm(fk) > ftol) && (k < maxiter)
    % Compute the proposed step.
    B = Ak'*Ak + lambda*I;
    z = Ak'*fk;
    s = -(B\z);

    xnew = x(:,k) + s;   fnew = f(xnew);
    
    % Do we accept the result?
    if norm(fnew) < norm(fk)    % accept
        y = fnew - fk;
        x(:,k+1) = xnew;  fk = fnew;  
        k = k+1;
        
        lambda = lambda/10;  % get closer to Newton
        % Broyden update of the Jacobian.
        Ak = Ak + (y-Ak*s)*(s'/(s'*s));
        is_fd = false;
    else                       % don't accept
        % Get closer to steepest descent.
        lambda = lambda*4;
        % Re-initialize the Jacobian if it's out of date.
        if ~is_fd
            Ak = fdjac(f,x(:,k),fk);
            is_fd = true;
        end
    end
end

if k==maxiter, warning('Maximum number of iterations reached.'), end

end

