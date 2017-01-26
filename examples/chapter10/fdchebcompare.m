%%
% We will compare the finite difference (2nd order) and Chebyshev
% collocation methods on the linear equation, $u''-xu=0$, for which MATLAB
% has a built-in exact solution.
exact = @(x) airy(0,x);
a = -15;  b = 5;
fplot(exact,[a,b])

%%
% In order to make the fairest possible comparison, we will use sparse
% matrices in the finite difference discretizations, in order to exploit
% the banded structure of the linear algebra system, and measure running
% time instead of showing convergence as a function of $n$.
n_ = [400:200:2000 2500:500:5000]';
FD_error = 0*n_;  FD_time = 0*n_;

for k = 1:length(n_)
    n = n_(k); 
    [x,Dx,Dxx] = diffmats(a,b,n);
    I = speye(n+1);
    E = I(2:n,:);

    A = sparse( Dxx - diag(x) );
    Z = [ I(:,1)'; E*A; I(:,n+1)' ];
    s = [ exact(a); zeros(n-1,1); exact(b) ];
    tic,  u = Z\s;  FD_time(k) = toc;   
    FD_error(k) = norm(exact(x)-u,inf);
end

loglog(FD_time,FD_error,'.-')

%%
% Both the running time and the error convergence are asymptotically powers
% of $n$, so we see roughly a straight line on the log--log scale.

%%
% The Chebyshev collocation method has no sparse structure to exploit.
n_ = (40:5:100)';
Cheb_error = 0*n_;   Cheb_time = 0*n_;

for k = 1:length(n_)
    n = n_(k); 
    [x,Dx,Dxx] = diffcheb(n,[a,b]);
    I = eye(n+1);
    E = I(2:n,:);

    A = Dxx - diag(x);
    Z = [ I(:,1)'; E*A; I(:,n+1)' ];
    s = [ exact(a); zeros(n-1,1); exact(b) ];
    tic,  u = Z\s;  Cheb_time(k) = toc;   
    Cheb_error(k) = norm(exact(x)-u,inf);
end

hold on, loglog(Cheb_time,Cheb_error,'.-')
legend('Finite diffs','Chebyshev','location','southeast')

%%
% The lack of sparsity is much more than compensated for by the spectral
% convergence rate. The $n$ needed by Chebyshev collocation is so small
% that a 14-digit-accurate solution requires essentially no more time than
% a 4-digit one!
