
include("../FNC.jl")
x,Dx,Dxx = FNC.diffper(40,[0,1]);

using LinearAlgebra,Plots
tau = 0.1
for ep = [0.001 0.01 0.05]
  lambda = eigvals(-Dx + ep*Dxx)
  scatter!(real(tau*lambda),imag(tau*lambda),m=3,label="\\epsilon=$ep")
end
plot!([],[],label="",title="Eigenvalues for advection-diffusion",leg=:left,aspect_ratio=1)     
