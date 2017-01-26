%%
% The two kinds of Chebyshev points interlace at any fixed value of $n$.
n = 7;
dtheta = pi/n;
theta1 = dtheta/2 + dtheta*(0:n-1)';
theta2 = dtheta*(0:n)';
x1 = cos(theta1);
x2 = cos(theta2);
plot(x1,0*x1,'b.'), hold on
plot(x2,0*x2,'r.')
plot([-1 1],[0 0],'color',[.5 .5 .5])
axis square, axis equal

%%
% In fact, both kinds are projections of evenly spaced points on
% the unit circle.
plot([x1 x1]',[sin(theta1) 0*x1]','b:.')
plot([x2 x2]',[sin(theta2) 0*x2]','r:.')
phi = linspace(-0.2,pi+0.2,200)';
plot(cos(phi),sin(phi),'color',[.5 .5 .5])
axis([-1.1 1.1 -0.1 1.1])
