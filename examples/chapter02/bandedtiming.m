%%
% We'll use a large banded matrix to observe the speedup possible in LU
% factorization.
n = 8000;
A = diag(1:n) + diag(n-1:-1:1,1) + diag(ones(n-1,1),-1);

%%
% If we factor the matrix as is, MATLAB has no idea that it could be
% exploiting the fact that it is tridiagonal.
tic, [L,U] = lu(A); toc

%%
% But if we convert the matrix to a |sparse| one, the time required gets a
% lot smaller. 
tic, [L,U] = lu(sparse(A)); toc