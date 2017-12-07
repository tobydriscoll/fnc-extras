%%
% We begin with a symmetric $\mA$. 
A = [  2     4     4     2
       4     5     8    -5
       4     8     6     2
       2    -5     2   -26 ];
   
%%
% Carrying out our usual elimination in the first column leads us to 
L1 = eye(4); L1(2:4,1) = [-2;-2;-1];
A1 = L1*A

%%
% But now let's note that if we transpose this result, we have the same
% first column as before! So we could apply $\mL_1$ again and then
% transpose back.
A2 = (L1*A1')'

%%
% Using transpose identities, this is just
A2 = A1*L1'

%%
% Now you can see how we proceed down and to the right, eliminating in a
% column and then symmetrically in the corresponding row.
L2 = eye(4);  L2(3:4,2) = [0;-3]; 
A3 = L2*A2*L2'

%%
% Finally, we arrive at a diagonal matrix.
L3 = eye(4); L3(4,3) = -1;
D = L3*A3*L3'