%%
% We verify some of the fundamental SVD properties using the built-in
% MATLAB command |svd|.
A = vander(1:5);
A = A(:,1:4)

%%
[U,S,V] = svd(A);
norm(U'*U - eye(5))

%%
norm(V'*V - eye(4))

%%
sigma = diag(S)

%%
[ norm(A) sigma(1) ]

%%
[ cond(A) sigma(1)/sigma(4) ]

