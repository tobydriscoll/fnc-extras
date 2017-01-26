%%
% We approximate $\int_{-\infty}^\infty f(x)\, dx$, where $f(x)=1/(1+x^2)$.
% Note that $\int_M^\infty f\,dx\approx M^{-1}$, so $M$ has to be very
% large if we want very small error. That makes integration directly in $x$
% impractical. However, the doubly exponential transformation makes it
% feasible to integrate in $t$. 
f = @(x) 1./(1+x.^2);
h = logspace(-3,-1,60);
M = logspace(3,16,60);

for i = 1:length(h)
    for j = 1:length(M)
        I(i,j) = intde(f,h(i),M(j));
    end
end
err = abs(I-pi);
contourf(h,M,-log10(err)')
set(gca,'xsc','log','xdir','rev','ysc','log') % ignore this line
colorbar   % ignore this line
xlabel('h'), ylabel('M')   % ignore this line
title('Number of accurate digits')  % ignore this line

%%
% As predicted, the error can't beat $1/M$. Even for very large $M$,
% however, not many nodes are needed. For instance,
[I,x] = intde(f,0.1,1e10);
err = abs(pi-I)
number_of_nodes = length(x)
semilogx(x,f(x),'.-')
axis tight, ylim([0 1])   % ignore this line
xlabel('x'), ylabel('f(x)')   % ignore this line
title('Nodes used for integration')   % ignore this line