
A = [ -2 5; -1 0 ]

u0 = [1,0]
t = LinRange(0,6,600)     # times for plotting
u = zeros(length(t),length(u0))
for j=1:length(t)
    ut = exp(t[j]*A)*u0 
    u[j,:] = ut'
end

using Plots
plot(t,u,label=["\$u_1\$" "\$u_2\$"],xlabel="t",ylabel="u(t)")
