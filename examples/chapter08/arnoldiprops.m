%%
% Here we validate the output of |arnoldi| on a random matrix by checking
% the claimed properties of the iteration.
n = 50;
A = rand(n) + 50*eye(n);
b = ones(n,1);

%%
% 
m = 4;
[Q,H] = arnoldi(A,b,m);
szQ = size(Q)   % should be $n\times (m+1}$
ortho_check = norm( Q'*Q - eye(m+1) )

%%
% Check the upper Hessenberg structure of $H$ by visual inspection.
H

%%
% Finally, we check the validity of the fundamental Arnoldi identity. 
norm( A*Q(:,1:m) - Q(:,1:m+1)*H(1:m+1,1:m) )
