function [I,x] = gquad(f,n)
% GQUAD  Gaussian quadrature over [-1,1].
% Input:
%   f     integrand (function)
%   n     one less than the number of nodes (even)
% Output:
%   I     estimate of int(f,-1..1)
%   x     evaluation nodes of f (vector, for information only)

% Nodes and weights are found via a tridiagonal eigenvalue problem.
beta = 0.5./sqrt(1-(2*(1:n-1)).^(-2));
T = diag(beta,1) + diag(beta,-1);
[V,D] = eig(T);
x = diag(D); [x,idx] = sort(x);    % nodes
c = 2*V(1,idx).^2;                 % weights

% Evaluate the integrand and compute the integral.
I = c*f(x);      % vector inner product
