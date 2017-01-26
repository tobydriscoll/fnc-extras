function [U,X,Y] = newtonpde(f,g,m,xspan,n,yspan)
%NEWTONPDE   Newton method for an elliptic PDE.
%   Solves on the square [0,1] x [0,1], zero Dirichlet conditions.
% Input:
%   f            defines the PDE, f(u)=0 (function of u and 4 derivs)
%   g            boundary condition (function of x,y)
%   n            number of grid points in each dimension (integer)
% Output:
%   U            solution (n+1 by n+1)
%   X,Y          grid matrices (n+1 by n+1)

% Discretization.
[X,Y,Dx,Dxx,Dy,Dyy,vec,unvec,isB] = rectdisc(n,xspan,n,yspan);
IB = speye(nnz(isB));   % Jacobian on boundary

% This evaluates the discretized PDE and its Jacobian, with all the
% boundary condition modifications applied.
    function [R,J] = collocate(U)
        [R,J] = f(U,Dx,Dy,Dxx,Dyy);
        scale = max(abs(J(:)));
        R(isB) = scale*(U(isB) - g( X(isB), Y(isB) ));
        J(isB,:) = 0;
        J(isB,isB) = scale*IB;
    end

% Intialize the Newton iteration.
U = zeros(size(X));
[R,J] = collocate(U);
newttol = 1e-10;  newtmax = 30;
s = Inf;  normR = norm(vec(R));  k = 1;
history = [ normR; zeros(newtmax,1) ];
I = speye(numel(U));

lambda = 10;

% Newton iteration
while (norm(s) > newttol) && (normR > newttol)
    s = -(J'*J + lambda*I) \ (J'*vec(R));
    
    Unew = U + unvec(s);
    [Rnew,Jnew] = collocate(Unew);
    
    if norm(vec(Rnew)) < normR
        lambda = lambda/6;
        U = Unew;  R = Rnew;  J = Jnew;
        normR = norm(vec(R));
        % Accept and update.
        k = k+1;   history(k) = normR;
        disp(['Norm of residual = ',num2str(normR)])
    else
        lambda = lambda*4;
    end
    
    if k==newtmax
        warning('Maximum number of Newton iterations reached.')
        break
    end
end

end