function x = forwardsub(L,b)
% FORWARDSUB   Solve a lower triangular linear system.
% Input:
%   L    lower triangular square matrix (n by n)
%   b    right-hand side vector (n by 1)   
% Output:
%   x    solution of Lx=b (n by 1 vector)

n = length(L);
x = zeros(n,1);
for i = 1:n
  x(i) = ( b(i) - L(i,1:i-1)*x(1:i-1) ) / L(i,i);
end
