
using DataFrames  # for tabular results

n = 6
A = randn(n,n)
x = ones(n)
y = zeros(n)
for i = 1:n
    for j = 1:n
        y[i] = y[i] + A[i,j]*x[j]   # 2 flops
    end
end

n = 400:400:4000
t = zeros(size(n))
for (i,n) in enumerate(n) 
    A = randn(n,n)  
    x = randn(n)
    t[i] = @elapsed for j = 1:10; A*x; end
end

DataFrame(size=n,time=t)
