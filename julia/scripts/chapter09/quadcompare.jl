
f(x) = 1/(1+4*x^2);
exact = atan(2);

include("../FNC.jl")
n = 8:4:96
errCC = zeros(size(n))
errGL = zeros(size(n))
for (k,n) = enumerate(n)
  errCC[k] = exact - FNC.ccint(f,n)[1]
  errGL[k] = exact - FNC.glint(f,n)[1]
end

using Plots
plot(n,[abs.(errCC) abs.(errGL)],m=3,label=["CC" "GL"],
    xaxis=("number of nodes"), yaxis=(:log10,"error",[1e-16,1]), title="Spectral integration")

f(x) = 1/(1+16*x^2);
exact = atan(4)/2;

n = 8:4:96
errCC = zeros(size(n))
errGL = zeros(size(n))
for (k,n) = enumerate(n)
  errCC[k] = exact - FNC.ccint(f,n)[1]
  errGL[k] = exact - FNC.glint(f,n)[1]
end

using Plots
plot(n,[abs.(errCC) abs.(errGL)],m=3,label=["CC" "GL"],
    xaxis=("number of nodes"), yaxis=(:log10,"error",[1e-16,1]), title="Spectral integration")

tol = 10 .^(-2.0:-2:-14)
n = zeros(size(tol))  
errAdapt = zeros(size(tol))
for (k,tol) = enumerate(tol)
  Q,t = FNC.intadapt(f,-1,1,tol)
  errAdapt[k] = exact - Q
  n[k] = length(t)
end

plot!(n,abs.(errAdapt),m=3,label="intadapt")
plot!(n,n.^(-4),l=:dash,label="4th order",
        xaxis=(:log10), title="Spectral vs 4th order" )
