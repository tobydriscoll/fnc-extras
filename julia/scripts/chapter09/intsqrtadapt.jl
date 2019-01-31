
include("../FNC.jl")
I,x = FNC.intadapt(sqrt,0,1,1e-10)
@show err = I - 2/3;
@show number_of_nodes = length(x);

I,x = FNC.intadapt(x -> 1/sqrt(x),eps(),1,1e-10)
@show err = I - 2;
@show number_of_nodes = length(x);

using Plots

scatter(x[1:end-1],diff(x),m=(1),
    xaxis=("x",:log10,[1e-15,1]),yaxis=(:log10,"distance",[1e-15,1]),
    title="Distance between nodes",leg=:none)
