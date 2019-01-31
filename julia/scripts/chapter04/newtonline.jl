
f = x -> x*exp(x) - 2

using Plots
plot(f,0,1.5,label="function",grid=:y,
    xlabel="x",ylabel="y",legend=:topleft)

x1 = 1
f1 = f(x1)
plot!([x1],[f1],m=:o,l=nothing,label="initial point")

dfdx = x -> exp(x)*(x+1)
slope1 = dfdx(x1)
tangent1 = x -> f1 + slope1*(x-x1)

plot!(tangent1,0,1.5,l=:dash,label="tangent line",ylim=[-2,4])

x2 = x1 - f1/slope1
plot!([x2],[0],m=:o,l=nothing,label="tangent root")

f2 = f(x2)

plot(f,0.83,0.88)
plot!([x2],[f2],m=:o,l=nothing)
slope2 = dfdx(x2)
tangent2 = x -> f2 + slope2*(x-x2)
plot!(tangent2,0.83,0.88,l=:dash)
x3 = x2 - f2/slope2
plot!([x3],[0],m=:o,l=nothing,
    legend=:none,xlabel="x",ylabel="y",title="Second iteration")

f3 = f(x3)
