%%
% Let's observe the convergence of the forward-difference formula applied
% to the function $\sin(e^{x+1})$ at $x=0$. 
f = @(x) sin( exp(x+1) );
FD1 = [ (f(0.1)-f(0))   /0.1
        (f(0.05)-f(0))  /0.05
        (f(0.025)-f(0)) /0.025 ]

%%
% It's not clear that the sequence is converging. As predicted, however,
% the errors are cut approximately by a factor of 2 when $h$ is divided by
% 2.
exact_value = cos(exp(1))*exp(1);
err = exact_value - FD1

%%
% Asymptotically as $h\to0$, the error is proportional to $h$.