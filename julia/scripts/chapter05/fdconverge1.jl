
f = x -> sin( exp(x+1) );
FD1 = [ (f(0.1)-f(0))   /0.1,
        (f(0.05)-f(0))  /0.05,
        (f(0.025)-f(0)) /0.025 ]

exact_value = cos(exp(1))*exp(1)
err = @. exact_value - FD1
