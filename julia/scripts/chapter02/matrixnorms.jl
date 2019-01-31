
A = [ 2  0; 1  -1 ]

using LinearAlgebra
twonorm = opnorm(A)

onenorm = opnorm(A,1)

maximum( sum(abs.(A),dims=1) )   # sum down the rows (1st matrix dimension)

infnorm = opnorm(A,Inf)

maximum( sum(abs.(A),dims=2) )   # sum across columns (2nd matrix dimension)

theta = 2*pi*(0:1/600:1)
x = @. [ cos(theta) sin(theta) ]'   # 601 unit columns

using Plots
plot(x[1,:],x[2,:],aspect_ratio=1,layout=(1,2),subplot=1,
    title="Unit circle",leg=:none,xlabel="\$x_1\$",ylabel="\$x_2\$")

Ax = A*x;

plot!(Ax[1,:],Ax[2,:],subplot=2,aspect_ratio=1,
    title="Image under map",leg=:none,xlabel="\$x_1\$",ylabel="\$x_2\$")
plot!(twonorm*x[1,:],twonorm*x[2,:],subplot=2,l=:dash)

