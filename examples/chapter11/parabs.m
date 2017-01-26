%%
xspan = [0,8];  T = 200;
K = 3;  sigma = 0.06;  r = 0.08;
bspde = @(t,x,v,Dx,Dxx) (sigma*x).^2/2.*(Dxx*v) ;

%%
% The Neumann condition at the right end is discretized by the finite
% difference
%%
% $$ \frac{ 0.5v_{m-1} -2v_m + 1.5v_{m+1}}{h} = 1,$$
%
%%
% which can be rearranged to isolate $v_{m+1}$. But these weights are
% already found in the last row of the differentiation matrix
% $\mathbf{D}_x$. 
bsbc = @(t,vI,Dx) [ 0; ...
    (1 - Dx(end,end-2)*vI(end-1) - Dx(end,end-1)*vI(end)) / Dx(end,end)];

%%
% Now we just need to define the initial condition and solve.
init = @(x) max( 0, x-K );
[V,x,t] = parapde(bspde,bsbc,init,xspan,200,[0,T],40);
show_times = t(1:8:41)
plot(x,V(:,1:8:41))
xlabel('stock price'),  ylabel('option value')
