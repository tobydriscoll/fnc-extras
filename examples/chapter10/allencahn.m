%%
% Even when the dependence on a variable is missing in $\phi$, the code
% must leave input arguments in place for it. Remember that it should work
% for vector inputs. 
epsilon = 0.02;
phi = @(x,u,dudx) (u.^3 - u) / epsilon;

%%
init = linspace(-1,1,141)';
[x,u] = bvpfd(phi,[0,1],[],0,1,[],init);
plot(x,u)
xlabel('x'), ylabel('u(x)')   % ignore this line
title('Solution of Allen-Cahn')   % ignore this line
