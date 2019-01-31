
f = x -> x + cos(10*x);
interval = [0.5,1.5];

using Plots
plot(f,interval...,grid=:y,label="Function",
    legend=:bottomright,xlabel="x",ylabel="y")

using NLsolve
r = nlsolve(x->f(x[1]),[1.]).zero

x = [0.8,1.2,1]
y = @. f(x)
plot!(x,y,m=:o,l=nothing,label="initial points")

using Polynomials
q = polyfit(x,y,2);      # interpolating polynomial
plot!(x->q(x),interval...,l=:dash,label="interpolant",ylim=[-.1,3])

plot(f,interval...,grid=:y,label="Function",
    legend=:bottomright,xlabel="x",ylabel="y")
plot!(x,y,m=:o,l=nothing,label="initial points")

q = polyfit(y,x,2);      # interpolating polynomial
plot!(y->q(y),y->y,-.1,2.6,l=:dash,label="inverse interpolant")

@show x = [x; q(0)];
@show y = [y; f(x[end])];

for k = 4:8
    q = polyfit(y[k-2:k],x[k-2:k],2)
    x = [x; q(0)]
    y = [y; f(x[k+1])]
end

err = @. x - r

logerr = @. log(abs(err));
ratios = @. logerr[2:end] / logerr[1:end-1]
