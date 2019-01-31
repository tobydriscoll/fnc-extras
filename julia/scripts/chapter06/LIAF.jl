
dudt = (u,t) -> u;
u_exact = exp;
a = 0.0;  b = 1.0;

n = [5,10,20,40,60]
err = zeros(size(n))
t = [];  u = [];
for (j,n) = enumerate(n)
    h = (b-a)/n
    t = [ a + i*h for i=0:n ]
    u = [1; u_exact(h); zeros(n-1)];
    f = [dudt(u[1],t[1]); zeros(n)];
    for i = 2:n
        f[i] = dudt(u[i],t[i])
        u[i+1] = -4*u[i] + 5*u[i-1] + h*(4*f[i]+2*f[i-1])
    end
    err[j] = abs(u_exact(b) - u[end])
end

using DataFrames
DataFrame(n=n,h=(b-a)./n,error=err)    

using Plots
plot(t,abs.(u),m=:o,label="",
    xlabel="t",yaxis=(:log10,"|u|"),title="LIAF solution")
