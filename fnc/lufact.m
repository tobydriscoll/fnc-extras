function [L,U] = lufact(A)
% LUFACT   LU factorization (demo only--not stable!).
% Input:
%   A    square matrix
% Output:
%   L,U  unit lower triangular and upper triangular such that LU=A

n = length(A);
L = eye(n);   % ones on diagonal

% Gaussian elimination
for j = 1:n-1
  for i = j+1:n
    L(i,j) = A(i,j) / A(j,j);   % row multiplier
    A(i,j:n) = A(i,j:n) - L(i,j)*A(j,j:n);
  end
end

U = triu(A);
