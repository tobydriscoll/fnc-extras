%%
% Here is a simple trick for turning any square matrix into a symmetric one.
A = magic(5);
B = A+A'

%%
% Picking a symmetric matrix at random, there is little chance that it will
% be positive definite. Fortunately, the built-in Cholesky factorization
% @glsbegin@chol@glsend@ always detects this property. The following would cause an error if 
% run:

%%
% |R = chol(B)|     

%%
% There is a different trick for making an SPD matrix from (almost) any
% other matrix. 
B = A'*A

%%
R = chol(B)

%%
norm( R'*R - B )

%%
% A word of caution: |chol| does not check symmetry; in fact, it doesn't
% even look at the lower triangle of the input matrix.
chol( triu(B) )
