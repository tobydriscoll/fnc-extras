
using MatrixDepot
A = matrixdepot("smallworld",200,4,0.2);

using Plots
spy(A,title="Nonzeros in A",color=:bluesreds)

spy(A^4,title="Nonzeros in A^4",color=:bluesreds)
