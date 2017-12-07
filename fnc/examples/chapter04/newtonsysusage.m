%% 
% We repeat @exarefbegin@newtonsystem@exarefend@. The system is again
% defined by its residual and Jacobian, but this time we implement them as
% a single function.

    function [f,J] = nlsystem(x)
        f = zeros(3,1);   % ensure a column vector output
        f(1) = exp(x(2)-x(1)) - 2;
        f(2) = x(1)*x(2) + x(3);
        f(3) = x(2)*x(3) + x(1)^2 - x(2);
        J(1,:) = [-exp(x(2)-x(1)),exp(x(2)-x(1)), 0];
        J(2,:) = [x(2), x(1), 1];
        J(3,:) = [2*x(1), x(3)-1, x(2)];
    end

%%
% Our initial guess is the origin. The output has one column per iteration.
x1 = [0;0;0];   % column vector!
x = newtonsys(@nlsystem,x1);
[~,num_iter] = size(x)

%%
% The last column contains the final Newton estimate. We'll compute the
% residual there in order to check the quality of the result.
r = x(:,end)
back_err = norm(nlsystem(r))

%%
% Let's use the convergence to the first component of the root as a proxy
% for the convergence of the vectors.
log10( abs(x(1,1:end-1)-r(1)) )'

%%
% The exponents approximately double, as is expected of quadratic
% convergence. 
