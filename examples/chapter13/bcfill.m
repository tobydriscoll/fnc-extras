%%
% Let the domain be $[-1,1]\times[0,3]$ with $m=2$ and $n=3$. 
x = linspace(-1,1,3);
y = linspace(0,3,4);
[X,Y] = ndgrid(x,y);

%%
% Suppose $\mU$ iz zero on the interior.
U = 0*X;

%%
% We can set the values on the left and right sides to be 1 and $y$,
% respectively.
U(1,:) = 1;     % along smallest value of x
U(end,:) = y    % along largest value of x

%%
% Note that the left and right sides of the rectangle have constant values
% of $x$, so they correspond to _rows_ of $\mU$. We can similarly set $\mU$
% to be $\cos(\pi x)$ and 17 along the top and bottom.
U(:,1) = 17;    % along smallest value of y
U(:,end) = cos(pi*x)   % along largest value of y

%%
% Note that the corners are multiply defined in this scheme, so the last
% setting is the one that counts. 