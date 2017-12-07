function [x,residual] = arngmres(A,b,M)
% ARNGMRES   GMRES for a linear system (demo only).
% Input:
%   A       square matrix (n by n)
%   b       right-hand side (n by 1)
%   M       number of iterations
% Output: 
%   x       approximate solution (n by 1)
%   r       history of norms of the residuals

n = length(A);
Q = zeros(n,M);  
Q(:,1) = b/norm(b);
H = zeros(M,M-1);

% Initial "solution" is zero.
residual(1) = norm(b);

for m = 1:M

  % Next step of Arnoldi iteration.
  v = A*Q(:,m);
  for i = 1:m
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
