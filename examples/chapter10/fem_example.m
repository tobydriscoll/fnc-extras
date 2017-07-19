%%
% The coefficient functions need to accept a vector input and return a
% vector of the same size. 
c = @(x) x.^2;
q = @(x) 4*ones(size(x));
f = @(x) sin(pi*x);

%%
[x,u] = fem(c,q,f,0,1,25);
plot(x,u), xlabel('x'), ylabel('u')
