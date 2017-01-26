%%
% First we define a triangular matrix with known eigenvalues, and a random
% vector $\bfb$.
lambda = 10 + (1:100);
A = diag(lambda) + triu(rand(100),1); 
b = rand(100,1);

%%
% Next we build up the first ten Krylov matrices and compute the
% least-squares solutions in the corresponding column spaces.
warning off    % ignore this line
Km = b;
for m = 1:30  
    z = (A*Km)\b;
    xm = Km*z;
    resid(m,1) = norm(b-A*xm);
    
    v = A*Km(:,m);
    Km(:,m+1) = v/norm(v);
end

%%
% The linear system approximations show smooth linear convergence at first,
% but clearly breaks down after only a relative few digits have been found.
semilogy(resid,'.-')
xlabel('m'), ylabel('|| b-Ax_m ||')    % ignore this line
axis tight, title('Residual for linear systems')   % ignore this line
