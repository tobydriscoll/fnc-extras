
f = x -> x^2*exp(-2*x);
a = 0;  b = 2; 
using QuadGK
I,errest = quadgk(f,a,b,atol=1e-14,rtol=1e-14)

N = 20;       # the coarsest formula
n = N;  h = (b-a)/n;
t = h*(0:n);   y = f.(t);

T = [h*( sum(y[2:n]) + y[1]/2 + y[n+1]/2 )]
err_2nd = I .- T

n = 2*n;  h = h/2;  t = h*(0:n);
T = [ T; T[1]/2 + h*sum( f.(t[2:2:n]) ) ]
err_2nd = I .- T

n = 2*n;  h = h/2;  t = h*(0:n);
T = [ T; T[2]/2 + h*sum( f.(t[2:2:n]) ) ]
err_2nd = I .- T

S = [ (4*T[i+1]-T[i])/3 for i=1:2 ]
err_4th = I .- S

R = (16*S[2] - S[1]) / 15
err_6th = I .- R
