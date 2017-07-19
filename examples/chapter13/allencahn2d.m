function allencahn2d   % ignore this line


%% 
% The following function defines the PDE, by way of $\bm{f}(\bm{u})$ and its
% derivative.
    function [F,J] = pde(U,X,Y,d)
        LU = d.Dxx*U + U*d.Dyy';     % apply Laplacian
        F = U.*(1-U.^2) + 0.05*LU;   % residual 
        
        L = kron(d.Dyy,d.Ix) + kron(d.Iy,d.Dxx);
        u = d.vec(U);
        J = sparse( diag(1-3*u.^2) ) + 0.05*L;  % Jacobian
    end      

%%
% Now we solve and plot the result.
g = @(x,y) tanh(5*(x+2*y-1));    % boundary condition
[U,X,Y] = newtonpde(@pde,g,100,[0 1],100,[0 1]);
surf(X,Y,U)
view(32,18)    % ignore this line
shading flat    % ignore this line
xlabel x,  ylabel y    % ignore this line
title('Steady Allen-Cahn')    % ignore this line

end    % ignore this line