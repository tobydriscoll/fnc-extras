%%
% We return to the problem of computing $\int_0^1 \sqrt{x}\,dx$. In order
% to apply |intsing|, we first have to transform the interval of
% integration to $[-1,1]$. We can do this through $z=2x-1$. Note that
%%
% $$\int_0^1 \sqrt{x}\,dx = \int_{-1}^1 \sqrt{\tfrac{1}{2}(z+1)}\cdot \tfrac{1}{2}dz.$$
f = @(z) sqrt((1+z)/2);
[I,z] = intsing(f,0.1,1e-12);
err = I/2 - 2/3
number_of_nodes = length(z)

%%
% The integration required very few nodes. For the more difficult integral
% of $1/\sqrt{x}$, the results are limited by how accurately we can
% represent $-1+\delta$.
f = @(z) 1./sqrt((1+z)/2);
[I,z] = intsing(f,0.1,1e-14);
err = I/2 - 2
number_of_nodes = length(z)

%%
% If we make $\delta$ any smaller, the outermost trapezoid nodes will be
% indistinguishable from $z=\pm 1$, i.e. the exact endpoints of the
% interval. We would need to use special code to evaluate $f$ indirectly in
% the limits $t\to \pm \infty$. 
