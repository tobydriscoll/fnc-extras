%%
% We will use a fixed discretization for varying values of $\lambda$.
n = 200;
lambda = (4:4:28)';
err = 0*lambda; 

for k = 1:length(lambda)
    
    lam = lambda(k); 
    exact = @(x) sinh(lam*x)/sinh(lam) - 1;
    p = @(x) 0*x;
    q = @(x) -lam^2*x.^0;
    r = @(x) lam^2*x.^0;   
    [x,u] = bvp2lin(p,q,r,[0 1],-1,0,n);
    
    err(k) = norm(exact(x)-u,inf);
end

table(lambda,err)
