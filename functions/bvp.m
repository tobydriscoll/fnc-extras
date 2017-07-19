function [x,u] = bvp(phi,xspan,lval,lder,rval,rder,init)
%BVP      Solve a boundary-value problem by finite differences
%         with either Dirichlet or Neumann BCs.
% Input:
%   phi      defines u'' = phi(x,u,u') (function)
%   xspan    endpoints of the domain 
%   lval     prescribed value for u(a) (use [] if unknown) 
%   lder     prescribed value for u'(a) (use [] if unknown) 
%   rval     prescribed value for u(b) (use [] if unknown) 
%   rder     prescribed value for u'(b) (use [] if unknown) 
%   init     initial guess for the solution (length n+1 vector)
% Output:
%   x        nodes in x (vector, length n+1)
%   u        values of u(x)  (vector, length n+1)
%   res      function for computing the residual

n = length(init) - 1;
[x,Dx,Dxx] = diffmat2(n,xspan);
h = x(2)-x(1);

u = levenberg(@residual,init);
u = u(:,end);

    function f = residual(u)
        % Computes the difference between u'' and phi(x,u,u') at the
        % interior nodes and appends the error at the boundaries. 
        dudx = Dx*u;                   % discrete u'
        d2udx2 = Dxx*u;                % discrete u''
        f = d2udx2 - phi(x,u,dudx);
        
        % Replace first and last values by boundary conditions.
        if isempty(lder)    % u(a) given
            f(1) = (u(1) - lval)/h^2;
        else                % u'(a) given
            f(1) = (dudx(1) - lder)/h;
        end
        if isempty(rder)    % u(b) given
            f(n+1) = (u(n+1) - rval)/h^2;
        else                % u'(b) given
            f(n+1) = (dudx(n+1) - rder)/h;
        end
    end

end
