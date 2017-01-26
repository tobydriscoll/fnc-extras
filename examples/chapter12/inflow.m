%%
% We set up advection over $[0,1]$ with velocity $c=-1$. This puts the
% right-side boundary in the upwind direction.
c = -1;  n = 100;
[x,Dx] = diffmat2(n,[0,1]);
uinit = exp(-100*(x-0.5).^2);

%%
% First we try imposing $u=0$ at the right boundary, by appending that
% value to the end of the vector before multiplying by the differentiation
% matrix.
odefun = @(t,u) -c*(Dx(1:n,:)*[u;0]);
[t,UI] = ode113(odefun,[0,1],uinit(1:n));
pcolor(x(1:n),t,UI)
xlabel x, ylabel t, shading flat

%%
% The data propagates off the left edge. Because only zero is coming in
% from the upwind direction, the solution remains zero forever.

%%
% Now we try $u=0$ imposed at the left boundary. 
odefun = @(t,u) -c*(Dx(2:n+1,:)*[0;u]);
[t,UI] = ode113(odefun,[0,1],uinit(2:n+1));
pcolor(x(2:n+1),t,UI)
xlabel x, ylabel t, shading flat

%%
% Everything seems OK until the data begins to interact with the
% inappropriate boundary condition. The resulting ``reflection'' is
% entirely wrong for advection from right to left. 
