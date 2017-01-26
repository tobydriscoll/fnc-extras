%%
% First we perform an experiment in which things turn out well. 
f = @(x) 1./sqrt(1+x.^2);
fplot(f,[0 1])

%%
% We interpolate for increasing values of $n$.
x = linspace(0,1,1000)';            % error measurement locations
n = (5:5:50)';
err = 0*n;
kappa = 0*n;
warning off
for k = 1:length(n) 
  t = linspace(0,1,n(k)+1)';        % equally spaced nodes
  y = f(t);                         % interpolation data
  V = bsxfun( @power,t,(0:n(k)) );  % Vandermonde matrix
  c = V \ y;                        % polynomial coeffs (low->high)
  c = c(end:-1:1);                  % coeffs in MATLAB ordering
  
  kappa(k) = cond(V);
  err(k) = norm( f(x) - polyval(c,x), inf );
end
table(n,kappa,err)

%%
% The error gets very small and stays there as $n$ increases. However, the
% condition number of the matrix $\mathbf{V}$ grows very rapidly to more
% than $\epsilon_M^{-1}$, so that the matrix is essentially singular!
% Therefore, there must be some data for which the interpolation fails
% spectacularly. 

%%
% In fact, a seemingly small change in the function makes a huge difference
% in the result.
f = @(x) 1./sqrt(0.01+x.^2);
fplot(f,[0 1])
for k = 1:length(n) 
  t = linspace(0,1,n(k)+1)';        % equally spaced nodes
  y = f(t);                         % interpolation data
  V = bsxfun( @power,t,(0:n(k)) );  % Vandermonde matrix
  c = V \ y;                        % polynomial coeffs (low->high)
  c = c(end:-1:1);                  % coeffs in MATLAB ordering
  
  kappa(k) = cond(V);
  err(k) = norm( f(x) - polyval(c,x), inf );
end
table(n,kappa,err)

%%
% The interpolation has become worthless.