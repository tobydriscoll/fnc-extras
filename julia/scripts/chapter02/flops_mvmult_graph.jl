
using LinearAlgebra, Plots

n = 400:200:6000
t = zeros(size(n))
for (i,n) in enumerate(n) 
    A = randn(n,n)  
    x = randn(n)
    t[i] = @elapsed for j = 1:10; A*x; end
end

plot(n,t,m=:o,xaxis=(:log10,"\$n\$"),yaxis=(:log10,"elapsed time (sec)"),
    title="Timing of matrix-vector multiplications",label="data",leg=false)

plot!(n,(n/n[1]).^2*t[1],l=:dash,label="\$O(n^3)\$",legend=:topleft)
