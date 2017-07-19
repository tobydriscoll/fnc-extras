%%
% The equation $u'=\sin[(u+t)^2]$ also has a solution that can be found
% numerically with ease, even though no formula exists for its solution. 
f = @(t,u) sin( (t+u).^2 );
[t,u] = ode45(f,[0,4],-1);
plot(t,u)
xlabel('t'), ylabel('u(t)'), title('Solution of u''=sin[(t+u)^2]')     % ignore this line

%% 
% In some cases 
