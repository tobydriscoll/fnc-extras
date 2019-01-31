
include("../FNC.jl")
m = 40;  Dxx = FNC.diffper(m,[0,1])[3];

using LinearAlgebra
lambda = eigvals(Dxx)

using Plots
scatter(real(lambda),imag(lambda),m=2,
    xaxis=("Re \\lambda"),  yaxis=("Im \\lambda"),
    title="Eigenvalues",leg=:none)

phi = 2pi*(0:360)/360
z = @.exp(1im*phi) - 1;   # unit circle shifted to the left by 1

plot(Shape(real(z),imag(z)),color=RGB(.8,.8,1),aspect_ratio=1,
    xaxis=("Re \\lambda"),  yaxis=("Im \\lambda"),
    title="Stability region",leg=:none) 

lambda_min = minimum(lambda)
@show max_tau = -2 / lambda_min;

zeta = lambda*max_tau
scatter!(real(zeta),imag(zeta),
    title="Stability region and \\zeta  values")

plot(Shape([-6,6,6,-6],[-6,-6,6,6]),color=RGB(.8,.8,1),aspect_ratio=1)
z = @.exp(1im*phi) + 1;   # unit circle shifted right by 1
plot!(Shape(real(z),imag(z)),color=:white)
scatter!(real(zeta),imag(zeta),
    xaxis=([-4,2],"Re \\lambda"),  yaxis=([-3,3],"Im \\lambda"),
    title="Stability region and \\zeta values",leg=:none)
