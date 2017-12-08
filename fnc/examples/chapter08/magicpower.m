%%
% Here we let $\mathbf{A}$ be a $5\times 5$ matrix. We also choose a random
% 5-vector.
A = magic(5)/65;
x = randn(5,1)

%%
% Applying matric-vector multiplication once doesn't do anything
% recognizable.
y = A*x

%%
% Repeating the multiplication still doesn't do anything obvious.
z = A*y

%%
% But if we keep repeating the matrix-vector multiplication,
% something remarkable happens: $\mathbf{A}\mathbf{x}\approx \mathbf{x}$. 
for j = 1:8,  x = A*x;  end
[x,A*x]

%%
% This seems to occur regardless of the starting value of $\bfx$. 
x = randn(5,1)
for j = 1:8,  x = A*x;  end
[x,A*x]
