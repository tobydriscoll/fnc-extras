function [I,x] = intde(f,h,M)
% INTDE   Doubly exponential integration over (-inf,inf).
% Input:
%   f   integrand (function)
%   h   discretization size (positive scalar)
%   M   truncation point of integral (positive scalar)
% Output:
%   I   approximation to intergal(f,-M,M)
%   x   evaluation nodes (vector)

% Find where to truncate the trapezoid sum. 
K = ceil( log(4/pi*log(2*M))/h );   

% Integrate in a transformed variable t.
t = h*(-K:K)';                    
x = sinh(pi/2*sinh(t));
dxdt = pi/2*cosh(t).*cosh(pi/2*sinh(t));

I = h*sum( f(x).*dxdt );
