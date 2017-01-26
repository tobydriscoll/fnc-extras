%%
% Here is the system that "broke" LU factorization for us.
A = [ 2 0 4 3; -2 0 2 -13 ; 1 15 2 -4.5 ; -4 5 -7 -10 ];
b = [ 4; 40; 29; 9 ];

%%
% When we use the built-in |lu| function with three outputs, we get the
% elements of the PLU factorization.
[L,U,P] = lu(A)

%%
% We can solve this as before by incorporating the permutation. 
x = backsub( U, forwardsub(L,P*b) )

%%
% However, if we use just two outputs with |lu|, we get
% $\mathbf{P}^T\mathbf{L}$ as the first result.
[PtL,U] = lu(A)

%%
% MATLAB has engineered the backslash so that systems with triangular _or
% permuted triangular_ structure are solved with the appropriate style of
% triangular substitution.
x = U \ (PtL\b)

%%
% The pivoted factorization and triangular substitutions are done silently
% and automatically when backslash is called on the original matrix (for
% most matrix types). 
x = A\b

