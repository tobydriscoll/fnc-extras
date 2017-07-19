%%
% The |eig| command will give just the eigenvalues if one output is given,
% or both $\bm{V}$ and $\bm{D}$ if two are given.
A = pi*ones(2,2);
lambda = eig(A)

%%
[V,D] = eig(A)

%%
% We can check the fact that this is an EVD.
norm( A - V*D/V )   % /V is like *inv(V)

%%
% Even if the matrix is not diagonalizable, |eig| will run successfully,
% but the matrix $\bm{V}$ will not be invertible.
[V,D] = eig([1 1;0 1])
rankV = rank(V)