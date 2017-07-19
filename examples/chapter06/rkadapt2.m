%%
f = @(t,u) (t+u).^2;
warning on
[t,u] = rk23(f,[0,1],1,1e-5);
semilogy(t,u)
xlabel('t'), ylabel('u(t)'), title('Finite time blowup')  % ignore this line
