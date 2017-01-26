function [U,X,Y,normres] = poissoncg(f,g,n)
%POISSONKRY   Conjugate gradients for the Poisson equation.
%   Solves on the square [0,1] x [0,1].
% Input:
%   f            forcing function (function of x,y)
%   g            boundary condition (function of x,y)
%   n            number of grid points in each dimension
% Output:
%   U            solution (n+1 by n+1)
%   X,Y          grid matrices (n+1 by n+1)
%  NORMRES       history of norm(b-A*x) for the CG iteration

% Initialize grid and finite differences. 
[X,Y,Dx,Dxx,Dy,Dyy,isB] = rectdisc(n,n);
vec = @(U) U(:);  unvec = @(u) reshape(u,n+1,n+1);

% Evaluate forcing function on the grid, which becomes the right-hand side
% before boundary conditions are applied. 
F = f(X,Y);       
b = vec(F);

% Overwrite the boundary points with the prescribed values.
b(isB) = g( X(isB),Y(isB) );  

% This function applies the operator of the system to any given vector.
    function w = applypde(v)
        V = unvec(v);
        W = -Dxx*V - V*Dyy';
        W(isB) = V(isB);
        w = vec(W);   
    end

% Solve the linear sytem and reshape the output.
[u,~,~,~,normres] = pcg(@applypde,b,1e-12,400);
U = unvec(u);

end