
A = [2 0 4 3 ; -4 5 -7 -10 ; 1 15 2 -4.5 ; -2 0 2 -13];
b = [ 4, 9, 29, 40 ];

include("../FNC.jl")
L,U = FNC.lufact(A)
x = FNC.backsub( U, FNC.forwardsub(L,b) )

A[[2,4],:] = A[[4,2],:]  
b[[2,4]] = b[[4,2]]
x = A\b

L,U = FNC.lufact(A)
L
