function molbsbc    % ignore this line

Smax = 8;  T = 8;
K = 3;  sigma = 0.06;  r = 0.08;
m = 200;  [x,Dx,Dxx] = diffmat2(m,[0,Smax]);
h = x(2)-x(1);

%%
% Using the boundary conditions and defining the ODE follow next. 
extend = @(v) [ 0; v; 2/3*(h-0.5*v(m-2)+2*v(m-1)) ];
chop = @(u) u(2:m);

function fI = ODE(t,v) 
  u = extend(v);
  ux = Dx*u;  uxx = Dxx*u;
  f = sigma^2/2*x.^2.*uxx + r*x.*ux - r*u;
  fI = chop(f);
end

%%
% Now we define the initial conditions and solve the IVP.
v0 = max( 0, x-K );
t = linspace(0,T,5)';
[t,V] = ode15s(@ODE,t,chop(v0));
V = V';    % rows for space, columns for time

%%
% Extend the solution to the boundaries at each time, then plot.
U = nan(m+1,length(t));
for j = 1:size(V,2)
    U(:,j) = extend(V(:,j));
end
plot(x,U)
xlabel('x'), ylabel('u(x,t)')   % ignore this line
warning off    % ignore this line
legend(strsplit(sprintf('t = %g|',t),'|'),'location','northwest')   % ignore this line
title('Black-Scholes equation')   % ignore this line

end    % ignore this line
