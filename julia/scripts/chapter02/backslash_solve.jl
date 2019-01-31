
using LinearAlgebra

A = [1 0 -1; 2 2 1; -1 -3 0]

b = [1,2,3]

x = A\b

residual = b - A*x

A = [0 1; 0 0]
b = [1,-1]
x = A\b
