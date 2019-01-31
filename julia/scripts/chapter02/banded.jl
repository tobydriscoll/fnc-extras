
A = [ 2 -1  0  0  0  0
      4  2 -1  0  0  0
      0  3  0 -1  0  0
      0  0  2  2 -1  0
      0  0  0  1  1 -1
      0  0  0  0  0  2 ]

using LinearAlgebra
diag_main = diag(A,0)

diag_plusone = diag(A,1)

diag_minusone = diag(A,-1)

A = A + diagm(2=>[pi,8,6,7])

include("../FNC.jl")
L,U = FNC.lufact(A)
L

U
