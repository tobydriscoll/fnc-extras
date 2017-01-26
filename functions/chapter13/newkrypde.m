function [U,X,Y] = newkrypde(f,g,n)
%NEWKRYPDE   Newton-Krylov method for an elliptic PDE.
%   Solves on the square [0,1] x [0,1], zero Dirichlet conditions.
% Input:
%   f            defines the PDE, f(u)=0 (function of u and 4 derivs)
%   g            boundary condition (function of x,y)
%   n            number of grid points in each dimension (integer)
% Output:
%   U            solution (n+1 by n+1)
%   X,Y          grid matrices (n+1 by n+1)

[X,Y,Dx,Dxx,Dy,Dyy,isB] = rectdisc(n,n);
vec = @(U) U(:);
unvec = @(u) reshape(u,n+1,n+1);

% Evaluates the discretized PDE with boundary condition.
    function [R,applyJ] = collocate(U)
        [R,applyJ] = f(U,Dx,Dy,Dxx,Dyy);
        R(isB) = U(isB) - g( X(isB), Y(isB) );
    end

U = zeros(size(X));
[R,applyJ] = collocate(U);
normR = norm(vec(R));
newttol = 1e-10;  newtmax = 16;
gmtol = 0.1;    gmmax = 2*n;
step = Inf;  k = 1;

while (norm(step) > newttol) && (normR > newttol)
  % GMRES iteration for Newton step
  tol = max(gmtol,0.9*newttol/normR);
  [step,~,relres] = gmres(@direcderiv,vec(R),gmmax,tol,1);
  S = unvec(step); 
  
  % Update.
  U = U - S;
  [R,applyJ] = collocate(U);
  gmtol = gmtol/10;
  normR = norm(vec(R));
  k = k+1;
  fprintf('GMRES residual = %.3e,   PDE residual norm = %.3e\n', ...
      relres*normR,normR)
  if k==newtmax
    warning('Maximum number of Newton iterations reached.')
    break
  end
end

% Evaluates the Jacobian applied in the direction of a vector v. 
    function w = direcderiv(v)
       w = applyJ(unvec(v));
       w(isB) = v(isB);            % boundary values
    end

end