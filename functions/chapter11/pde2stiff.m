function [U,X,Y,t] = pde2stiff(phi,g,m,n,T,u0)
%
% Input:
%   phi         PDE is u_t = phi(x,t,u,ux,uxx,uy,uyy)
%   g           Dirichlet condition on the boundary of [0,1]^2
%   m,n         discretization sizes in x,y
%   T           final time; initial time is t=0
%   u0          initial value of u at t=0 (function of x,y)
%   
% Output:
%   U           (m+1)x(n+1)x81 array of nodal values

[X,Y,Dx,Dxx,Dy,Dyy,isB] = rectdisc(m,n);
vec = @(U) U(:);  unvec = @(u) reshape(u,m-1,n-1);  % interior points

% Use boundary conditions to find the values of u on the boundary:
    function U = extend(UI)
        % (works correctly only for 2nd order finite differences)
        U = zeros(m+1,n+1);
        U(2:m,2:n) = UI;
        U(isB) = g(X(isB),Y(isB));
    end

% Define the interior ODE for the method of lines:
    function fI = odefun(t,uI)
        U = extend(unvec(uI));     % infer boundary values
        F = phi(X,Y,t,U,Dx*U,Dxx*U,U*Dy',U*Dyy');
        fI = vec(F(2:m,2:n));      % restrict to interior
    end

% IVP solution using stiff solver.
U0 = u0(X,Y);          % discrete initial condition
nt = 81;               % number of time levels to output
[t,UI] = ode15s(@odefun,linspace(0,T,nt),vec(U0(2:m,2:n)));

% Reshape output into 3D array. 
UI = UI.';             % rows vary over space, columns vary over time
U = zeros(m+1,n+1,nt); % incudes room for boundary values
for j = 1:nt
    U(:,:,j) = extend(unvec(UI(:,j)));
end

end