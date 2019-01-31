
using Images,TestImages
img = testimage("mandrill");
m,n = size(img)

X = @. Float64(Gray(img))

using SparseArrays
B = spdiagm(0=>fill(0.5,m),1=>fill(0.25,m-1),-1=>fill(0.25,m-1));
C = spdiagm(0=>fill(0.5,n),1=>fill(0.25,n-1),-1=>fill(0.25,n-1));

blur = X -> B^12 * X * C^12;
Z = blur(X);

using LinearMaps
unvec = z -> reshape(z,m,n)
T = LinearMap(x -> vec(blur(unvec(x))),m*n);

using IterativeSolvers

y = gmres(T,vec(Z),maxiter=50,tol=1e-5);
Y = unvec(@.max(0,min(1,y)));

using Plots
plot(Gray.(X),layout=2,subplot=1,title="Original",aspect_ratio=1)
plot!(Gray.(Y),layout=2,subplot=2,title="Deblurred",aspect_ratio=1)
