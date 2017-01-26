%%
f = @(t,u) (t+u).^2;
[t,u] = ode45(f,[0,1],1);
semilogy(t,u)
xlabel('t'), ylabel('u(t)'), title('Finite time blowup')  % ignore this line

%%
% Our adaptive |rk23| function finds the singularity at around the same
% time. 
[t,u] = rk23(f,[0,1],1,1e-5);