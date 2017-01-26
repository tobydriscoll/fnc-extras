%%
% We try to estimate the derivative of $\cos(x^2)$ at $x=0.5$ using five
% nodes. 
t = [ 0.35 0.5 0.57 0.6 0.75 ]';   % nodes
f = @(x) cos(x.^2);
dfdx = @(x) -2*x.*sin(x.^2);
exact_value = dfdx(0.5)

%%
% We have to shift the nodes so that the point of estimation for the
% derivative is at $x=0$. 
w = fdweights(t-0.5,1);
fd_value = w'*f(t)

%%
% We can reproduce the weights in the finite difference tables by using
% equally spaced nodes with $h=1$. For example, here are two one-sided
% formulas.
format rat
fdweights(0:2,1)
fdweights(-3:0,1)