function advdiffsteady   % ignore this line


%% 
% The following function defines the PDE, by way of $\mathbf{f}(\mathbf{u})$ and
% its Jacobian.
    function [F,J] = pde(U,X,Y,d)
        LU = d.Dxx*U + U*d.Dyy';    % apply Laplacian
        F = 1 - d.Dx*U + 0.05*LU;   % residual 
        
        L = kron(d.Dyy,d.Ix) + kron(d.Iy,d.Dxx); 
        J = -kron(d.Iy,d.Dx) + 0.05*L;  % Jacobian
    end      

%%
% Now we solve and plot the result.
g = @(x,y) 0*x;    % boundary condition
[U,X,Y] = newtonpde(@pde,g,100,[-1,1],100,[-1,1]);
surf(X,Y,U)
view(24,26), axis equal, shading flat    % ignore this line
xlabel x,  ylabel y    % ignore this line
title('Steady advection-diffusion')    % ignore this line

end    % ignore this line
