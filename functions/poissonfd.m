function [U,X,Y] = poissonfd(f,g,m,xspan,n,yspan)
%POISSONFD   Solve Poisson's equation by finite differences.
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
[X,Y,d] = rectdisc(m,xspan,n,yspan);

% Form the collocated PDE as a linear system. 
A = kron(d.Iy,d.Dxx) + kron(d.Dyy,d.Ix);  % Laplacian matrix
b = d.vec(f(X,Y));

% Replace collocation equations on the boundary.
scale = max(abs(A(n+2,:)));
I = speye(size(A));
A(d.isbndy,:) = scale*I(d.isbndy,:);           % Dirichet assignment
b(d.isbndy) = scale*g( X(d.isbndy),Y(d.isbndy) );  % assigned values

% Solve the linear sytem and reshape the output.
u = A\b;
U = d.unvec(u);

end