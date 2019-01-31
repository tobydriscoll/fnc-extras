
A = rand(1.:9.,6,6)

using LinearAlgebra
u = randn(6)
Q = u/norm(u);

Aq = A*Q[:,1];

v = Aq - dot(Q[:,1],Aq)*Q[:,1]
Q = [Q v/norm(v)];

Aq = A*Q[:,2]
v = Aq - dot(Q[:,1],Aq)*Q[:,1] - dot(Q[:,2],Aq)*Q[:,2]
Q = [Q v/norm(v)];

opnorm( Q'*Q - I )

K = [ u A*u A*A*u ];
@show rank( [Q K] )
