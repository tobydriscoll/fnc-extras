%%
% We use $n=3$ and $n=6$ with equally spaced nodes for the function
% $\sin(e^{2x})$ over $[0,1]$.

%%  
f = @(x) sin(exp(2*x));
fplot(f,[0,1]), hold on

t = linspace(0,1,4)'; 
p = polyinterp(t,f(t));
fplot(p,[0,1])

xlabel('x'), ylabel('f(x)')   % ignore this line
title('Interpolation on 4 nodes')    % ignore this line

%%
cla
fplot(f,[0,1]), hold on
t = linspace(0,1,7)'; 
p = polyinterp(t,f(t));
fplot(p,[0,1]);
title('Interpolation on 7 nodes')    % ignore this line

%%
% The curves always intersect at the interpolation nodes. 