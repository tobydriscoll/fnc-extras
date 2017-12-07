%%
% We will confirm the Bauer-Fike theorem on a triangular matrix. These tend
% to be far from normal. 
n = 15;
lambda = (1:n)';
A = triu( ones(n,1)*lambda' );

%%
% The Bauer-Fike theorem provides an upper bound on the condition number of
% these eigenvalues.
[V,D] = eig(A); 
kappa = cond(V)

%%
% The theorem suggests that eigenvalue changes may be up to 7 orders of
% magnitude larger than a perturbation to the matrix. A few random
% experiments show that effects of nearly that size are not hard to
% observe.
for k = 1:3
    E = randn(n);  E = 1e-7*E/norm(E);
    mu = eig(A+E);
    max_change = norm( sort(mu)-lambda, inf )
end