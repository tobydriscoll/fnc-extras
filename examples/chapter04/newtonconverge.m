%%
% We again look at finding a solution of $xe^x=2$ near $x=1$. To apply Newton's method, we need to calculate values of both the residual function $f$ and its derivative.  
f = @(x) x.*exp(x) - 2;
dfdx = @(x) exp(x).*(x+1);

%%
% We don't know the exact root, so we use the built-in |fzero| to determine the
% 'true' value.
format long,  r = fzero(f,1)

%%
% We use $x_1=1$ as a starting guess and apply the iteration in a loop,
% storing the sequence of iterates in a vector.
x = 1;
for k = 1:6
    x(k+1) = x(k) - f(x(k)) / dfdx(x(k));
end

%% 
% Here is the sequence of errors (leaving out the last value, now serving
% as our exact root). 
format short e
err = x - r

%%
% Glancing at the exponents of the errors, they form a neat doubling
% sequence until the error is comparable to machine precision. We can see
% this more precisely by taking logs.
format short
logerr = log(abs(err))

%%
% Quadratic convergence isn't so easy to spot graphically.  
semilogy(abs(err),'.-')

%%
% It looks faster than linear convergence, but it's not easy to
% say more. If we could use infinite precision, the curve would continue to
% steepen forever.