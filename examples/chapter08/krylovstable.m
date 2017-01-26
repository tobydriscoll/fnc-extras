%%
% First we define a triangular matrix with known eigenvalues, and a random
% vector $\bfb$.
lambda = 10 + (1:100);
A = diag(lambda) + triu(rand(100),1); 
b = rand(100,1);

%%
% Next we build up the first ten Krylov matrices and compute the
% least-squares solutions in the corresponding column spaces.
[Q,H] = arnoldi(A,b,60);
for m = 1:60  
    s = [norm(b); zeros(m,1)];
    z = H(1:m+1,1:m)\s;
    xm = Q(:,1:m)*z;
    resid(m) = norm(b-A*xm);
 end

%%
% The approximations converge smoothly, practically all the way to machine
% epsilon.
semilogy(resid,'.-')
xlabel('m'), ylabel('|| b-Ax_m ||')    % ignore this line
axis tight, title('Residual for GMRES')   % ignore this line
