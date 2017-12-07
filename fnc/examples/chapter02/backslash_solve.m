%%
% For a square matrix $\mathbf{A}$, the command |A\b| is mathematically
% equivalent to $\mathbf{A}^{-1}\mathbf{b}$. 
A = magic(3)
b = [1;2;3];
x = A\b

%%
% One way to check the answer is to compute a quantity known as the
% residual. It is (hopefully) close to machine precision, scaled by the
% size of the entries of the data.
residual = b - A*x

%%
% If the matrix is singular, a warning is produced, but you get an answer
% anyway.
A = [0 1; 0 0];   % known to be singular
b = [1;2];
x = A\b

%%
% When you get a warning, it's important to check the result rather than 
% blindly accepting it as correct.