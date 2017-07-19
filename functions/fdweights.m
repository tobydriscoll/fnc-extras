function w = fdweights(t,m)
%FDWEIGHTS   Fornberg's algorithm for finite difference weights.
% Input:
%   t    nodes (vector, length r+1)
%   m    order of derivative sought at x=0 (integer scalar)
% Output:
%   w    weights for the approximation to the jth derivative (vector)

% This is a compact implementation, not an efficient one. 

r = length(t)-1;
w = zeros(size(t));
for k = 0:r
  w(k+1) = weight(t,m,r,k);
end


function c = weight(t,m,r,k)
% Implement a recursion for the weights.
% Input:
%   t   nodes (vector)
%   m   order of derivative sought 
%   r   number of nodes to use from t (<= length(t))
%   k   index of node whose weight is found 
% Output:
%   c   finite difference weight 

if (m<0) || (m>r)        % undefined coeffs must be zero
  c = 0;    
elseif (m==0) && (r==0)  % base case of one-point interpolation
  c = 1;   
else                     % generic recursion 
  if k<r
    c = (t(r+1)*weight(t,m,r-1,k) - ...
        m*weight(t,m-1,r-1,k))/(t(r+1)-t(k+1));
  else
    beta = prod(t(r)-t(1:r-1)) / prod(t(r+1)-t(1:r));
    c = beta*(m*weight(t,m-1,r-1,r-1) - t(r)*weight(t,m,r-1,r-1));
  end
end