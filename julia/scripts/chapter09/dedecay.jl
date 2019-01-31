
f = x -> 1/(1+x^2)
x = t -> sinh(pi*sinh(t)/2);
chain = t -> pi/2*cosh(t)*cosh(pi*sinh(t)/2);
integrand = t -> f(x(t))*chain(t);

using Plots
plot(integrand,-4,4,
    xaxis=("t"),yaxis=(:log10,"f(x(t))"),
    title="Doubly exponential integrand decay",leg=:none)
