function [gamma,x] = inviter(A,s,numiter)
% INVITER   Shifted inverse iteration for the closest eigenvalue.
% Input:
%   A         square matrix
%   s         value close to targeted eigenvalue (complex scalar)
%   numiter   number of iterations
% Output: 
%   gamma     sequence of eigenvalue approximations (vector)
%   x         final eigenvector approximation

n = length(A);
x = randn(n,1);
x = x/norm(x,inf);
B = A - s*eye(n);
[L,U] = lu(B);
for k = 1:numiter
  y = U \ (L\x);
  [normy,m] = max(abs(y));
  gamma(k) = x(m)/y(m) + s;
  x = y/y(m);
end 
