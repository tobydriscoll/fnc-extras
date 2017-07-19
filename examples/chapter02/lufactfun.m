A = [2 0 4 3; -4 5 -7 -10; 1 15 2 -4.5; -2 0 2 -13];
[L,U] = lufact(A)

%%
LtimesU = L*U

%%
% Because MATLAB doesn't show all the digits by default, it's best to
% compare two quantities by taking their difference.
A - LtimesU

%%
% (Usually we can expect ``zero'' only up to machine precision. However, all
% the exact numbers in this example are also floating-point numbers.)

%%
% To solve a linear system, we no longer need the matrix $\bm{A}$. 
b = [4;9;29;40];
z = forwardsub(L,b);
x = backsub(U,z)

%%
b - A*x