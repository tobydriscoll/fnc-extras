%%
% It's easy to get just the lower triangular part of any matrix using the \gls{tril} command.
A = magic(5)
L = tril(A)

%%
% We'll set up and solve a linear system with this matrix.
b = ones(5,1);
x = forwardsub(L,b)

%%
% It's not clear what the error in this answer is. However, the
% residual, while not zero, is virtually $\epsilon_M$ in size.
b - L*x

%%
% Next we'll engineer a problem to which we know the exact answer. You
% should be able to convince yourself that for any $\alpha$ and $\beta$,
%
% $$ \begin{bmatrix} 1 & -1 & 0 & \alpha-\beta & \beta \\ 0 & 1 & -1 & 0 &
% 0 \\ 0 & 0 & 1 & -1 & 0 \\ 0 & 0 & 0 & 1 & -1  \\ 0 & 0 & 0 & 0 & 1
% \end{bmatrix} \begin{bmatrix} 1 \\ 1 \\ 1 \\ 1 \\ 1 \end{bmatrix}
% = \begin{bmatrix} \alpha \\ 0 \\ 0 \\ 0 \\ 1 \end{bmatrix}.$$
alpha = 0.3;
beta = 2.2;
U = eye(5) + diag([-1 -1 -1 -1],1);
U(1,[4 5]) = [ alpha-beta, beta ];

x_exact = ones(5,1);
b = [alpha;0;0;0;1];

%%
x = backsub(U,b);
err = x - x_exact

%%
% Everything seems OK here. But another example, with a different value for
% $\beta$, is more troubling.
alpha = 0.3;
beta = 1e12;
U = eye(5) + diag([-1 -1 -1 -1],1);
U(1,[4 5]) = [ alpha-beta, beta ];
b = [alpha;0;0;0;1];

x = backsub(U,b);
err = x - x_exact

%%
% It's not so good to get four digits of accuracy after starting with
% sixteen! But the source of the error is not hard to track down. Solving
% for $x_1$ performs $(\alpha-\beta)+\beta$ in the first row. Since
% $|\alpha|$ is so much smaller than $|\beta|$, this a recipe for losing
% digits to subtractive cancellation.
