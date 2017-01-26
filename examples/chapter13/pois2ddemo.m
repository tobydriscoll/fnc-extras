%%
% Here are a forcing function and Dirichlet boundary data for Poisson's
% equation.
f = @(x,y) x.^2 - y + 2;
g = @(x,y) zeros(size(x));

%%
% We pick a crude discretization for illustrative purposes.
m = 5;  n = 6;
[X,Y,Dx,Dxx,Dy,Dyy,...
    vec,unvec,isbndy] = rectdisc(m,[0 3],n,[-1 1]);
Ix = eye(m+1);  Iy = eye(n+1);

%%
% Evaluate $f$ and the coordinate functions on the grid.
F = f(X,Y);      

%%
% Here are the equations for the PDE collocation, before any
% modifications are made for the boundary conditions.
A = kron(Iy,Dxx) + kron(Dyy,Ix);
spy(A)
title('Matrix before BC')    % ignore this line
b = vec(F);
N = length(b)

%%
% The variable |isbndy| is logical and the same size as |X|, |Y|, etc.
spy(isbndy), title('Boundary points')
nB = nnz(isbndy);

%%
% Next we erase the boundary rows of the system and replace them by the
% identity.
A(isbndy,:) = 0;               % erase the PDE equations
A(isbndy,isbndy) = eye(nB);    % Dirichlet conditions
spy(A)
title('Matrix with BC')    % ignore this line

%%
% Finally, we must replace the rows in the vector $\bfb$ by the boundary
% values being assigned to the boundary points. As an intermediate step, we
% find the coordinates of those points.
XB = X(isbndy);  
YB = Y(isbndy);
b(isbndy) = g(XB,YB);          % Dirichlet values

%%
% Now we can solve for $\bfu$ and reinterpret it as the matrix-shaped $\mU$,
% the solution on our grid. This grid is much too small for the result to
% look like a smooth function of two variables.
u = A\b;
U = unvec(u);
mesh(X,Y,U)
xlabel('x'), ylabel('y'), zlabel('u(x,y)')     % ignore this line
title('Coarse solution')     % ignore this line