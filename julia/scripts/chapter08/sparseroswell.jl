
using JLD
vars = load("roswelladj.jld")       # get from the book's website
i = vars["i"];  j = vars["j"];

using SparseArrays
A = sparse(i,j,fill(1.0,size(i)),2790,2790)
varinfo(r"A")                       # to see memory consumption

m,n = size(A)
@show density = nnz(A) / (m*n);

F = Matrix(A)
varinfo(r"F")

@show storageratio = 154000/59e6;

x = randn(n)
@elapsed for i = 1:200; A*x; end

@elapsed for i = 1:200; F*x; end

v = A[:,1000]
println("time for replacing columns:")
@elapsed for i = 1:n; A[:,i]=v; end

r = v'
println("time for replacing rows:")
@elapsed for i = 1:n; A[i,:]=r; end
