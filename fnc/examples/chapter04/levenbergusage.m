function levenbergusage   % ignore this line
%% 
% We repeat @exarefbegin@newtonsysusage@exarefend@. We need to code only the 
% function defining the system, and not its Jacobian.

    function f = nlsystem(x)
        f = zeros(3,1);   % ensure a column vector output
        f(1) = exp(x(2)-x(1)) - 2;
        f(2) = x(1)*x(2) + x(3);
        f(3) = x(2)*x(3) + x(1)^2 - x(2);
    end

%%
% In all other respects usage is the same as for the |newtonsys|
% function. 
x1 = [0;0;0];   
x = levenberg(@nlsystem,x1);

%%
% It's always a good idea to check the accuracy of the root, by measuring
% the residual (backward error). 
r = x(:,end)
backward_err = norm(nlsystem(r))

%%
% Looking at the convergence of the first component, we find a
% subquadratic convergence rate, just as with the secant method.
log10( abs(x(1,1:end-1)-r(1)) )'

end   % ignore this line
