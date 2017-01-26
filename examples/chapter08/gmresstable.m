%%
% Here we show that the Arnoldi iteration is the foundation for a good linear
% system solver using the least squares idea. Define a random matrix and
% arbitrary right-hand side for $A\bfx=\bfb$.
A = rand(50) + 50*eye(50);
b = ones(50,1);

%%
% The Arnoldi iteration gives us an orthogonal basis for the Krylov space
% over which we will minimize. 
[Q,H] = arnoldi(A,b,20);

%%
% Say we minimized the linear system residual over $\ck_3$. Then the
% equivalent least squares system is $H_3\bfz \approx \|\bfb\| \bfe_1$,
% solved here using backslash:
S = H(1:4,1:3);
r = norm(b)*eye(4,1);
z = S \ r

%%
% Because we started with the assumption that $\bfx=Q_3 \bfz$, the vector
% $\bfz$ gives the coefficients of the best $\bfx$ that can be found using
% a combination of $\bfq_1,\bfq_2,\bfq_3$, or equivalently,
% $\bfb,A\bfb,A^2\bfb$. 
x = Q(:,1:3)*z;
residual3 = norm( b - A*x )

%%
% If we repeat the minimization over the space $\ck_4$, the solution we get
% can only be better, because $\ck_3\subset \ck_4$. So we should expect a
% monotonically decreasing (technically, nonincreasing) residual norm.
for m = 1:20
    S = H(1:m+1,1:m);
    r = norm(b)*eye(m+1,1);
    z = S \ r;
    x = Q(:,1:m)*z;
    residual(m) = norm( b - A*x );
end
semilogy(residual,'.-')