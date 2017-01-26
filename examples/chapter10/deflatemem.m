%%
lambda = 0.5;
phi = @(r,w,dwdr) lambda./w.^2 - dwdr./r;
init = 0.5*ones(301,1);
[r,w1,residual] = bvpfd(phi,[0,1],[],0,1,[],init);
norm_residual = norm(residual(w1))
plot(r,w1)
xlabel('r'), ylabel('w(r)')   % ignore this line
title('Solution')   % ignore this line

%%
% Now we define a new residual function by deflation, and find a root via
% |levenberg|.
f = @(w) residual(w)*(1+1/norm(w-w1));
w2 = levenberg(f,init);
w2 = w2(:,end);

%%
% The result is a second valid solution at the same value of $\lambda$.
hold on, plot(r,w2)
norm_residual = norm(residual(w2))
title('Two solutions')   % ignore this line

