function molheatbc     % ignore this line

%%
% We solve $u_t=u_{xx}$ on $[-1,1]$ subject to the Dirichlet conditions
% $u(-1,t)=0$, $u(1,t)=2$. 
m = 100;  [x,Dx,Dxx] = diffcheb(m,[-1,1]);

%%
% Our next step is to write a function that defines $\bff$. Since the
% boundary values are given explicitly, there is no need to ``solve'' for
% them---we just append them to each end of the vector.
extend = @(v) [0;v;2];

%% 
% We can also define the inverse operation of chopping off the boundary
% values from a full vector.  Note that the indexing starts at 1 and ends at 
% $m+1$ for the extended vector.
chop = @(u) u(2:m);

%%
% All the pieces are now in place to define and solve the IVP.
    function f = ODE(t,v)
        u = extend(v);
        phi = Dxx*u;
        f = chop(phi);
    end
u0 = 1 + sin(pi/2*x) + 3*(1-x.^2).*exp(-4*x.^2);
t = linspace(0,0.15,5)';   % defines the output times
[t,V] = ode15s(@ODE,t,chop(u0));
V = V.';           % rows for space, columns for time

%%
% We extend the solution to the boundaries at each time, then plot.
U = nan(m+1,length(t));
for j = 1:length(t)
    U(:,j) = extend(V(:,j));
end
plot(x,U)
xlabel('x'), ylabel('u(x,t)')   % ignore this line
warning off    % ignore this line
legend(strsplit(sprintf('t = %g|',t),'|'),'location','northwest')   % ignore this line
title('Heat equation')   % ignore this line

end
