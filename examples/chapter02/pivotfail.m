%%
% Here is the previously solved system.
A = [2 0 4 3 ; -4 5 -7 -10 ; 1 15 2 -4.5 ; -2 0 2 -13]
b = [ 4; 9; 29; 40 ]

%%
% It has a perfectly good solution, obtainable through LU factorization.
[L,U] = lufact(A);
x = backsub( U, forwardsub(L,b) )

%%
% If we swap the second and fourth equations, nothing essential is changed,
% and MATLAB still finds the solution.
A([2 4],:) = A([4 2],:);  b([2 4]) = b([4 2]);    % row swaps
x = A\b   

%%
% However, LU factorization fails.
[L,U] = lufact(A);
L 

