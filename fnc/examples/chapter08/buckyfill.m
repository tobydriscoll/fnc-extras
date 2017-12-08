%%
% Here is the buckyball adjacency matrix again.
[A,v] = bucky;

%%
% The number of vertex pairs on a soccer ball connected by a path of length
% $k>1$ grows with $k$, as can be seen here for $k=3$.
subplot(1,2,1), spy(A)
title('A')     % ignore this line
subplot(1,2,2), spy(A^3)
title('A^3')   % ignore this line
