%% 
% Here we evaluate the polynomial $p(x)=(x-1)^3=x^3-3x^2+3x-1$. First, we
% define a vector of its coefficients in descending degree order.
c = [ 1 -3 3 1];

%%
% Here is the evaluation at $x=1.2$.
y = horner(c,1.2)

%%
% The error in this result is calculated by
(1.2-1)^3 - y