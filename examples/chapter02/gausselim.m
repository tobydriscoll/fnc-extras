%%
% We create a 4-by-4 linear system with the matrix
A = [
    2   0   4   3 
    -4   5   -7   -10 
    1   15   2   -4.5
    -2   0   2   -13
    ];
%%
% and with the right-hand side
b = [ 4; 9; 29; 40 ];

%%
% We define an _augmented matrix_ by tacking $\mathbf{b}$ on the end as a new
% column.
S = [A, b]

%%
% The goal is to introduce zeros into the lower triangle of the matrix. By
% using only elementary row operations, we ensure that the matrix
% $\mathbf{S}$ always represents a linear system that is equivalent to the
% original. We proceed from left to right and top to bottom. The first step
% is to put a zero in the (2,1) location using a multiple of row 1:
mult21 = S(2,1)/S(1,1)
S(2,:) = S(2,:) - mult21*S(1,:)

%%
% We repeat the process for the (3,1) and (4,1) entries. 
mult31 = S(3,1)/S(1,1)
S(3,:) = S(3,:) - mult31*S(1,:);
mult41 = S(4,1)/S(1,1)
S(4,:) = S(4,:) - mult41*S(1,:);
S

%%
% The first column has the zero structure we want. To avoid interfering
% with that, we no longer add multiples of row 1 to anything. Instead, to
% handle column 2, we use multiples of row 2. We'll also exploit the highly
% repetitive nature of the operations to write them as a loop. 
for i = 3:4
    mult = S(i,2)/S(2,2);
    S(i,:) = S(i,:) - mult*S(2,:);
end
S

%%
% We finish out the triangularization with a zero in the (4,3) place. It's
% a little silly to use a loop for just one iteration, but the point is to
% establish a pattern.
for i = 4
    mult = S(i,3)/S(3,3);
    S(i,:) = S(i,:) - mult*S(3,:);
end
S

%%
% Recall that $\mathbf{S}$ is an augmented matrix: it represents the system
% $\mathbf{U} \mathbf{x} = \mathbf{z}$, where 
U = S(:,1:4)
z = S(:,5)

%%
% The solutions to this system are identical to those of the original
% system, but this one can be solved by backward substitution.
x = backsub(U,z)

%%
b - A*x

