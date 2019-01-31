
A = [  2     4     4     2
       4     5     8    -5
       4     8     6     2
       2    -5     2   -26 ];

using LinearAlgebra
L1 = diagm(0=>ones(4))
L1[2:4,1] = [-2,-2,-1]
A1 = L1*A

A2 = (L1*A1')'

A2 = A1*L1'

L2 = diagm(0=>ones(4))
L2[3:4,2] = [0,-3]
A3 = L2*A2*L2'

L3 = diagm(0=>ones(4))
L3[4,3] = -1
D = L3*A3*L3'
