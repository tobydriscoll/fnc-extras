
f = x -> (x+1)^2*cos((2*x+1)/(x-4.3))

using Plots
plot(f,0,4,label="",xlabel="x",ylabel="f(x)")

include("../FNC.jl")
n = @. 50*2^(0:3)
Tleft = []; Tright = [];
for (i,n) = enumerate(n)
    Tleft = [ Tleft; FNC.trapezoid(f,0,2,n)[1] ] 
    Tright = [ Tright; FNC.trapezoid(f,2,4,n)[1] ] 
end

using QuadGK
left_val,err = quadgk(f,0,2,atol=1e-14,rtol=1e-14)
right_val,err = quadgk(f,2,4,atol=1e-14,rtol=1e-14)

using DataFrames
DataFrame(n=n,left_error=Tleft.-left_val,right_error=Tright.-right_val)
