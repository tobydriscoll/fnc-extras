%%
% First we define a triangular matrix with known eigenvalues, and a random
% vector $\bfb$.
lambda = 100 + (1:100);
A = diag(lambda) + triu(rand(100),1); 
u = rand(100,1);

%%
[Q,H] = arnoldi(A,u,40);
Km = b;
for m = 1:40  
    Hm = H(1:m,1:m); 
    eigmax(m,1) = max(eig(Hm));
    eigmin(m,1) = min(eig(Hm));
 end

%%
% The largest eigenvalue is converging nicely to 70. The smallest
% one may be converging to 21, but it suddenly jumps away to zero.
m = (1:40)';
table(m,eigmax,eigmin)

%%
% The linear system approximations show smooth linear convergence at first,
% but clearly breaks down and then diverges.
semilogy(m,abs(max(lambda)-eigmax),'.-'), hold on
semilogy(m,abs(min(lambda)-eigmin),'.-')
xlabel('m'), ylabel('|| b-Ax_m ||')    % ignore this line
axis tight, title('Residual for linear systems')   % ignore this line
