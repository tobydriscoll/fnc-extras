%%
% We return to estimating $\displaystyle\int_0^2 x^2 e^{-2x}\, dx$. 
f = @(x) x.^2.*exp(-2*x);
a = 0;  b = 2;  format short e
I = integral(f,a,b,'abstol',1e-14,'reltol',1e-14);

%%
% We start with the trapezoid formula on $n=N$ nodes.
N = 20;       % the coarsest formula
n = N;  h = (b-a)/n;
t = h*(0:n)';   y = f(t);

%%
% We can now apply weights to get the estimate $T_f(N)$. 
T = h*( sum(y(2:N)) + y(1)/2 + y(n+1)/2 );
err_2nd = I - T

%%
% Now we double to $n=2N$, but we only need to evaluate $f$ at every other
% interior node.
n = 2*n;  h = h/2;  t = h*(0:n)';
T(2) = T(1)/2 + h*sum( f(t(2:2:n)) );
err_2nd = I - T

%%
% As expected for a second-order estimate, the error went down by a factor
% of about 4. We can repeat the same code to double $n$ again.
n = 2*n;  h = h/2;  t = h*(0:n)';
T(3) = T(2)/2 + h*sum( f(t(2:2:n)) );
err_2nd = I - T

%%
% Let us now do the first level of extrapolation to get results from
% Simpson's formula. We combine the elements |T(i)| and |T(i+1)| the same
% way for $i=1$ and $i=2$.
S = (4*T(2:3) - T(1:2)) / 3;
err_4th = I - S

%%
% With the two Simpson values $S_f(N)$ and $S_f(2N)$ in hand, we can do one
% more level of extrapolation to get a 6th-order accurate result.
R = (16*S(2) - S(1)) / 15;
err_6th = I - R

%%
% If we consider the computational time to be dominated by evaluations of
% $f$, then we have obtained a result with twice as many accurate digits as
% the best trapezoid result, at virtually no extra cost.