
f = x -> 3*cos(5*pi*x) - exp(2im*pi*x);

n = 10;  N = 2n+1;
t = [ 2j/N for j=0:N-1 ]      # nodes in [0,2)
y = f.(t);

using FFTW
c = fft(y)/N

k = [0:n;-n:-1]    # frequency ordering 

using Plots
scatter(k,real(c),
    xaxis=("\$k\$",[-n,n]),yaxis=("\$c_k\$",[-2,2]), 
    title="Interpolant coefficients",leg=:none)

f = x -> exp( sin(pi*x) );
c = fft(f.(t))/N

scatter(k,abs.(c),
    xaxis=("\$k\$",[-n,n]),yaxis=("\$|c_k|\$",:log10), 
    title="Fourier coefficients",leg=:none)
