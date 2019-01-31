
A = rand(1.:9.,6,4)
m,n = size(A)

z = A[:,1];

using LinearAlgebra
v = z - norm(z)*[1;zeros(m-1)]
P = I - 2/(v'*v)*(v*v')   # reflector

P*z

A = P*A

A[2:m,2:n]

z = A[2:m,2];
v = z - norm(z)*[1;zeros(m-2)];
P = I - 2/(v'*v)*(v*v');   

A[2:m,2:n] = P*A[2:m,2:n]
A

for j = 3:n
    z = A[j:m,j]
    v = z - norm(z)*[1;zeros(m-j)]
    P = I - 2/(v'*v)*(v*v')
    A[j:m,j:n] = P*A[j:m,j:n]
end

R = A
