%% 
% The problem is relatively easy to solve for large values of $\epsilon$.
epsilon = 0.05;
phi = @(x,u,dudx) (u.^3 - u) / epsilon;
init = linspace(-1,1,141)';
[x,u,residual] = bvpfd(phi,[0,1],-1,[],1,[],init);
norm_residual = norm(residual(u))
plot(x,u)
xlabel('x'), ylabel('u(x)')   % ignore this line
title('Allen-Cahn, \epsilon = 0.05')   % ignore this line

%%
% However, finding a good starting guess is not trivial for small values of
% $\epsilon$. Here we can see that even though the quasi-Newton iteration
% stops, the result is not close to a root.
epsilon = 0.005;
phi = @(x,u,dudx) (u.^3 - u) / epsilon;
[x,u,residual] = bvpfd(phi,[0,1],-1,[],1,[],init);
norm_residual = norm(residual(u))

%%
% A simple way around this problem is to use the result of a solved version
% as the starting guess for a more difficult version.
phi = @(x,u,dudx) (u.^3 - u) / 0.01;
[x,u] = bvpfd(phi,[0,1],-1,[],1,[],init);
phi = @(x,u,dudx) (u.^3 - u) / 0.005;
[x,u,residual] = bvpfd(phi,[0,1],-1,[],1,[],u);
norm_residual = norm(residual(u))
plot(x,u)
xlabel('x'), ylabel('u(x)')   % ignore this line
title('Allen-Cahn, \epsilon = 0.005')   % ignore this line

%%
% In this case we can continue further.
phi = @(x,u,dudx) (u.^3 - u) / 0.0005;
[x,u,residual] = bvpfd(phi,[0,1],-1,[],1,[],u);
norm_residual = norm(residual(u))
plot(x,u)
xlabel('x'), ylabel('u(x)')   % ignore this line
title('Allen-Cahn, \epsilon = 0.0005')   % ignore this line
