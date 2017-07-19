%%
n = 18;
t = linspace(-1,1,n+1)';  
I = eye(n+1);
y = I(:,10);  % 10th cardinal function
plot(t,y,'.')
hold on, plot(x,interp1(t,y,x,'cubic'))
title('Piecewise cubic cardinal function')   % ignore this line
xlabel('x'), ylabel('p(x)')   % ignore this line

%%
% By design, the piecewise cubic cardinal function stays strictly between
% zero and one, ensuring a good condition number for the interpolation. But
% the story for global polynomials is very different.
clf, plot(t,y,'.')    % ignore this line
c = polyfit(t,y,n);
p = @(x) polyval(c,x);
hold on, fplot(p,[-1 1])
title('Polynomial cardinal function')     % ignore this line
xlabel('x'), ylabel('p(x)')   % ignore this line

%% 
% From the figure we can see that the condition number for polynomial
% interpolation on these nodes is at least 500. 