
using LinearAlgebra

A = rand(1.:9.,4,4)
B = A + A'

cholesky(B)

B = A'*A
cf = cholesky(B)

R = Matrix(cf.U)

norm(R'*R - B)
