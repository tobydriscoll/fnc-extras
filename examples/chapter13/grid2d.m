%%
% Consider again the example $f(x,y)=\sin(xy)$ over $[0,2\pi]\times[1,3]$,
% with the dimensions discretized using $m=4$ and $n=2$ equal pieces,
% respectively.
m = 4;   x = (0:2*pi/m:2*pi)';
n = 2;   y = (1:2/n:3)';
f = @(x,y) sin(x.*y-y);

%%
% We get $f$, as well as the coordinate functions $x$ and $y$, converted to
% matrices on the grid by using the mtx function.
[F,X,Y] = mtx(f,x,y);
F

%%
% We can visualize the grid on the rectangle.
plot(X,Y,'bo','markersize',6)
set(gca,'xtick',x,'ytick',y)
grid on

%%
% We can make plots of the function by choosing a much finer grid.
m = 70;   x = (0:2*pi/m:2*pi)';
n = 50;   y = (1:2/n:3)';
[F,X,Y] = mtx(f,x,y);

%%
subplot(1,2,1)
contourf(X,Y,F,10)
title('Contour plot')    % ignore this line
subplot(1,2,2)
surf(X,Y,F), shading flat
title('Surface plot')    % ignore this line
