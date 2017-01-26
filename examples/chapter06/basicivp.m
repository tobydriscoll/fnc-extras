%%
% The logistic equation $u'(t) = ku - ru^2$ has a solution for all times. 
f = @(t,u) 2*u - 0.5*u.^2;
a = 0;  b = 6;
u0 = 0.1;

%%
% MATLAB has many built-in functions for solving IVPs, all using 
% the same pattern for the input arguments. 
[t,u] = ode45(f,[a,b],u0);
length(t) 

%%
plot(t,u)
xlabel('t'), ylabel('u(t)'), title('Solution of logistic equation')

%%
% The equation $u'=\sin[(u+t)^2]$ also has a solution that can be found
% numerically with ease over any finite time interval. 
f = @(t,u) sin( (t+u).^2 );
[t,u] = ode45(f,[0,4],-1);
plot(t,u)
xlabel('t'), ylabel('u(t)'), title('Solution of u''=sin[(t+u)^2]')

%%
% The equation $u'=(u+t)^2$, however, gives us trouble.
f = @(t,u) (t+u).^2;
[t,u] = ode45(f,[0,1],1);
semilogy(t,u)
xlabel('t'), ylabel('u(t)'), title('Finite time blowup')

%%
% The warning message we received can mean that there is a bug in the
% formulation of the problem. But if everything has been done correctly, it
% usually suggests that the solution does not exist past the indicated
% time. 

%%
% Sometimes we want the solution at a particular time, rather than one of the
% times chosen by the integrator. One way to do this is to use a different
% form of the output.
sol = ode45(f,[0,1],1);           % can be evaluated at any time
deval(sol,[0.78 0.785 0.7853])    % evaluates the solution
