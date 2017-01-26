%%
% We construct a real symmetric matrix with known eigenvalues by using the
% QR factorization to produce a random orthogonal set of eigenvectors. 
n = 30;
lambda = (1:n)';  
D = diag(lambda);
[V,R] = qr(randn(n));   % get a random orthogonal V
A = V*D*V';

%%
% The condition number of these eigenvalues is one. Thus the effect on them
% is bounded by the norm of the perturbation to $\mA$. 
for k = 1:3
    E = randn(n); E = 1e-4*E/norm(E);
    mu = sort(eig(A+E));
    max_change = norm(mu-lambda,inf)
end