function x = lsqrfact(A,b)
% LSQRFACT   Solve linear least squares by QR factorization.
% Input: 
%   A     coefficient matrix (m by n, m>n)
%   b     right-hand side (m by 1)
% Output:
%   x     minimizer of || b-Ax ||

[Q,R] = qr(A,0);                        % compressed factorization
c = Q'*b;
x = backsub(R,c);                       
