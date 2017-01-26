%% 
% We plot a cardinal polynomial for $n=5$ and $k=2$. 
t = [ 0, pi/6, pi/3 ];
n = 2;  
y = tan(t);
fplot(@tan,[-0.25,1.25]), hold on
plot(t,y,'.')
x = linspace(-0.2,1.8,501)';        % for evaluation/plot

%%
% Here we use just the first and last nodes.
t13 = t(1)-t(3);
P1 = y(1)*(x-t(3))/t13 - y(3)*(x-t(1))/t13;
plot(x,P1)

%%
% Now use all three nodes. The need to take a product over the nodes in the
% numerator for all the points in x requires some care. The vectorized
% (non-looped) version is given here. 
P2 = 0;
for k = 0:2
    notk = [0:k-1 k+1:2];
    xmt = bsxfun(@minus,x,t(notk+1));
    P2 = P2 + y(k+1)*prod(xmt,2) ./ prod(t(k+1)-t(notk+1));
end
plot(x,P2)

%%
% As we expect, the quadratic approximation is better than the linear one. 
