function [U,X,Y] = poissonfd(f,g,m,xspan,n,yspan)
%POISSONFD   Finite difference solution of the Poisson equation.
% Input:
%   f            forcing function (function of x,y)
%   g            boundary condition (function of x,y)
%   m            number of grid points in x (integer)
%   xspan        endpoints of the domain of x (2-vector)
%   n            number of grid points in y (integer)
%   yspan        endpoints of the domain of y (2-vector)
%
% Output:
%   U            solution (m+1 by n+1)
%   X,Y          grid matrices (m+1 by n+1)

% Initialize the rectangle discretization. 
[X,Y,Dx,Dxx,Dy,Dyy,vec,unvec,isB] = rectdisc(m,xspan,n,yspan);
Ix = speye(m+1);  Iy = speye(n+1);

% Form the collocated PDE as a linear system. Use negative sign to get
% positive definite matrix.
A = -kron(Iy,Dxx) - kron(Dyy,Ix);  % Laplacian matrix
b = -vec(f(X,Y));

% Replace collocation equations on the boundary.
scale = max(abs(A(n+2,:)));
A(isB,:) = 0;             % erase the equations
numB = nnz(isB);          % number of boundary points
A(isB,isB) = scale*speye(numB);     % Dirichet assignment
b(isB) = scale*g( X(isB),Y(isB) );  % assigned values

% Solve the linear sytem and reshape the output.
u = A\b;
U = unvec(u);

end