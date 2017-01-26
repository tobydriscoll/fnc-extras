function wave2D    % ignore this line

%%
% We will solve a 2D heat equation with a source term, $u_t = u +
% 0.05(u_{xx} + u_{yy})$.

%%
% Here is the initial condition. The boundary values will remain constant.
u0 = @(x,y) (x+.2).*exp(-12*(x.^2+y.^2));
%%
% Now we discretize.
m = 60;  n = 60;
[X,Y,Dx,Dxx,Dy,Dyy,vec,unvec,isbndy] = rectdisc(m,[-2 2],n,[-2 2]);
N = numel(X);
pcolor(X,Y,u0(X,Y))
caxis([-.12 .12]), axis equal, shading flat    % ignore this line
title('Initial condition')    % ignore this line
xlabel('x'), ylabel('y')    % ignore this line

%%
% This function computes the time derivative at the interior nodes.
    function dvdt = timederiv(t,v)
        U = unvec(v(1:N));
        dUdt = unvec(v(N+(1:N)));
        % Apply the PDE.
        d2Udt2 = (Dxx*U + U*Dyy');
        % Zero out the derivatives at boundary nodes.
        dUdt(isbndy) = 0;
        d2Udt2(isbndy) = 0;
        dvdt = [vec(dUdt);vec(d2Udt2)];
    end

%%
% Since this problem is parabolic, a nonstiff integrator like |ode45| is
% fine and faster than a stiff integrator.
t = linspace(0,3,5);
v0 = [ vec(u0(X,Y)); zeros(N,1) ];
[t,v] = ode45(@timederiv,t,v0);
v = v';  % each column is one time instant

%%
% We plot the solution at four different times. (The results are best viewed
% using an animation produced in the online materials.) 
for k = 1:2
    subplot(1,2,k)
    U = unvec(v(1:N,k+1));
    pcolor(X,Y,U)
    axis equal, shading flat     % ignore this line
    caxis([-.1 .1])     % ignore this line
    title(sprintf('t = %.2f',t(k+1)))     % ignore this line
    xlabel('x'), ylabel('y')    % ignore this line
end

%%
for k = 1:2
    subplot(1,2,k)
    U = unvec(v(1:N,k+3));
    pcolor(X,Y,U)
    axis equal, shading flat     % ignore this line
    caxis([-.1 .1])     % ignore this line
    title(sprintf('t = %.2f',t(k+3)))     % ignore this line
    xlabel('x'), ylabel('y')    % ignore this line
end

end    % ignore this line