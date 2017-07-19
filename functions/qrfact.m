function [Q,R] = qrfact(A)
% QRFACT   QR factorization by Householder reflections.
% (demo only--not efficient)
% Input:
%   A      m-by-n matrix
% Output:
%   Q,R    A=QR, Q m-by-m orthogonal, R m-by-n upper triangular

[m,n] = size(A);
Q = eye(m);
for k = 1:n
  z = A(k:m,k);
  v = [ -sign(z(1))*norm(z) - z(1); -z(2:end) ];
  nrmv = norm(v);
  if nrmv < eps, continue, end       % nothing is done in this iteration
  v = v / nrmv;                      % removes v'*v in other formulas
  % Apply the reflection to each relevant column of A and Q
  for j = 1:n
    A(k:m,j) = A(k:m,j) - v*( 2*(v'*A(k:m,j)) );
  end
  for j = 1:m
    Q(k:m,j) = Q(k:m,j) - v*( 2*(v'*Q(k:m,j)) );
  end
end

Q = Q';
R = triu(A);                         % enforce exact triangularity
