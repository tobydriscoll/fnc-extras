
Smax = 8;  T = 6;
K = 3;  sigma = 0.06;  r = 0.08;

m = 200;  h = Smax / m;
x = h*(0:m)
n = 1000;  tau = T / n;
t = tau*(0:n)
lambda = tau / h^2;  mu = tau / h;

V = zeros(m+1,n+1)
V[:,1] = @. max( 0, x-K )
for j = 1:n
    # Fictitious value from Neumann condition.
    Vfict = 2*h + V[m,j]
    Vj = [ V[:,j]; Vfict ]
    # First row is zero by the Dirichlet condition.
    for i = 2:m+1 
        diff1 = (Vj[i+1] - Vj[i-1])
        diff2 = (Vj[i+1] - 2*Vj[i] + Vj[i-1])
        V[i,j+1] = Vj[i] +
            (lambda*sigma^2*x[i]^2/2)*diff2 +
            (r*x[i]*mu)/2*diff1 - r*tau*Vj[i]
    end   
end

select_times = @. 1 + 250*(0:4)
show_times = t[select_times]

using Plots
plot(x,V[:,select_times],label=["t=$t" for t in show_times], 
    title="Black-Scholes solution",leg=:topleft,  
    xaxis=("stock price"),yaxis=("option value") )

T = 8;
n = 1000;  tau = T / n;
t = tau*(0:n)
lambda = tau / h^2;  mu = tau / h;

for j = 1:n
    # Fictitious value from Neumann condition.
    Vfict = 2*h + V[m,j]
    Vj = [ V[:,j]; Vfict ]
    # First row is zero by the Dirichlet condition.
    for i = 2:m+1 
        diff1 = (Vj[i+1] - Vj[i-1])
        diff2 = (Vj[i+1] - 2*Vj[i] + Vj[i-1])
        V[i,j+1] = Vj[i] +
            (lambda*sigma^2*x[i]^2/2)*diff2 +
            (r*x[i]*mu)/2*diff1 - r*tau*Vj[i]
    end   
end


plot(x,V[:,select_times],label=["t=$t" for t in show_times], 
    title="Black-Scholes solution",leg=:topleft,  
    xaxis=("stock price"),yaxis=("option value",[0,1e20]) )
