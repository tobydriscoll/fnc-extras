
using LinearAlgebra 
D = diagm(0=>[-6,-1,2,4,5])
V,R = qr(randn(5,5))
A = V*D*V';    # note that V' = inv(V)

Q,R = qr(A)
A = R*Q;

sort( eigvals(A) )

for k = 1:40
    Q,R = qr(A)
    A = R*Q
end
A
