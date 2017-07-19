function molbratu    % ignore this line
%%
% We solve a diffusion equation with source term: $u_t=u^2+u_{xx}$, on
% $[-1,1]$ subject to homogeneous Dirichlet conditions. 
m = 100;  [x,Dx,Dxx] = diffcheb(m,[-1,1]);

%%
extend = @(v) [0;v;0];  % extend to boundary
chop = @(u) u(2:m);     % discard boundary
function fI = ODE(t,v) 
  u = extend(v);  uxx = Dxx*u;
  f = u.^2 + uxx;
  fI = chop(f);
end

%%
% All the pieces are now in place to define and solve the IVP.
u0 = 6*(1-x.^2).*exp(-4*(x-.5).^2);
t = linspace(0,1.5,5)';   % defines the output times
[t,V] = ode15s(@ODE,t,chop(u0));
V = V.';          % rows for space, columns for time

%%
% Extend the solution to the boundaries at each time, then plot.
U = nan(m+1,length(t));
for j = 1:length(t)
    U(:,j) = extend(V(:,j));
end
plot(x,U)
xlabel('x'), ylabel('u(x,t)')   % ignore this line
warning off    % ignore this line
legend(strsplit(sprintf('t = %g|',t),'|'),'location','northwest')   % ignore this line
title('Heat equation with source')   % ignore this line

end    % ignore this line
