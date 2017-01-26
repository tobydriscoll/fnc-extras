%% 
% We look at an artificial example. First we create a pseudo-random
% $300\times 300$ SPD matrix with density $0.5$\% and condition number
% equal to $400$.
A = sprandsym(300,0.005,1/400,1);

%%
% Now we solve a linear system with a random right-hand side, without
% preconditioner.
b = rand(300,1);
[x,~,~,~,residPlain] = pcg(A,b,1e-10,300);

%%
% A |spy| plot reveals that most of the nonzero elements of $A$
% are on the diagonal. 
spy(A)

%%
% So we try letting the preconditioner $M$ equal just the diagonal part of
% $A$. The |pcg| function allows us to give $M$ as one of the arguments.
M = spdiags(diag(A),0,300,300);
[x,~,~,~,residPrec] = pcg(A,b,1e-10,300,M);

%%
semilogy(residPlain,'.-')
hold on
semilogy(residPrec,'.-')

%%
% The convergence has been much accelerated by the preconditioner.