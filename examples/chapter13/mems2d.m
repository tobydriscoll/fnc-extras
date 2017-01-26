function mems2d   % ignore this line


%% 
% This function defines the PDE, by way of f(u) and its derivative. 
lambda = 1.5;
    function [F,J] = pde(U,Dx,Dy,Dxx,Dyy)
        LU = Dxx*U + U*Dyy';         % Laplacian
        F = lambda./(U+1).^2 - LU;   % residual evaluation
        
        I = speye(length(Dx));
        L = kron(Dyy,I) + kron(I,Dxx);  % Laplacian matrix
        u = U(:);                       % same as vec(U)
        J = sparse( diag(-2*lambda./(u+1).^3) ) - L;
    end      

%%
% Solve, and plot the solution.
g = @(x,y) zeros(size(x));    % homogeneous boundary condition
[U,X,Y] = newtonpde(@pde,g,100,[0 2.5],80,[0 1]);
contourf(X,Y,U,12)
axis equal, colorbar    % ignore this line
xlabel x,  ylabel y    % ignore this line
title('Deflection of a MEMS membrane')    % ignore this line

end    % ignore this line