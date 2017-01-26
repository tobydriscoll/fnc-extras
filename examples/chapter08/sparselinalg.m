%%
% There is a built-in way to generate a random sparse matrix with
% prescribed eigenvalues.
n = 3000;
density = 1.23e-3;
lambda = 1./(1:n);
A = sprandsym(n,density,lambda);
spy(A)
title('Sparse symmetric matrix')    % ignore this line

%%
eigs(A,5)    % largest magnitude

%%
eigs(A,5,0)  % closest to zero

%%
% The scaling of time to solve a sparse linear system is not easy to
% predict unless you have some more information about the matrix (such as
% bandedness). But it will typically be a great deal faster than the dense
% or full matrix case.
x = 1./(1:n)';  b = A*x;
tic, sparse_err = norm(x - A\b), sparse_time = toc

%%
A = full(A);
tic, dense_err = norm(x - A\b), dense_time = toc
