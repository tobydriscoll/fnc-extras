%%
lambda = 0.5;
phi = @(r,w,dwdr) lambda./w.^2 - dwdr./r;
init = 0.5*ones(301,1);
[r,w1,residual] = bvpfd(phi,[0,1],[],0,1,[],init);
f = @(w) residual(w)*(1+1/norm(w-w1));
w2 = levenberg(f,init);
w2 = w2(:,end); 

%%
% We represent the solutions as points in an abstract plane.
plot(lambda,w1(1),'b.'), hold on
plot(lambda,w2(1),'r.')
xlabel('\lambda'), ylabel('w(0)')    % ignore this line
title('Bifurcation plane')

%%
% We can continue both solutions by increasing $\lambda$ slowly.
for lambda = [ 0.48:0.01:0.77 0.774:0.004:0.79]
    phi = @(r,w,dwdr) lambda./w.^2 - dwdr./r;
    [r,w1,residual] = bvpfd(phi,[0,1],[],0,1,[],w1);
    [r,w2,residual] = bvpfd(phi,[0,1],[],0,1,[],w2);
    plot(lambda,w1(1),'b.'), hold on
    plot(lambda,w2(1),'r.')
end

%%
% It looks as though something interesting is happening near
% $\lambda=0.79$.
