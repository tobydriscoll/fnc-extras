function [I,x] = dequadinf(f,h,M)
% DEQUADINF Doubly-exponential quadrature over (-inf,inf).
% Input:
%   f   integrand (callable function)
%   h   discretization size 
%   M   truncation point where |f(+-M)| is negligible
% Output:
%   I   approximation to int(f(x)) for x in (-inf,inf)
%   x   nodes used in the quadrature (vector)

% Change of coordinates.
phi = @(t) sinh(pi/2*sinh(t));
dphi = @(t) pi/2*cosh(t).*cosh(pi/2*sinh(t));

K = ceil(log(4/pi*log(2*M))/h);   % truncation of trapezoid rule
t = h*(-K:K)';                    % nodes in t
x = phi(t);
I = h*sum( f(x).*dphi(t) );
