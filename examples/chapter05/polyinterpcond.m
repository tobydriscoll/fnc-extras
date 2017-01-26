%%
% In \exaref{polyinterpbad} the algorithm was to find a
% polynomial interpolant for $n+1$ equally spaced nodes in $[-1,1]$. There
% was nothing very special about the data we interpolated, as we can tell
% by looking at interpolations of columns of the identity.
n = 5;
t = linspace(-1,1,n+1)';
I = eye(n+1);
for k = 0:n
    c = polyfit(t,I(:,k+1),n);
    p = @(x) polyval(c,x);
    hold on, fplot(p,[-1 1])
end
title('Polynomial cardinal functions')     % ignore this line
xlabel('x'), ylabel('p(x)')   % ignore this line

%% 
% There's little evidence of growth in that picture. But growth emerges as
% $n$ increases. We can estimate the norm of an interpolant by evaluating
% it at a large number of points. 
kappa = [];  warning off
x = linspace(-1,1,8000)';
for n = 2:2:50
    t = linspace(-1,1,n+1)';
    e = [ zeros(n/2,1); 1; zeros(n/2,1) ];  % middle column of identity
    c = polyfit(t,e,n);
    kappa = [ kappa; norm( polyval(c,x), inf ) ];
end
clf, semilogy(2:2:50,kappa,'.-')
axis tight, title('Conditioning of equispaced polynomial interpolation')    % ignore this line
xlabel('degree'), ylabel('\kappa')   % ignore this line