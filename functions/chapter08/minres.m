function [x,residual] = minres(A,b,M)
% MINRES   MINRES for a symmetric/hermitian system (demo only).
% Input:
%   A       square matrix (n by n), A'=A
%   b       right-hand side
%   M       number of iterations
% Output: 
%   x       approximate solution
%   r       history of norms of the residuals

n = length(A);
Q = zeros(n,M);  
Q(:,1) = b/norm(b);
H = zeros(M,M-1);

% Initial "solution" is zero.
residual(1) = norm(b);

for m = 1:M

  % Next step of Lanczos iteration.
  v = A*Q(:,m);
  for i = max(1,m-1):m
      H(i,m) = Q(:,i)'*v;
      v = v - H(i,m)*Q(:,i);
  end
  H(m+1,m) = norm(v);
  Q(:,m+1) = v/H(m+1,m);
  
  % Solve the minimum residual problem.
  r = norm(b)*eye(m+1,1);
  z = H(1:m+1,1:m) \ r;
  x = Q(:,1:m)*z;
  residual(m+1) = norm( A*x - b );
  
end
