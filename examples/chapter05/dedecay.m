f = @(x) 1./(1+x.^2);
x = @(t) sinh(pi*sinh(t)/2);
fplot(@(t) f(x(t)),[-4 4])
set(gca,'yscale','log')
xlabel('t'), ylabel('f(x(t))')  % ignore this line
title('Doubly exponential decay')  % ignore this line