
lambda = [1,-0.75,0.6,-0.4,0]

using LinearAlgebra
A = triu(ones(5,5),1) + diagm(0=>lambda)   # triangular matrix, eigs on diagonal

s = 0.7
x = ones(5)
y = (A-s*I)\x
gamma = x[1]/y[1] + s

s = gamma
x = y/y[1]
y = (A-s*I)\x;  gamma = x[1]/y[1] + s

for k = 1:4
    s = gamma  
    x = y/y[1]
    y = (A-s*I)\x  
    gamma = x[1]/y[1] + s
    @show gamma
end
