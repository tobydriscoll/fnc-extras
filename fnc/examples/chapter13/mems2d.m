function mems2d   % ignore this line


%% 
% This function defines the PDE, by way of $\mathbf{f}(\mathbf{u})$ and its
% derivative. Note that the function will have access to all of the
% properties of a discretization, as if they were returned by |rectdisc|.
lambda = 1.5;

    function [F,J] = pde(U,X,Y,d)
        LU = d.Dxx*U + U*d.Dyy';     % apply Laplacian
        F = LU - lambda./(U+1).^2;   % residual
        
        L = kron(d.Dyy,d.Ix) + kron(d.Iy,d.Dxx);  
        u = d.vec(U);
        J = L + sparse( diag(2*lambda./(u+1).^3) ); 
    end      

%%
% Now we solve and plot the result.
g = @(x,y) zeros(size(x));    % boundary condition
[U,X,Y] = newtonpde(@pde,g,100,[0 2.5],80,[0 1]);
surfl(X,Y,U), colormap copper
view(-38,10)    % ignore this line
axis equal, shading flat    % ignore this line
xlabel x,  ylabel y    % ignore this line
title('Deflection of a MEMS membrane')    % ignore this line

end    % ignore this line
