
A = [2 0 4 3; -4 5 -7 -10; 1 15 2 -4.5; -2 0 2 -13];

include("../FNC.jl")
L,U = FNC.lufact(A)

LtimesU = L*U

A - LtimesU

b = [4,9,29,40]
z = FNC.forwardsub(L,b)
x = FNC.backsub(U,z)

b - A*x
