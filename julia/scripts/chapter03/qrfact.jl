
using LinearAlgebra
A = rand(1.:9.,6,4)
@show m,n = size(A);

Q,R = qr(A);
Q

R

Matrix(Q)

QTQ = Q'*Q
norm(QTQ - I)

Matrix(Q)'*Matrix(Q) - I
