function [t,u] = ie2(dudt,tspan,u0,n)
% IE2   The improved Euler method for an initial-value problem.
% Input:
%   dudt    f(t,u) for the ODE (function)
%   tspan   endpoints of time interval (2-vector)
%   u0      initial value (vector, length m)
%   n       number of time steps (integer)
% Output:
%   t       vector of times (vector, length N+1)
%   u       solution (array, (n+1)-by-m)

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