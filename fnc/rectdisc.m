function [X,Y,disc] = rectdisc(m,xspan,n,yspan)
% RECTDISC   Discretization on a rectangle. 
% Input:
%   m        number of grid points in x (integer)
%   xspan    extent of domain in x direction (2-vector) 
%   n        number of grid points in y (integer)
%   yspan    extent of domain in y direction (2-vector) 
% Output:
%   X,Y      grid coordinate matrices (m+1 by n+1)
%   disc     discretization tools (structure)

% Initialize grid and finite differences. 
[x,Dx,Dxx] = diffmat2(m,xspan);
[y,Dy,Dyy] = diffmat2(n,yspan);
[X,Y] = ndgrid(x,y);

% Get the diff. matrices recognized as sparse. 
disc.Dx = sparse(Dx);   disc.Dxx = sparse(Dxx);  
disc.Dy = sparse(Dy);   disc.Dyy = sparse(Dyy);
disc.Ix = speye(m+1);   disc.Iy = speye(n+1);

% Locate boundary points.
disc.isbndy = true(m+1,n+1);
disc.isbndy(2:m,2:n) = false; 

disc.vec = @(U) U(:);
disc.unvec = @(u) reshape(u,m+1,n+1);

end