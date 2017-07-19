function [x,Dx,Dxx] = diffmat2(n,xspan)
%DIFFMAT2   Second-order accurate differentiation matrices.
% Input:
%   n       number of subintervals (one less than the number of nodes)
%   xspan   interval endpoints
% Output:
%   x       equispaced nodes
%   Dx      matrix for first derivative 
%   Dxx     matrix for second derivative 

a = xspan(1);  b = xspan(2);
h = (b-a)/n;
x = a + h*(0:n)';   % nodes

% Define most of Dx by its diagonals.
dp = 0.5*ones(n,1)/h;       % superdiagonal
dm = -0.5*ones(n,1)/h;      % subdiagonal
Dx = diag(dm,-1) + diag(dp,1);

% Fix first and last rows.
Dx(1,1:3) = [-1.5,2,-0.5]/h;
Dx(n+1,n-1:n+1) = [0.5,-2,1.5]/h;

% Define most of Dxx by its diagonals.
d0 =  -2*ones(n+1,1)/h^2;   % main diagonal
dp =  ones(n,1)/h^2;        % superdiagonal and subdiagonal
Dxx = diag(dp,-1) + diag(d0) + diag(dp,1);

% Fix first and last rows.
Dxx(1,1:4) = [2,-5,4,-1]/h^2;
Dxx(n+1,n-2:n+1) = [-1,4,-5,2]/h^2;

end
    