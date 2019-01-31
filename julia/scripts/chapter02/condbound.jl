
using LinearAlgebra

A = [ 1/(i+j) for i=1:7, j=1:7 ]

kappa = cond(A)

x_exact = 1.:7.
b = A*x_exact

dA = randn(size(A));  dA = 1e-12*(dA/norm(dA));
db = randn(size(b));  db = 1e-12*(db/norm(db));

x = (A+dA) \ (b+db); 
dx = x - x_exact;

rel_error = norm(dx) / norm(x_exact)

@show b_bound = kappa * 1e-12/norm(b);
@show A_bound = kappa * 1e-12/norm(A);

x = A\b;
@show rel_error = norm(x - x_exact) / norm(x_exact);
@show rounding_bound = kappa*eps();

A = [ 1/(i+j) for i=1:14, j=1:14 ];
kappa = cond(A)

rounding_bound = kappa*eps()

x_exact = 1.:14.;
b = A*x_exact;  
x = A\b;

relative_error = norm(x_exact - x) / norm(x_exact)
