%% 
% We can find some very interesting solutions for different values of
% $\epsilon$ just by using zero as the initial guess for the nonlinear
% solver. 
for ep = [1e-3 1e-2 1e-1]   
    phi = @(x,u,up) (1 - 2*(1-x.^2).*u - u.^2)/ep;
    [x,u,resid] = bvpfd(phi,[-1 1],0,[],0,[],zeros(301,1));
    residual_norm = norm(resid(u))
    plot(x,u), hold on
end
xlabel('x'), ylabel('u(x)')    % ignore this line
title('Solutions of Carrier''s equation')    % ignore this line
legend('\epsilon = 0.1','\epsilon = 0.01','\epsilon = 0.001')

%%
% Note that for the last value of $\epsilon$ we got a solution with just
% one hump in the middle. If we now return gradually to the smallest value
% of $\epsilon$---this time, using the solution from the latest value as
% the initial guess for the next one---we get an entirely different
% solution.
for ep = logspace(-1,-3,10)
    phi = @(x,u,up) (1 - 2*(1-x.^2).*u - u.^2)/ep;
    [x,u,resid] = bvpfd(phi,[-1 1],0,[],0,[],u);
end
residual_norm = norm(resid(u))
clf, plot(x,u)
xlabel('x'), ylabel('u(x)')    % ignore this line
title('Alternative solution with \epsilon = 0.001')    % ignore this line

