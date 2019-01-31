
n = 30;
lambda = 1:n 

using LinearAlgebra
D = diagm(0=>lambda)
V,R = qr(randn(n,n))   # get a random orthogonal V
A = V*D*V';

for k = 1:3
    E = randn(n,n); E = 1e-4*E/opnorm(E);
    mu = sort(eigvals(A+E))
    @show max_change = norm(mu-lambda,Inf)
end
