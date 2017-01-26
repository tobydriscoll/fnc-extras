%% 
% Here is an SPD matrix of condition number 1000.
A = sprandsym(1000,0.005,1/1000,2);

%%
% Here is the solution without preconditioner. 
b = rand(1000,1);
[x,~,~,~,residPlain] = pcg(A,b,1e-10,300);

%%
% This version of incomplete $LU$ factorization simply prohibits fill-in
% for the factors.
[L,U] = ilu(A);

%%
% It does _not_ produce a true factorization of $A$.
normest( A - L*U )

%%
% The actual preconditioning matrix is $M=LU$. However, the |pcg| function
% allows setting the preconditioner by giving the factors independently. 
[x,~,~,~,residPrec] = pcg(A,b,1e-10,300,L,U);

%%
% The preconditioning is quite successful in this case.
semilogy(residPlain,'.-')
hold on
semilogy(residPrec,'.-')
