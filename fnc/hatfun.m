function H = hatfun(x,t,k)
% HATFUN   Hat function/piecewise linear basis function.
% Input: 
%   x      evaluation points (vector)
%   t      interpolation nodes (vector, length n+1)
%   k      node index (integer, in 0,...,n)
% Output:
%   H      values of the kth hat function

n = length(t)-1;
k = k+1;  % adjust for starting with index=1

% Fictitious nodes to deal with first, last funcs.
t = [ 2*t(1)-t(2); t(:); 2*t(n+1)-t(n) ];
k = k+1;  % adjust index for the fictitious first node

H1 = (x-t(k-1))/(t(k)-t(k-1));   % upward slope
H2 = (t(k+1)-x)/(t(k+1)-t(k));   % downward slope

H = min(H1,H2);
H = max(0,H);
