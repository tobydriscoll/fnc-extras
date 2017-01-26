function [X,Y,U] = fdelliptic(phi,g,init)
%FDELLIPTIC   Finite differences for a 2D elliptic PDE on [0,1]^2.
% Input:
%   phi      defines PDE, uxx+uyy = phi(x,y,u,ux,uy)  (function)
%   g        value of solution on boundary (function of x,y)
%   init     initial guess for the solution (matrix)
% Output:
%   X,Y      2D grid matrices 
%   U        values of solution on the grid (matrix)

m = size(init,1) - 1;  n = size(init,2) - 1;
[X,Y,Dx,Dxx,Dy,Dyy,isB] = rectdisc(m,n);
vec = @(U) U(:);   unvec = @(u) reshape(u,m+1,n+1);

u = levenberg(@residual,init);
u = u(:,end);
fprintf('Final residual norm: %.2e\n\n',norm( residual(u) ));
U = unvec(u);

    function f = residual(u)
        % Computes the difference between u'' and phi(x,u,u') at the
        % interior nodes and appends the error at the boundaries. 
        U = unvec(u);
        Ux = Dx*U;   Uxx = Dxx*U;         
        Uy = U*Dy';   Uyy = U*Dyy';         
        F = Uxx + Uyy - phi(X,Y,U,Ux,Uy);
        
        % Replace boundary locations with the Dirichlet conditions.
        F(isB) = U(isB) - g(X(isB),Y(isB));
        
        f = vec(F);
   end

end