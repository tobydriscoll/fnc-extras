%%
% We use |eig| to compute the eigenvalues of the matrix $\mA$.
A = magic(5)/65;
lambda = eig(A)

%%
% As you can see, $1$ is the largest (whether or not we take their absolute
% values). This suggests that we can indeed find a nonzero solution of
% $\bfx=\mA\bfx$. 

%%
% We can use a different form of the command to get the eigenvalues too.
[V,D] = eig(A);

%%
% The eigenvectors are the columns of the matrix $\mV$, going in the same
% order as the eigenvalues found on the diagonal of $\mD$.
lambda = diag(D)

%%
v1 = V(:,1)
