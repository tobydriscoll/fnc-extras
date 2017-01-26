%%
% Here we look for a root of $x+\cos(10x)$ that is close to 1. 
f = @(x) x + cos(10*x);
interval = [0.5,1.5];
fplot(f,interval)
set(gca,'ygrid','on'), axis(axis)   % ignore this line
format long, r = fzero(f,1)

%%
% We choose three values to get the iteration started.
x = [0.8 1.2 1]';
y = f(x);
hold on, plot(x,y,'.')

%%
% If we were using "forward" interpolation, we would ask for the polynomial
% interpolant of $y$ as a function of $x$. But that parabola has no real
% roots. 
c = polyfit(x,y,2);    % coefficients of interpolating polynomial
q = @(x) polyval(c,x);
fplot(q,interval,'k--')

%%
% To do inverse interpolation, we swap the roles of $x$ and $y$ in the
% interpolation.
c = polyfit(y,x,2);    % coefficients of interpolating polynomial
q = @(y) polyval(c,y);
fplot(q,@(y) y,ylim,'r')    % plot x=q(y), y=y

%%
% We seek the value of $x$ that makes $y$ zero. This means evaluating $q$
% at zero, not finding a root like we did in the Newton and secant cases. 
x = [x; q(0)];
y = [y; f(x(end))]


%%
% We repeat the process a few more times.
for k = 4:8
    c = polyfit(y(k-2:k),x(k-2:k),2);
    x(k+1) = polyval(c,0);
    y(k+1) = f(x(k+1));
end

%%
% Here is the sequence of errors.
format short e
err = x - r

%%
% The error seems to be superlinear, but subquadratic.
logerr = log(abs(err));
ratios = logerr(2:end) ./ logerr(1:end-1)
