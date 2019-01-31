
using LinearAlgebra
t = range(0,stop=3,length=400)
A = [ sin.(t).^2 cos.((1+1e-7)*t).^2 t.^0 ]
kappa = cond(A)

x = [1.,2,1]
b = A*x;

x_BS = A\b
@show observed_err = norm(x_BS-x)/norm(x);
@show max_err = kappa*eps();

N = A'*A
x_NE = N\(A'*b)
@show observed_err = norm(x_NE-x)/norm(x)
@show digits = -log(10,observed_err)
