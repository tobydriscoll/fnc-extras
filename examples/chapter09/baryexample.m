%%
% We use $n=3$ and $n=6$ equally spaced nodes for the function
% $\sin(e^{2x})$ over $[0,1]$.

%%  
f = @(x) sin(exp(2*x));
x = linspace(0,1,1001)';
plot(x,f(x)), hold on

t = linspace(0,1,4)'; 
p = polyinterp(t,f(t));
plot(x,p(x))

t = linspace(0,1,7)'; 
p = polyinterp(t,f(t));
plot(x,p(x));

%%
% The curves always intersect at the interpolation nodes. 