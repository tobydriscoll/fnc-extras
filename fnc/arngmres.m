function [x,residual] = arngmres(A,b,m)
% ARNGMRES   GMRES for a linear system (demo only).
% Input:
%   A       square matrix (n by n)
%   b       right-hand side (n by 1)
%   M       number of iterations
% Output: 
%   x       approximate solution (n by 1)
%   r       history of norms of the residuals

n = length(A);
Q = zeros(n,m+1);  
Q(:,1) = b/norm(b);
H = zeros(m+1,m);

% Initial "solution" is zero.
residual(1) = norm(b);

for j = 1:m

  % Next step of Arnoldi iteration.
  v = A*Q(:,j);
  for i = 1:j
      H(i,j) = Q(:,i)'*v;
      v = v - H(i,j)*Q(:,i);
  end
  H(j+1,j) = norm(v);
  Q(:,j+1) = v/H(j+1,j);
  
  % Solve the minimum residual problem.
  r = norm(b)*eye(j+1,1);
  z = H(1:j+1,1:j) \ r;
  x = Q(:,1:j)*z;
  residual(j+1) = norm( A*x - b );
  
end
