
f(x,y) = x^2 - y + 2;

include("../FNC.jl")
m = 5;  n = 6;
X,Y,d = FNC.rectdisc(m,[0,3],n,[-1,1]);

F = f.(X,Y);      

A = kron(d.Iy,d.Dxx) + kron(d.Dyy,d.Ix);

using Plots,SparseArrays
spy(sparse(A),m=3,color=:reds,title="Matrix before BC")

b = d.vec(F);
@show N = length(b);

spy(sparse(d.isbndy),m=5,color=:reds,title="Boundary points")
plot!([],label="",grid=:xy,xaxis=([0,8]),yaxis=([0,7]))

I = spdiagm(0=>ones(size(A,1)))
A[d.isbndy[:],:] = I[d.isbndy[:],:]   # Dirichlet conditions
spy(sparse(A),m=3,color=:reds,title="Matrix with BC")    

b[d.isbndy[:]] .= 0;                 # Dirichlet values

u = A\b;
U = d.unvec(u);

wireframe(X[:,1],Y[1,:],U,match_dimensions=true,
    xaxis=("x"),yaxis=("y"),zaxis=("u(x,y)"),title="Coarse solution")
