function heat2D    % ignore this line

%%
% We will solve a 2D heat equation with a source term, $u_t = u +
% 0.05(u_{xx} + u_{yy})$.

%%
% Here is the initial condition. The boundary values will remain constant.
u0 = @(x,y) cos(11*pi*x/2).*y + 4*(1-x).*y.*(1-y);
%%
% Now we discretize.
m = 50;  n = 40;
[X,Y,Dx,Dxx,Dy,Dyy,vec,unvec,isbndy] = rectdisc(m,[0 1],n,[0 1]);
pcolor(X,Y,u0(X,Y))
caxis([-1.6 1.6]), axis equal, shading flat    % ignore this line
title('Initial condition')    % ignore this line
xlabel('x'), ylabel('y')    % ignore this line

%%
% This function computes the time derivative at the interior nodes.
    function dudt = timederiv(t,u)
        U = unvec(u);
        % Apply the PDE.
        dUdt = U + 0.05*(Dxx*U + U*Dyy');
        % Zero out the derivative at boundary nodes.
        dUdt(isbndy) = 0;
        dudt = vec(dUdt);
    end

%%
% Since this problem is parabolic, a stiff integrator like |ode15s| is a
% good choice.
t = linspace(0,.3,3);
[t,u] = ode15s(@timederiv,t,vec(u0(X,Y)));
u = u';  % each column is one time instant

%%
% We plot the solution at two different times. (The results are best viewed
% using an animation produced in the online materials.) 
for k = 1:2
    subplot(1,2,k)
    U = unvec(u(:,k+1));
    pcolor(X,Y,U)
    axis equal, shading flat     % ignore this line
    caxis([-1.6 1.6])     % ignore this line
    title(sprintf('t = %.2f',t(k+1)))     % ignore this line
    xlabel('x'), ylabel('y')    % ignore this line
end

end    % ignore this line