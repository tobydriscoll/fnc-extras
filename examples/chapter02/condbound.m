%%
% MATLAB has a function @glsbegin@cond@glsend@ to compute $\kappa_2(\mathbf{A})$. 
% The family of _Hilbert matrices_ is famously badly condition. Here is the
% $7\times 7$ case. 
A = hilb(7);
kappa = cond(A)

%%
% Next we engineer a linear system problem to which we know the exact answer.
x_exact = (1:7)';
b = A*x_exact;

%%
% Now we perturb the data randomly but with norm $10^{-12}$.
randn('state',333);          % reproducible results 
dA = randn(size(A));  dA = 1e-12*(dA/norm(dA));
db = randn(size(b));  db = 1e-12*(db/norm(db));

%%
% We solve the perturbed problem using built-in pivoted LU and see how the
% solution was changed.
x = (A+dA) \ (b+db); 
dx = x - x_exact;

%%
% Here is the relative error in the solution.
rel_error = norm(dx) / norm(x_exact)

%%
% And here are upper bounds predicted using the condition number of the
% original matrix. 
b_bound = kappa * 1e-12/norm(b)
A_bound = kappa * 1e-12/norm(A)

%%
% Even if we don't make any manual perturbations to the data, machine
% epsilon does when we solve the linear system numerically.
x = A\b;
rel_error = norm(x - x_exact) / norm(x_exact)
rounding_bound = kappa*eps

%%
% Because $\kappa\approx 10^8$, it's possible to lose 8 digits of accuracy
% in the process of passing from $\mathbf{A}$ and $\mathbf{b}$ to
% $\mathbf{x}$. That's independent of the algorithm; it's inevitable once 
% the data are expressed in double precision. 

%%
% Now we choose an even more poorly conditioned matrix from this family.
A = hilb(14);
kappa = cond(A)

%%
% Before we even compute anything, note that $\kappa$ exceeds |1/eps|. In
% principle we might end up with an answer that is completely wrong.
rounding_bound = kappa*eps

%%
% MATLAB will notice the large condition number and warn us not to expect
% much from the result. 
x_exact = (1:14)';
b = A*x_exact;  x = A\b;

%%
% In fact the error does exceed 100%.
relative_error = norm(x_exact - x) / norm(x_exact)