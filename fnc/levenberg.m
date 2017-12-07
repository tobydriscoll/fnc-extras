function x = levenberg(f,x1,tol)
% LEVENBERG   Quasi-Newton method for nonlinear systems.
% Input:
%   f         objective function 
%   x1        initial root approximation
%   tol       stopping tolerance (default is 1e-12)
% Output       
%   x         array of approximations (one per column)

% Operating parameters.
if nargin < 3, tol = 1e-12; end
ftol = tol;  xtol = tol;  maxiter = 40;

x = x1(:);     fk = f(x1);
k = 1;  s = Inf;        
Ak = fdjac(f,x(:,1),fk);   % start with FD Jacobian
jac_is_new = true;
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
        jac_is_new = false;
    else                       % don't accept
        % Get closer to steepest descent.
        lambda = lambda*4;
        % Re-initialize the Jacobian if it's out of date.
        if ~jac_is_new
            Ak = fdjac(f,x(:,k),fk);
            jac_is_new = true;
        end
    end
end

if (norm(fk) > 1e-3)
    warning('Iteration did not find a root.')
end

end

