%%
% 
f = @(x) 1./sqrt(0.01+x.^2);
n = (10:10:50)';
x = linspace(0,1,1011)';
for k = 1:length(n) 
  t = linspace(0,1,n(k)+1)';        % equally spaced nodes
  y = f(t);                         % interpolation data
  p = polyinterp(t,y);
  semilogy( x, abs(f(x)-p(x)) );
  hold on, axis tight
end

%%
% There is much to see here. For an $x$ in the center of the interval, the
% gaps between the different $n$ are fairly uniform, indicating an
% exponential convergence rate again. The error there decreases until it
% reaches the limitations of machine precision. Near the boundaries,
% however, the error is virtually constant at around $10^{-3}$. 

