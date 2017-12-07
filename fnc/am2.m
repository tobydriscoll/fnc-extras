function [t,u] = am2(dudt,tspan,u0,n)
% AM2    2nd-order Adams-Moulton (trapezoid) formula for an IVP.
% Input:
%   dudt    f(t,y) for the ODE (function)
%   tspan   endpoints of time interval (2-vector)
%   u0      initial value (m-vector)
%   n       number of time steps (integer)
% Output:
%   t       vector of times (vector, length n+1)
%   u       solution (array, size n+1 by m)

% Discretize time.
a = tspan(1);  b = tspan(2);
h = (b-a)/n;
t = tspan(1) + (0:n)'*h;

m = numel(u0);
u = zeros(m,n+1);
u(:,1) = u0(:);

% Time stepping.
for i = 1:n
  % Data that does not depend on the new value.
  known = u(:,i) + h/2*dudt(t(i),u(:,i));
  % Find a root for the new value. 
  unew = levenberg(@trapzero,known);
  u(:,i+1) = unew(:,end);
end

u = u.';   % conform to MATLAB output convention

    % This function defines the rootfinding problem at each step.
    function F = trapzero(z)
        F = z - h/2*dudt(t(i+1),z) - known;
    end

end  % main function