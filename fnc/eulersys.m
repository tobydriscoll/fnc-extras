function [t,u] = eulersys(dudt,tspan,u0,n)
% EULERSYS   Euler's method for a first-order IVP system.
% Input:
%   dudt    defines f in u'(t)=f(t,u) (function)
%   tspan   endpoints of time interval (2-vector)
%   u0      initial value (vector, length m)
%   n       number of time steps (integer)
% Output:
%   t       selected nodes  (vector, length n+1)
%   u       solution values   (array, (n+1)-by-m)

% Time discretization.
a = tspan(1);  b = tspan(2);
h = (b-a)/n;
t = a + (0:n)'*h;

% Initial condition and output setup.
m = length(u0);
u = zeros(m,n+1);
u(:,1) = u0(:);

% The time stepping iteration. 
for i = 1:n
    u(:,i+1) = u(:,i) + h*dudt(t(i),u(:,i));
end

% This line makes the output conform to MATLAB conventions. 
u = u.';
