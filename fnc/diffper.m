function [x,Dx,Dxx] = diffper(n,xspan)
%DIFFPER   Differentiation matrices for periodic end conditions. 
% Input:
%   n      number of subintervals (integer)
%   xspan  endpoints of domain (vector)
% Output:
%   x    equispaced nodes (length n)
%   Dx   matrix for first derivative (n by n)
%   Dxx  matrix for second derivative (n by n)

a = xspan(1);  b = xspan(2);
h = (b-a)/n;
x = a + h*(0:n-1)';   % nodes, omitting the repeated data

% Construct Dx by diagonals, then correct the corners.
dp = 0.5*ones(n-1,1)/h;      % superdiagonal
dm = -0.5*ones(n-1,1)/h;     % subdiagonal
Dx = diag(dm,-1) + diag(dp,1);
Dx(1,n) = -1/(2*h);
Dx(n,1) = 1/(2*h);

% Construct Dxx by diagonals, then correct the corners.
d0 =  -2*ones(n,1)/h^2;      % main diagonal
dp =  ones(n-1,1)/h^2;       % superdiagonal
dm =  dp;                    % subdiagonal
Dxx = diag(dm,-1) + diag(d0) + diag(dp,1);
Dxx(1,n) = 1/(h^2);
Dxx(n,1) = 1/(h^2);

end
    