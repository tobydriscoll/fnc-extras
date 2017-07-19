%%
% The equation $u'=(u+t)^2$, gives us some trouble.
f = @(t,u) (t+u).^2;
[t,u] = ode45(f,[0,1],1);
semilogy(t,u)
xlabel('t'), ylabel('u(t)'), title('Finite time blowup')

%%
% The warning message we received can mean that there is a bug in the
% formulation of the problem. But if everything has been done correctly, it
% suggests that the solution does not exist past the indicated
% time. 