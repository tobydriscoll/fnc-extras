function [I,x] = intde(f,h,M)
% INTDE Doubly-exponential integration over (-inf,inf).
% Input:
%   f   integrand (callable function)
%   h   discretization size 
%   M   truncation point of integral
% Output:
%   I   approximation to int(f(x)) for x in (-M,M)
%   x   evaluation nodes (vector)

% Find where to truncate the trapezoid sum. 
K = ceil(log(4/pi*log(2*M))/h);   

% Integrate in a new variable.
t = h*(-K:K)';                    
x = sinh(pi/2*sinh(t));
dxdt = pi/2*cosh(t).*cosh(pi/2*sinh(t));

I = h*sum( f(x).*dxdt );
