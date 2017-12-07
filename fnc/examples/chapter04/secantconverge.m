%%
% We check the convergence of the secant method from the previous example.
f = @(x) x.*exp(x) - 2;
x = secant(f,1,0.5);

%%
% We don't know the exact root, so we use the built-in |fzero| to get a
% substitute.
r = fzero(f,1);

%% 
% Here is the sequence of errors. 
format short e
err = r - x(1:end-1)'

%%
% It's not so easy to see the convergence rate by looking at these numbers.
% But we can check the ratios of the log of successive errors. 
logerr = log(abs(err));
ratios = logerr(2:end) ./ logerr(1:end-1)

%%
% It seems to be heading toward a constant ratio of about 1.6 by the time
% it quits.