
f = x -> x^2 - 4*x + 3.5
using Polynomials
@show r = roots(Poly([3.5,-4,1]));

g = x -> x - f(x);
x = 2.1; 
for k = 1:12
    x = [x;g(x[k])]
end
x

using Plots
err = @. abs(x-r[1])
plot(0:12,err,m=:o,
    leg=:none,xaxis=("iteration number"),yaxis=("error",:log10),title="Convergence of fixed point iteration")

p = polyfit(5:12,log.(err[5:12]),1)

sigma = exp(p.a[2])

@. err[9:12] / err[8:11]
