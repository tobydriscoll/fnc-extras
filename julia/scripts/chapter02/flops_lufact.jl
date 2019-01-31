
using LinearAlgebra, Plots

n = 200:100:2400
t = zeros(size(n))
for (i,n) in enumerate(n) 
    A = randn(n,n)  
    t[i] = @elapsed for j = 1:6; lu(A); end
end

plot(n,t,m=:o,xaxis=(:log10,"\$n\$"),yaxis=(:log10,"elapsed time"),label="data")
plot!(n,(n/n[5]).^3*t[5],l=:dash,label="\$O(n^3)\$")
