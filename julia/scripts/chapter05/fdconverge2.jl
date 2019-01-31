
f = x -> sin( exp(x+1) );
exact_value = cos(exp(1))*exp(1);

h_ = @. 4. ^(-1:-1:-8)
FD1 = 0*h_;  FD2 = 0*h_;
for (k,h) = enumerate(h_)
    FD1[k] = (f(h) - f(0)) / h
    FD2[k] = (f(h) - f(-h)) / (2*h)
end

error_FD1 = @. exact_value-FD1 
error_FD2 = @. exact_value-FD2

using DataFrames
DataFrame(h=h_,error_FD1=error_FD1,error_FD2=error_FD2)   

using Plots
plot(h_,[abs.(error_FD1) abs.(error_FD2)],m=:o,label=["error FD1" "error FD2"],
    xflip=true,xaxis=(:log10,"\$h\$"),yaxis=(:log10,"error in \$f'(0)\$"),
    title="Convergence of finite differences",leg=:bottomleft)
plot!(h_,[h_ h_.^2],l=:dash,label=["order1" "order2"])      # perfect 1st and 2nd order 
