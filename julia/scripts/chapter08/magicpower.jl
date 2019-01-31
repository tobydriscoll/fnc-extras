
A = rand(1.:9.,5,5)
A = A./sum(A,dims=1)
x = randn(5)

y = A*x

z = A*y

for j = 1:8;  x = A*x;  end
[x A*x]

x = randn(5)
for j = 1:8;  x = A*x;  end
[x A*x]
