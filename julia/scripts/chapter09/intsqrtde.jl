
f = z -> sqrt((1+z)/2)

include("../FNC.jl")
I,z = FNC.intsing(f,0.1,1e-12)

@show err = I/2 - 2/3;
@show number_of_nodes = length(z);

f = z -> 1/sqrt((1+z)/2)

I,z = FNC.intsing(f,0.1,1e-14)

@show err = I/2 - 2;
@show number_of_nodes = length(z);
