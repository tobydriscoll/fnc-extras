%%
% We illustrate a few steps of the Arnoldi iteration for a small matrix.
A = magic(6);

%%
% The seed vector determines the first member of the orthonormal basis.
u = randn(6,1);
Q = u/norm(u);

%%
% Multiplication by $\mathbf{A}$ gives us a new vector in $\ck_2$. 
Aq = A*Q(:,1);

%% 
% We subtract off its projection in the previous direction. The remainder
% is rescaled to give us the next orthonormal column.
v = Aq - (Q(:,1)'*Aq)*Q(:,1);
Q(:,2) = v/norm(v);

%%
% On the next pass, we have to subtract off the projections in two previous
% directions.
Aq = A*Q(:,2);
v = Aq - (Q(:,1)'*Aq)*Q(:,1) - (Q(:,2)'*Aq)*Q(:,2);
Q(:,3) = v/norm(v);

%%
% At every step, $\mQ_m$ is an ONC matrix.
norm( Q'*Q - eye(3) )

%%
% And $\mQ_m$ spans the same space as the 3-dimensional Krylov matrix.
K = [ u A*u A*A*u ];
rank( [Q,K] )
