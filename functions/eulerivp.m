function [t,u] = eulerivp(dudt,tspan,u0,n)
% EULERIVP   Euler's method for a scalar initial-value problem.
% Input:
%   dudt    defines f in u'(t)=f(t,u). (function)
%   tspan   endpoints of time interval (2-vector)
%   u0      initial value (scalar) 
%   n       number of time steps (integer)
% Output:
%   t       selected nodes  (vector, length n+1)
%   u       solution values   (vector, length n+1)

a = tspan(1);  b = tspan(2);
h = (b-a)/n;
t = a + (0:n)'*h;
u = zeros(n+1,1);
u(1) = u0;
for i = 1:n
  u(i+1) = u(i) + h*dudt(t(i),u(i));
end
