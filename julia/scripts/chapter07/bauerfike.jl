
using LinearAlgebra

n = 15;
lambda = 1:n
A = triu( ones(n)*lambda' );
A[1:5,1:5]

lambda,V = eigen(A)
@show cond(V);

for k = 1:3
    E = randn(n,n);  E = 1e-7*E/opnorm(E);
    mu = eigvals(A+E)
    @show max_change = norm( sort(mu)-lambda, Inf )
end
