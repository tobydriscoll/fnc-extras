%%
% We first construct a polynomial of degree six with known integer roots.
r = [-2 -1 1 1 3 6]';   % column vector of exact roots
p = poly(r)             % polynomial having those roots

%%
% Now we use MATLAB's built in function |roots| for finding them.
r_computed = sort( roots(p) )   % algorithmically computed roots

%%
% These are the relative errors in each computed root.
format short e
abs(r - r_computed) ./ r    

%%
% It seems that the forward error is acceptably small in all cases except
% the double root at $x=1$. This is not a surprise, though, given the poor
% conditioning at such roots. 

%% 
% Let's consider the backward error. The data in the rootfinding problem
% are the polynomial coefficients. We can apply |poly| to find the
% coefficients of the polynomial (that is, the data) whose roots were
% actually computed.
p_computed = poly(r_computed)

%%
% We find that in a relative sense, these coefficients are very close to
% those of the original, exact polynomial:
(p_computed - p) ./ p

%%
% In summary, even though there are some computed roots relatively far from
% their correct values, they are nevertheless the roots of a polynomial
% that is very close to the original.