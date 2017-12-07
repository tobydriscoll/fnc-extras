function wave2D    % ignore this line

%%
m = 60;  n = 60;
[X,Y,d] = rectdisc(m,[-2,2],n,[-2,2]);

%%
% Here is the initial condition. The boundary values of $u$ will remain
% constant.
U0 = (X+.2).*exp(-12*(X.^2+Y.^2));
V0 = 0*U0;
pcolor(X,Y,U0)
caxis([-.12 .12]), axis equal, shading flat    % ignore this line
title('Initial condition')    % ignore this line
xlabel('x'), ylabel('y')    % ignore this line

%%
% The |unpack| function separates the unknowns for $u$ and $v$, applies
% the boundary conditions on $u$, and returns two functions on the grid.
    function [U,V] = unpack(w)
        numU = (m-1)*(n-1);  % number of unknowns for U
        U = U0;               
        U(~d.isbndy) = w(1:numU); % overwrite the interior
        V = d.unvec( w(numU+1:end) );     % use all values
    end

%%
% The next function drops the boundary values of $u$ and returns a vector
% of all the unknowns for both components of the solution. It's the inverse
% of the |unpack| function.
    function w = pack(U,V)
        w = U(~d.isbndy);
        w = [ w; V(:) ];
    end

%%
% The following function computes the time derivative of the unknowns. Besides the
% translation between vector and matrix shapes, it's quite straightforward.
    function dwdt = timederiv(t,w)
        [U,V] = unpack(w); 
        dUdt = V;
        dWdt = d.Dxx*U + U*d.Dyy';
        dwdt = pack(dUdt,dWdt);
    end

%%
% Since this problem is hyperbolic, not parabolic, a nonstiff integrator
% like |ode45| is fine and faster than a stiff integrator.
t = linspace(0,3,5);
v0 = pack(U0,V0);
[t,W] = ode45(@timederiv,t,v0);
W = W';  % each column is one time instant

%%
% We plot the solution at four different times. 
for k = 1:2
    subplot(1,2,k)
    [U,~] = unpack(W(:,k+1));
    pcolor(X,Y,U)
    axis equal, shading flat     % ignore this line
    caxis([-.1 .1])     % ignore this line
    title(sprintf('t = %.2f',t(k+1)))     % ignore this line
    xlabel('x'), ylabel('y')    % ignore this line
end

%%
for k = 1:2
    subplot(1,2,k)
    [U,~] = unpack(W(:,k+3));
    pcolor(X,Y,U)
    axis equal, shading flat     % ignore this line
    caxis([-.1 .1])     % ignore this line
    title(sprintf('t = %.2f',t(k+3)))     % ignore this line
    xlabel('x'), ylabel('y')    % ignore this line
end

end    % ignore this line