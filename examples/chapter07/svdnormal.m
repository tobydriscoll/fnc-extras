%%
% The following matrix is not hermitian.
A = [0 2; -2 0]

%%
% It has an eigenvalue decomposition with a unitary matrix of eigenvectors,
% though, so it is normal. 
[V,D] = eig(A);
norm( V'*V - eye(2) )

%%
% The eigenvalues are pure imaginary.
lambda = diag(D)

%%
% The singular values are the complex magnitudes of the eigenvalues.
svd(A)