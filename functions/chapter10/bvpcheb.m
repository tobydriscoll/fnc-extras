function [x,u,normr] = bvpcheb(phi,a,b,lbc,rbc,n)
%FDBVP    Solve a boundary-value problem, 2nd-order method.
% Input:
%   phi     function computing the RHS of the differential equation
%   a,b     endpoints of the domain 
%   lbc     left boundary condition (function of u(a),u'(a)) 
%   rbc     right boundary condition (function of u(b),u'(b))   
%   init    initial guess for the solution (length n+1 vector)
% Output:
%   x        nodes in x (vector, length n+1)
%   u        values of u(x)  (vector, length n+1)
%   normr    norm of the residual for the result (scalar)

[x,Dx,Dxx] = diffcheb(n,a,b);
h = mean(diff(x));
init = zeros(n+1,1);

u = levenberg(@residual,init,1e-12);
u = u(:,end);
normr = norm(residual(u));

    function f = residual(u)
        % Computes the difference between u'' and phi(x,u,u') at the
        % interior nodes and appends the error at the boundaries. 
        dudx = Dx*u;                   % discrete u'
        d2udx2 = Dxx*u;                % discrete u''
        f = d2udx2 - phi(x,u,dudx);
        
        % Replace first and last values by boundary conditions.
        f(1) = lbc(u(1),dudx(1))/h^2;
        f(n+1) = rbc(u(n+1),dudx(n+1))/h^2;
    end

end