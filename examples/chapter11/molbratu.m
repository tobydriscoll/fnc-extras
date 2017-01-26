function molbratu    % ignore this line
%%
% We solve a diffusion equation with source term: $u_t=u^2+u_{xx}$, on
% $[-1,1]$ subject to homogeneous Dirichlet conditions. 
m = 100;  [x,Dx,Dxx] = diffcheb(m,[-1,1]);

%%
uI2u = @(uI) [0;uI;0];  % extend to boundary
u2uI = @(u) u(2:m);     % discard boundary
function fI = ODE(t,uI) 
  u = uI2u(uI);  uxx = Dxx*u;
  f = u.^2 + uxx;
  fI = u2uI(f);
end

%%
% All the pieces are now in place to define and solve the IVP.
u0 = 5.5*(1-x.^2).*exp(-4*(x-.5).^2);

%%
% Now, though, we apply |ode45| to the initial-value problem
% $\mathbf{u}'=\mathbf{D}_{xx}\mathbf{u}$.
t = linspace(0,1.5,5)';
[t,UI] = ode15s(@ODE,t,u2uI(u0));
UI = UI';    % rows for space, columns for time

%%
% Extend the solution to the boundaries at each time, then plot.
U = nan(m+1,length(t));
for j = 1:size(UI,2)
    U(:,j) = uI2u(UI(:,j));
end
plot(x,U)
xlabel('x'), ylabel('u(x,t)')   % ignore this line
legend(num2str(t),'location','northwest')   % ignore this line
title('Heat equation with source')   % ignore this line

end    % ignore this line