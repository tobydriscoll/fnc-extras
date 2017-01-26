function [U,x,t] = pdestiff(phi,xdomain,m,T,u0,lval,lder,rval,rder)
%
% Input:
%   phi         PDE is u_t = phi(x,t,u,ux,uxx)
%   xdomain     domain in x; interval, given as 2-vector
%   m           discretization size in space
%   T           final time; initial time is t=0
%   u0          initial value of u at t=0 (function)
%   lval,lder   left Dirichlet/Neumann boundary value (one should be [])
%   rval,rder   right Dirichlet/Neumann boundary value (one should be [])
%   
% Output:
%   U           (m+1)x(n+1) matrix of nodal values

[x,Dx,Dxx] = diffmats(xdomain(1),xdomain(2),m);
u0 = u0(x);    % discrete initial condition

% Use boundary conditions to find the values of u on the boundary:
    function u = extend(uI)
        % (works correctly only for 2nd order finite differences)
        u = zeros(m+1,1);
        u(2:m) = uI;
        if ~isempty(lval)   % Dirichlet at left
            u(1) = lval;  
        else                % Neumann at left
            u(1) = (lder - Dx(1,2)*u(2) - Dx(1,3)*u(3))/Dx(1,1);
        end
        if ~isempty(rval)   % Dirichlet at right
            u(m+1) = rval;  
        else                % Neumann at right
            u(m+1) = (rder - Dx(m+1,m-1)*u(m-1) - Dx(m+1,m)*u(m))/Dx(m+1,m+1);
        end
    end

% Define the interior ODE for the method of lines:
    function fI = odefun(t,uI)
        u = extend(uI);     % infer boundary values
        f = phi(x,t,u,Dx*u,Dxx*u);
        fI = f(2:m);        % restrict to interior
    end

% IVP solution using stiff solver.
[t,UI] = ode15s(@odefun,linspace(0,T,121),u0(2:m));

UI = UI.';           % rows vary in x, columns vary in t
nt = size(UI,2);
U = zeros(m+1,nt);   % incudes room for boundary values
for j = 1:nt
    U(:,j) = extend(UI(:,j));
end

end