function [t,u] = ie2(dudt,tspan,u0,n)
% IE2    Improved Euler method for an IVP.
% Input:
%   dudt    defines f in u'(t)=f(t,u) (function)
%   tspan   endpoints of time interval (2-vector)
%   u0      initial value (vector, length m)
%   n       number of time steps (integer)
% Output:
%   t       selected nodes (vector, length N+1)
%   u       solution values (array, (n+1)-by-m)

% Time discretization.
a = tspan(1);  b = tspan(2);
h = (b-a)/n;   
t = a + h*(0:n)';

% Initialize solution array. 
u = zeros(length(u0),n+1);  
u(:,1) = u0;

% Time stepping. 
for i = 1:n 
    uhalf = u(:,i) + h/2 * dudt(t(i),u(:,i));
    u(:,i+1) = u(:,i) + h * dudt(t(i)+h/2,uhalf);
end

u = u.';   % conform with MATLAB output convention