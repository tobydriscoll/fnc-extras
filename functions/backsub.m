function x = backsub(U,b)
% BACKSUB   Solve an upper triangular linear system.
% Input:
%   U    upper triangular square matrix (n by n)
%   b    right-hand side vector (n by 1)   
% Output:
%   x    solution of Ux=b (n by 1 vector)

n = length(U);
x = zeros(n,1);
for i = n:-1:1
  x(i) = ( b(i) - U(i,i+1:n)*x(i+1:n) ) / U(i,i);
end
