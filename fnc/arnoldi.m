function [Q,H] = arnoldi(A,u,m)
% ARNOLDI   Arnoldi iteration for Krylov subspaces.
% Input:
%   A    square matrix (n by n)
%   u    initial vector
%   m    number of iterations
% Output: 
%   Q    orthonormal basis of Krylov space (n by m+1)
%   H    upper Hessenberg matrix, A*Q(:,1:m)=Q*H (m+1 by m)

n = length(A);
Q = zeros(n,m+1);  
H = zeros(m+1,m);
Q(:,1) = u/norm(u);
for j = 1:m
  % Find the new direction that extends the Krylov subspace.
  v = A*Q(:,j);
  % Remove the projections onto the previous vectors.
  for i = 1:j
    H(i,j) = Q(:,i)'*v;
    v = v - H(i,j)*Q(:,i);
  end
  % Normalize and store the new basis vector.
  H(j+1,j) = norm(v);
  Q(:,j+1) = v/H(j+1,j);
end
