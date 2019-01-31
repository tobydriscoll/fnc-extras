
f = x -> x*exp(x) - 2;

using Plots
plot(f,0.25,1.25,label="function",leg=:topleft)

x1 = 1;    f1 = f(x1);
x2 = 0.5;  f2 = f(x2);
plot!([x1,x2],[f1,f2],m=:o,l=nothing,label="initial points")

slope2 = (f2-f1) / (x2-x1);
secant2 = x -> f2 + slope2*(x-x2);
plot!(secant2,0.25,1.25,label="secant line",l=:dash,color=:black)

x3 = x2 - f2/slope2;
@show f3 = f(x3)
plot!([x3],[0],m=:o,l=nothing,label="root of secant")

slope3 = (f3-f2) / (x3-x2);
x4 = x3 - f3/slope3;
f4 = f(x4)
