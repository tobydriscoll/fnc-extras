%%
% Here is the buckyball adjacency matrix again.
[A,v] = bucky;

%%
% It's not hard to prove that the $(i,j)$ entry of $\mA^{\!k}$ is the number of
% paths of length $k$ between nodes $i$ and $j$. Hence, matrices
% $\mA^{\!k}$ tend to become denser as $k$ increases.
subplot(1,2,1), spy(A)
subplot(1,2,2), spy(A^3)