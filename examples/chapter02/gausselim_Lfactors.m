%%
% We revisit the previous example using algebra to express the row
% operations. For brevity, we leave the $\mathbf{b}$ vector out. 
A = [2 0 4 3 ; -4 5 -7 -10 ; 1 15 2 -4.5 ; -2 0 2 -13];

%%
% We use the identity and its columns heavily.
I = eye(4);

%%
% The first step is to put a zero in the (2,1) location using a multiple of row 1:
mult21 = A(2,1)/A(1,1);
L21 = I - mult21*I(:,2)*I(:,1)';
A = L21*A

%%
% We repeat the process for the (3,1) and (4,1) entries. 
mult31 = A(3,1)/A(1,1);
L31 = I - mult31*I(:,3)*I(:,1)';
A = L31*A;

mult41 = A(4,1)/A(1,1);
L41 = I - mult41*I(:,4)*I(:,1)';
A = L41*A

%%
% And so on, following the pattern as before. 
