function [I,x] = dequad(f,h,delta)
% DEQUAD  Doubly-exponential quadrature over (-1,1).
% Input:
%   f   integrand (callable function)
%   h   discretization step size 
%   K   number of nodes will be 2K+1
% Output:
%   I   approximation to int(f(x)) for x in (-1,1)
%   x   nodes used in the quadrature (vector)

% Change of coordinates.
phi = @(t) tanh(pi/2*sinh(t));
dphi = @(t) pi/2*cosh(t) ./ (cosh(pi/2*sinh(t)).^2);

K = ceil(log(-2/pi*log(delta/2))/h);  % truncation of trapezoid rule
t = h*(-K:K)';                        % nodes in t
x = phi(t);
I = h*sum( f(x).*dphi(t) );
