%%
% Finding numerical approximations to $\pi$ has fascinated people for
% millenia. One famous formula is
%
% $$ \frac{\pi^2}{6} = 1 + \frac{1}{2^2} + \frac{1}{3^2} + \cdots.$$

%%
% Say $s_k$ is the sum of the first $k$
% terms of the series above, and $p_k = \sqrt{6s_k}$. Here is a fancy way
% to compute these sequences in a compact code.
k = (1:100)';
s = cumsum( 1./k.^2 );   % cumulative summation
p = sqrt(6*s);
plot(k,p,'.-')

%% 
% This graph suggests that $p_k\to\pi$ but doesn't give much information
% about the rate of convergence. Let $\epsilon_k = |\pi - p_k|$ be the
% sequence of errors. By plotting the error sequence on a log-log scale, we 
% can see a nearly linear relationship.
ep = abs(pi-p);    % error sequence
loglog(k,ep,'.'), title('log-log convergence')
xlabel('k'), ylabel('error'),  axis tight    % ignore this line

%%
% This suggests a power-law relationship where $\epsilon_k\approx a k^b$,
% or $\log \epsilon_k \approx b (\log k) + \log a$.
V = [ k.^0, log(k) ];    % fitting matrix
c = V \ log(ep)          % coefficients of linear fit

%%
% In terms of the parameters $a$ and $b$ used above, we have 
a = exp(c(1)),  b = c(2),

%%
% It's tempting to conjecture that $b=-1$ asymptotically. Here is how the
% numerical fit compares to the original convergence curve. 
hold on, loglog(k,a*k.^b,'r'), title('power-law fit')
axis tight    % ignore this line
