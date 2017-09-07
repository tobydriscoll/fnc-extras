%%
% Here is a single rectangle.
h = 0.1;  x = [0 h]';
eta = 0.2;  y = [-1 -1+eta]';
[X,Y] = ndgrid(x,y)

%%
% These are made-up values at the corners of the rectangle.
Z = [ 1.1, 0.9; 0.75, 2 ];

%%
% Here are coefficients of the interpolant.
A = [ ones(4,1), X(:), Y(:), X(:).*Y(:) ];   % interpolation matrix
abcd = A \ Z(:)

%%
% And here is the resulting surface and the outlines of the solid. (Don't
% worry about the fancy plotting commands here.)
ezsurf(@(x,y) abcd(1) + abcd(2)*x + abcd(3)*y + abcd(4)*x.*y, [x;y] )
hold on, shading interp
plot3(X,Y,0*Z,'k','linew',2)
plot3([1;1]*X(:)',[1;1]*Y(:)',[zeros(1,4);Z(:)'],'k','linew',2)
axis tight
