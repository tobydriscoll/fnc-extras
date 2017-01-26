%%
% We solve $u_t=u_{xx}$ on $[-1,1]$ subject to the Dirichlet conditions
% $u(-1,t)=0$, $u(1,t)=2$. 
m = 100;  [x,Dx,Dxx] = diffcheb(m,[-1,1]);

%%
% Our next goal is to write a function that defines $\bff_I$ for |ode15s| to
% use. Since the boundary values are given explicitly, there is no need to
% ``solve'' for them---we just add them to the vector. 
uI2u = @(uI) [0;uI;2];

%% 
% On the output side, we discard those rows of the result correspnding to
% the boundaries.
u2uI = @(u) u(2:m);

%%
% All the pieces are now in place to define and solve the IVP.
ODE = @(t,uI) u2uI( Dxx*uI2u(uI) );
u0 = 1 + sin(pi/2*x) + 3*(1-x.^2).*exp(-4*x.^2);
t = linspace(0,0.15,5)';
[t,UI] = ode15s(ODE,t,u2uI(u0));
UI = UI';    % rows for space, columns for time

%%
% We extend the solution to the boundaries at each time, then plot.
U = nan(m+1,length(t));
for j = 1:size(UI,2)
    U(:,j) = uI2u(UI(:,j));
end
plot(x,U)
xlabel('x'), ylabel('u(x,t)')   % ignore this line
legend(num2str(t),'location','northwest')   % ignore this line
title('Heat equation')   % ignore this line
