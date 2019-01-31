
include("../FNC.jl")
for c = [2,4,7.5,11]
    f = x -> exp(x) - x - c;
    dfdx = x -> exp(x) - 1;
    x = FNC.newton(f,dfdx,1.0);  r = x[end];
    println("root with c = $c is $r")
end

c = 11;  f = x -> exp(x) - x - c;
@show f(0);

c = 100; 
@show f(0);
