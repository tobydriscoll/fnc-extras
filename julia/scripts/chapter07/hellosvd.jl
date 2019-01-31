
using Plots
plot([],[],leg=:none,annotations=(0.5,0.5,text("Hello world",44,:center,:middle)),
    grid=:none,frame=:none)

savefig("hello.png")

using Images
img = load("hello.png")
A = @. Float64(Gray(img));
@show m,n = size(A);

using LinearAlgebra
U,sigma,V = svd(A)

scatter(sigma,m=(:o,2),
    title="Singular values",xaxis=("\$i\$"), yaxis=(:log10,"\$\\sigma_i\$"),leg=:none )

r = findlast(@.sigma/sigma[1] > 10*eps())

Ak = [ U[:,1:k]*diagm(0=>sigma[1:k])*V[:,1:k]' for k=2*(1:4) ]
reshape( [ @.Gray(Ak[i]) for i=1:4 ],2,2)

compression = 8*(m+n+1) / (m*n)
