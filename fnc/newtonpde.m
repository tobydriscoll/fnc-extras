function [U,X,Y] = newtonpde(f,g,m,xspan,n,yspan)
%NEWTONPDE   Newton's method to solve an elliptic PDE.
% Input:
%   f            defines the PDE, f(u)=0 (function)
%   g            boundary condition (function)
%   n            number of grid points in each dimension (integer)
% Output:
%   U            solution (n+1 by n+1)
%   X,Y          coordinate matrices (n+1 by n+1)

% Discretization.
[X,Y,d] = rectdisc(n,xspan,n,yspan);
I = speye((n+1)^2);   % used for row replacements 

% This evaluates the discretized PDE and its Jacobian, with all the
% boundary condition modifications applied.
    function [r,J] = residual(U)
        [R,J] = f(U,X,Y,d);
        scale = max(abs(J(:)));
        J(d.isbndy,:) = scale*I(d.isbndy,:);
        XB = X(d.isbndy);  YB = Y(d.isbndy);
        R(d.isbndy) = scale*(U(d.isbndy) - g(XB,YB));
        r = d.vec(R);
    end

% Intialize the Newton iteration.
U = zeros(size(X));
[r,J] = residual(U);
tol = 1e-10;  itermax = 20;
s = Inf;  normr = norm(r);  k = 1;
I = speye(numel(U));

lambda = 1;
while (norm(s) > tol) && (normr > tol)
    s = -(J'*J + lambda*I) \ (J'*r);  % damped step
    Unew = U + d.unvec(s);
    [rnew,Jnew] = residual(Unew);
    
    if norm(rnew) < normr
        % Accept and update.
        lambda = lambda/6;   % dampen the Newton step less
        U = Unew;  r = rnew;  J = Jnew;
        normr = norm(r);
        k = k+1;   
        disp(['Norm of residual = ',num2str(normr)])
    else
        % Reject. 
        lambda = lambda*4;   % dampen the Newton step more
    end
    
    if k==itermax
        warning('Maximum number of Newton iterations reached.')
        break
    end
end

end