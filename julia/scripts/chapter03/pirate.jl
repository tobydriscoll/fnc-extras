
a = [1/k^2 for k=1:100] 
s = cumsum(a)        # cumulative summation
p = @. sqrt(6*s)

using Plots,LaTeXStrings
plot(1:100,p,m=:o,leg=:none,xlabel=L"k",ylabel=L"p_k",title="Sequence convergence")

ep = @. abs(pi-p)    # error sequence
plot(1:100,ep,m=:o,l=nothing,
    leg=:none,xaxis=(:log10,L"k"),yaxis=(:log10,"error"),title="Convergence of errors")

k = 1:100
V = [ k.^0 log.(k) ]     # fitting matrix
c = V \ log.(ep)         # coefficients of linear fit

@show (a,b) = exp(c[1]),c[2];

plot!(k,a*k.^b,l=:dash)
