function molbsbc    % ignore this line
%%
% We return to the instance of Black--Scholes solved in \exaref{blackscholes}. 
Smax = 8;  T = 8;
K = 3;  sigma = 0.06;  r = 0.08;
m = 200;  [x,Dx,Dxx] = diffmat2(m,[0,Smax]);
h = x(2)-x(1);

%%
% See \exaref{bsbc1} for how we arrived at the following. 
vI2v = @(vI) [ 0; vI; 2/3*(h-0.5*vI(m-2)+2*vI(m-1)) ];
v2vI = @(v) v(2:m);

function fI = ODE(t,vI) 
  v = vI2v(vI);
  vx = Dx*v;  vxx = Dxx*v;
  f = sigma^2/2*x.^2.*vxx + r*x.*vx - r*v;
  fI = v2vI(f);
end

%%
% Now we solve the IVP.
v0 = max( 0, x-K );
t = linspace(0,T,5)';
[t,VI] = ode15s(@ODE,t,v2vI(v0));
VI = VI';    % rows for space, columns for time

%%
% Extend the solution to the boundaries at each time, then plot.
V = nan(m+1,length(t));
for j = 1:size(VI,2)
    V(:,j) = vI2v(VI(:,j));
end
plot(x,V)
xlabel('x'), ylabel('u(x,t)')   % ignore this line
legend(num2str(t),'location','northwest')   % ignore this line
title('Black-Scholes equation')   % ignore this line

%%

end    % ignore this line