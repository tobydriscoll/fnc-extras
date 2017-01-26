%%
% We construct an interpolant for $f(x)=\sin(e^{2x})$ on $[0,1]$. 
f = @(x) sin(exp(2*x));
fplot(f,[0,1]);

%%
% Choose $n=3$, or four equally spaced nodes, to get a cubic interpolant.
t = linspace(0,1,4)';  
y = f(t);

%%
% We use an advanced function, |bsxfun|, to help with the matrix
% construction.
V = bsxfun( @power, t, (0:3) );
c = V \ y;        % polynomial coefficients (low->high)

%%
% We can use the cofficients to construct a function for evaluating the
% interpolant.
c = c(end:-1:1);  % polynomial coefficients in MATLAB ordering
P = @(x) polyval(c,x);

%%
% The curves intersect at the four nodes. 
hold on, fplot(P,[0 1])
plot(t,y,'.')

%%
% That interpolant wasn't a very good one. Let's go to $n=7$. 
t = linspace(0,1,8)';  
y = f(t);
V = bsxfun( @power, t, (0:7) );
c = V \ y;       
c = c(end:-1:1); 
P = @(x) polyval(c,x);
fplot(P,[0 1])

%%
% There was substantial improvement in the quality of the approximation.