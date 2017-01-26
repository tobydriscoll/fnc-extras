%%
% Here is a matrix with prescribed eigenvalues. 
n = 500;  format long
lambda = [-20; -15; linspace(-10,-1,n/2-3)'; 
    0; linspace(1,2,n/2-1)'; 4];
A = spdiags(lambda,0,n,n);  

%%
% Given no extra information, |eigs| will tend to find outlying eigenvalues
% first, just as we saw in our own Arnoldi implementation. Here we ask to
% get three of them accurately.
eigs(A,3)

%%
% Through more or less the same shift-and-invert strategy that we used with
% power iteration, we can request eigenvalues close to any particular
% complex value.
eigs(A,4,0.5)

%%
% And |eigs| can perform matrix-free iterations as well. Instead of a
% matrix as the first argument, we can supply a function that computes the
% value of a linear transformation for any given vector. We also have to
% specify the dimension of the matrix. 
lin_trans = @(x) A*x;
eigs(lin_trans,n,3)

%%
% Applying shift-and-invert using a linear transformation is more
% nuanced. The function you provide should calculate not $A\bfx$ but
% $(A-s I)^{-1}\bfx$ for a given shift $s$. Here we provide the function
% using the built-in backslash. 
s = 0.5;
fun = @(x) (A-s*speye(n)) \ x;
eigs(fun,n,3,s)

%%
% Thus, we are in the same situation we were in with inverse iteration. In
% order to converge to particular eigenvalues, we have to be able to solve
% a (large, sparse) linear system repeatedly.


