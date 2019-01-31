
f = x -> x*exp(x) - 2;
dfdx = x -> exp(x)*(x+1);

using NLsolve
r = nlsolve(x -> f(x[1]),[1.]).zero

x = [1;zeros(6)]
for k = 1:6
    x[k+1] = x[k] - f(x[k]) / dfdx(x[k])
end
x

err = @. x - r

logerr = @. log(abs(err))

using Plots
plot(0:6,abs.(err),m=:o,label="",
    xlabel="\$k\$",yaxis=(:log10,"\$|x_k-r|\$"),title="Quadratic convergence")
