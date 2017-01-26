%%
% In this example we use a diagonal matrix with prescribed
% eigenvalues. Although to us the problem is trivial, Arnoldi gains no
% advantage from a diagonal matrix, so the results are generic.
n = 500;
lambda = [-20; -15; linspace(-10,-1,n/2-3)'; 
    0; linspace(1,2,n/2-1)'; 4];
A = spdiags(lambda,0,n,n);  

%%
% We run the Arnoldi iteration for 20 steps. In practice the eigenvalue
% estimates can be computed after each update to the Arnoldi matrices. Here
% we look at the estimates in an 8-dimensional Krylov space. 
u = randn(n,1);
[Q,H] = arnoldi(A,u,20);
format long, eig( H(1:8,1:8) )

%%
% The eigenvalue at -20 has been located fairly well, but the others are not
% very meaningful. 

%%
% A systematic look reveals a pattern. The outermost, isolated eigenvalues
% are found rapidly, while the continuum-like and isolated interior
% eigenvalues are far less accurate. 
clf, hold on
for m=1:16,
    mu = eig(H(1:m,1:m));
    plot(m,real(mu),'k.')
end
plot(17,lambda,'b.')
