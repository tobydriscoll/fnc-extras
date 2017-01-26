function [X,Y,Dx,Dxx,Dy,Dyy,vec,unvec,isbndy] = rectdisc(m,xspan,n,yspan)
% RECTDISC  Discretize the square [0,1]x[0,1] for PDE solution.
% Input:
%   m            number of grid points in x (integer)
%   xspan        endpoints of domain of x (2-vector)
%   n            number of grid points in y (integer)
%   yspan        endpoints of domain of y (2-vector)
% Output:
%  X,Y           grid coordinate matrices (m+1 by n+1)
%  Dx,Dxx        differentiation matrices in x (m+1 by n+1)
%  Dy,Dyy        differentiation matrices in y (m+1 by n+1)
%  vec           reshape matrix to vector (function)
%  unvec         reshape vector to matrix (function)
%  isbndy        logical indices for boundary points (m+1 by n+1)

% Initialize grid and finite differences. 
[x,Dx,Dxx] = diffmat2(m,xspan);
[y,Dy,Dyy] = diffmat2(n,yspan);
[X,Y] = ndgrid(x,y);

% Get the diff. matrices recognized as sparse. 
Dx = sparse(Dx);   Dxx = sparse(Dxx);  
Dy = sparse(Dy);   Dyy = sparse(Dyy);  

% Reshaping shortcuts.
vec = @(U) U(:);
unvec = @(u) reshape(u,m+1,n+1);

% Locate boundary points.
isbndy = false(m+1,n+1);  
isbndy([1 m+1],:) = true;
isbndy(:,[1 n+1]) = true;

end