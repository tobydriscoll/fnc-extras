function [I,x] = glint(f,n)
% GLINT  Gauss-Legendre numerical integration.
% Input:
%   f     integrand (function)
%   n     number of nodes (integer)
% Output:
%   I     estimate of integral(f,-1,1)
%   x     evaluation nodes of f (vector)

% Nodes and weights are found via a tridiagonal eigenvalue problem.
beta = 0.5./sqrt(1-(2*(1:n-1)).^(-2));
T = diag(beta,1) + diag(beta,-1);
[V,D] = eig(T);
x = diag(D); [x,idx] = sort(x);    % nodes
c = 2*V(1,idx).^2;                 % weights

% Evaluate the integrand and compute the integral.
I = c*f(x);      % vector inner product
