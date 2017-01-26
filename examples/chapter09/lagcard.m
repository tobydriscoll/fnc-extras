%% 
% We plot a cardinal Lagrange polynomial for $n=5$ and $k=2$. 
t = [ 1, 0.6, 2, 2.25, 2.75, 3 ];
n = 5;  k = 2;

not_k = [0:k-1 k+1:n];   % all except the kth node
phi = @(x) prod(x-t(not_k+1));
ell_k = @(x) phi(x) ./ phi(t(k+1));

fplot(ell_k,[-1 1])
hold on, grid on
plot(t(not_k+1),0*t(not_k+1),'.')
plot(t(k+1),1,'.')

%%
% Observe that $\ell_k$ is _not_ between zero and one everywhere between the
% nodes. 