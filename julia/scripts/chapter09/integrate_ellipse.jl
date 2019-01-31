
f(t) = pi*sqrt( cos(pi*t)^2+sin(pi*t)^2/4 );
N = 4:4:60
C = zeros(size(N))

for (i,N) = enumerate(N)
    h = 2/N
    t = @. h*(0:N-1)-1
    C[i] = h*sum(f.(t))
end
@show perimeter = C[end];

using Plots
err = @. abs(C-perimeter)
plot(N,err,m=3,
    title="Convergence of perimeter calculation",leg=:none,
    xaxis=("number of nodes"), yaxis=(:log10,"error",[1e-15,1]) )
