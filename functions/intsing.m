function [I,x] = intsing(f,h,delta)
% INTSING   Integrate function with endpoint singularities.
% Input:
%   f   integrand  (function)
%   h   discretization node spacing (positive scalar)
%   delta   distance away from endpoints (positive scalar)
% Output:
%   I   approximation to integral(f,-1+delta,1-delta)
%   x   evaluation nodes (vector)

% Find where to truncate the trapezoid sum.
K = ceil(log(-2/pi*log(delta/2))/h);  

% Integrate over a transformed variable. 
t = h*(-K:K)';                    
x = tanh(pi/2*sinh(t));
dxdt = pi/2*cosh(t) ./ (cosh(pi/2*sinh(t)).^2);

I = h*sum( f(x).*dxdt );

