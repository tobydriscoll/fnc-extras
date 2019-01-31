
using Images,TestImages
img = testimage("mandrill");
@show m,n = size(img)

using Plots
plot(Gray.(img),title="Original image",aspect_ratio=1)

X = @. Float64(Gray(img))

using SparseArrays
B = spdiagm(0=>fill(0.5,m),1=>fill(0.25,m-1),-1=>fill(0.25,m-1));
C = spdiagm(0=>fill(0.5,n),1=>fill(0.25,n-1),-1=>fill(0.25,n-1));

blur = X -> B^12 * X * C^12;
plot(Gray.(blur(X)),title="Blurred image",aspect_ratio=1)
