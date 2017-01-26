function x = lsnormal(A,b)
% LSNORMAL   Solve linear least squares by normal equations.
% Input: 
%   A     coefficient matrix (m by n, m>n)
%   b     right-hand side (m by 1)
% Output:
%   x     minimizer of || b-Ax ||

N = A'*A;  z = A'*b;
R = chol(N);
w = forwardsub(R',z);                   % solve R'z=c
x = backsub(R,w);                       % solve Rx=z
