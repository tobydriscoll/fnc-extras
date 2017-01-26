%% 
% Let's start with a known set of eigenvalues and an orthogonal eigenvector
% basis.
D = diag([-6 -1 2 4 5]);
[V,R] = qr(randn(5));
A = V*D*V';    % note that V' = inv(V)

%%
% Now we will take the QR factorization and just reverse the factors.
[Q,R] = qr(A);
A = R*Q;

%%
% It turns out that this is a similarity transformation, so the eigenvalues
% are unchanged.
eig(A)

%%
% What's remarkable is that if we repeat the transformation many times, the
% process converges to $\mD$. 
for k = 1:15
    [Q,R] = qr(A);
    A = R*Q;
end
A