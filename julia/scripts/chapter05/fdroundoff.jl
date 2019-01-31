
using LinearAlgebra   # for dot products
h = @. 1/10^(1:12)
f = x -> exp(-1.3*x);
fd1 = zeros(size(h))
fd2 = zeros(size(h))
fd4 = zeros(size(h))
for (j,h) = enumerate(h) 
    nodes = h*(-2:2)
    vals = @. f(nodes)/h
    fd1[j] = dot([   0    0 -1    1     0],vals)
    fd2[j] = dot([   0 -1/2  0  1/2     0],vals)
    fd4[j] = dot([1/12 -2/3  0  2/3 -1/12],vals)
end

using Plots
plot(h,abs.(fd1.+1.3),m=:o,label="FD1",
    xaxis=(:log10,"\$h\$"),xflip=true,yaxis=(:log10,"total error"),
    title="FD error with roundoff",legend=:bottomright)
plot!(h,abs.(fd2.+1.3),m=:o,label="FD2")
plot!(h,abs.(fd4.+1.3),m=:o,label="FD4")
plot!(h,0.1*eps()./h,l=:dash,color=:black,label="\$O(h^{-1})\$")
