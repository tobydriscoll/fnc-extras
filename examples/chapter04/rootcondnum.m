%%
% Consider first the function
f  = @(x) (x-1).*(x-2);

%%
% At the root $r=1$, we have $f'(r)=-1$. If the values of $f$ were
% perturbed at any point by noise of size, say, $0.05$, we imagine finding
% the root of the function drawn as a ``thick'' line.
interval = [0.7 1.3];
fplot(f,interval), grid on
hold on, axis equal, axis square
fplot(@(x) f(x)+0.05,interval,'--')
fplot(@(x) f(x)-0.05,interval,'--')

%%
% The possible values for a perturbed root all lie within the interval
% where the dashed lines intersect the $x$ axis.

%%
% By contrast, consider the function
f  = @(x) (x-1).*(x-1.01);

%%
% Now $f'(1)=-0.01$, and the graph of $f$ will be much shallower near
% $x=1$. But look on the effect this has on our thick rendering:
clf
fplot(f,interval), grid on
hold on, axis equal, axis square
fplot(@(x) f(x)+0.05,interval,'--')
fplot(@(x) f(x)-0.05,interval,'--')

%%
% The vertical displacements in this picture are exactly the same as
% before. But the _horizontal_ displacements are much wider. In fact, if we
% perturb the function values upward by the amount drawn here, the root
% disappears entirely!