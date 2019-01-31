
n = 20;
lambda = 1:n 

using LinearAlgebra
D = diagm(0=>lambda)
V,R = qr(randn(n,n))   # get a random orthogonal V
A = V*D*V';

R = x -> (x'*A*x)/(x'*x);
R(V[:,7])

delta = @. 1 ./10^(1:4)
quotient = zeros(size(delta))
for (k,delta) = enumerate(delta)
    e = randn(n);  e = delta*e/norm(e);
    x = V[:,7] + e
    quotient[k] = R(x)
end

using DataFrames
DataFrame(perturbation=delta,RQminus7=quotient.-7)
