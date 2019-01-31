
A = [i^j for i=1:5, j=0:3]

using LinearAlgebra
U,sigma,V = svd(A);

@show size(U),opnorm(U'*U - I);

@show size(V),opnorm(V'*V - I);

sigma

@show opnorm(A),sigma[1];

@show cond(A), sigma[1]/sigma[end];
