function [U,X,Y] = fdbvp2(phi,g,init)
%FDBVP2    Finite differences for an elliptic problem in [0,1]^2.
% Input:
%   phi      PDE: u_xx + u_yy = phi(x,y,u,du/dx,du/dy)
%   g        Boundary value on [0,1]x[0,1] (function of x and y)
%   init     initial guess for the solution (m+1-by-n+1 matrix)
% Output:
%   X,Y      grid in the unit square (matrices)
%   U        values of u(x) on the nodes

m = size(init,1) - 1;  n = size(init,2) - 1;
[X,Y,Dx,Dxx,Dy,Dyy,isB] = rectdisc(m,n);
vec = @(U) U(:);   unvec = @(u) reshape(u,m+1,n+1);

u = levenberg(@residual,init);
u = u(:,end);
fprintf('Final residual norm: %.2e\n\n',norm( residual(u) ));
U = unvec(u);

    function r = residual(u)
        % Computes the difference between u'' and phi(x,u,u') at the
        % interior nodes and appends the error at the boundaries. 
        U = unvec(u);
        Ux = Dx*U;   Uxx = Dxx*U;         
        Uy = U*Dy';   Uyy = U*Dyy';         
        R = Uxx + Uyy - phi(X,Y,U,Ux,Uy);
        
        % Replace boundary locations with the Dirichlet conditions.
        R(isB) = U(isB) - g(X(isB),Y(isB));
        
        r = vec(R);
   end

end