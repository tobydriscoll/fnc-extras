%%
% This function is 2-periodic.
f = @(x) exp(sin(pi*x));
%%
% We can use $[-1,1]$ as a domain for it, but it extends to the entire real
% line by periodicity.
fplot(f,[-2.5 2.5]), hold on
plot([-1 -1],[0 3],'k--',[1 1],[0 3],'k--')
fplot(f,[-2.5 -1],'k')
fplot(f,[1 2.5],'k')
xlim([-2.5 2.5])

%%
% We discretize $[-1,1]$ with $N=11$ points. The discrete values are a
% periodic sequence. 
N = 11;  n = (N-1)/2;
t = 2*(-n:n)'/N;
y = f(t);
plot(t,y,'.')
plot(t-2,y,'k.',t+2,y,'k.')