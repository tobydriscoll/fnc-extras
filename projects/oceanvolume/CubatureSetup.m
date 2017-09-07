%%
% Construct the domain of integration.
xLeft = 0;  xRight = 4;  
yLeft = -1;  yRight = 1; 
fill([xLeft xRight xRight xLeft],[yLeft yLeft yRight yRight],0.8*[1 1 1])
axis equal, hold on

%%
% These are the individual variable discretizations.
m = 6;  h = (xRight-xLeft)/m;
x = xLeft + h*(0:m)';

n = 5;  eta = (yRight-yLeft)/n;
y = yLeft + eta*(0:n)';

set(gca,'xtick',x,'ytick',y)

%%
% Now we construct a 2D grid out of them.
[X,Y] = ndgrid(x,y);
plot(X,Y,'b.')
plot(X,Y,'k--')
plot(X',Y','k--')

%%
% Both |X| and |Y| are $(m+1)\times(n+1)$ matrices, and satisfy the
% identity $(x_i,y_j)=(X_{ij},Y_{ij})$. 
point = [x(3),y(2)]
pointAgain = [ X(3,2),Y(3,2) ] 