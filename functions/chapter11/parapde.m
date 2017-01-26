function [U,x,t] = parapde(pdefun,bcfun,uinit,xspan,m,tspan,n)
%DIFFPER Differentiation matrices for periodic end conditions. 
% Input:
%   a    left endpoint
%   b    right endpoint
%   n    number of subintervals (one less than the number of nodes)
% Output:
%   t    equispaced nodes
%   Dx   matrix for first derivative 
%   Dxx  matrix for second derivative 

[x,Dx,Dxx] = diffmats(xspan(1),xspan(2),m);
t = linspace(tspan(1),tspan(2),n+1);

u0 = uinit(x);
[t,UI] = ode15s(@odefun,t,u0(2:m));

UI = UI.';           % rows are in x, columns are in t
z = zeros(1,size(UI,2));
U = [ z; UI; z ];    % make room for uB values
for j = 1:size(U,2)
    UB = bcfun(t,UI(:,j),Dx);
    U([1 m+1],j) = UB;
end

% Defines the interior ODE for the method of lines:
function fI = odefun(t,uI)
    uB = bcfun(t,uI,Dx);
    u = [uB(1);uI;uB(2)];
    f = pdefun(t,x,u,Dx,Dxx);
    fI = f(2:m);
end

end