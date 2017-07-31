function newtonsystem   % ignore this line
%% 
% Let us use Newton's method on the system defined by the function
    function f = nlvalue(x)
        f = zeros(3,1);   % ensure a column vector output
        f(1) = exp(x(2)-x(1)) - 2;
        f(2) = x(1)*x(2) + x(3);
        f(3) = x(2)*x(3) + x(1)^2 - x(2);
    end

%%
% Here is a function that computes the Jacobian matrix.
    function J = nljac(x)
        J(1,:) = [-exp(x(2)-x(1)),exp(x(2)-x(1)), 0];
        J(2,:) = [x(2), x(1), 1];
        J(3,:) = [2*x(1), x(3)-1, x(2)];
    end

%%
% (These functions could be written as separate files, or embedded within
% another function as we have done here.) Our initial guess at a root is
% the origin.
x = [0;0;0];   % column vector!

%%
% We need the value (residual) of the nonlinear function, and its Jacobian,
% at this value for $\mathbf{x}$. 
f = nlvalue(x);
J = nljac(x);

%%
% We solve for the Newton step and compute the new estimate. 
s = -(J\f);
x(:,2) = x(:,1) + s;

%%
% Here is the new residual.
format short e
f(:,2) = nlvalue(x(:,2))

%%
% We don't seem to be especially close to a root. Let's iterate a few more
% times. 
for n = 2:7
    f(:,n) = nlvalue(x(:,n));
    s = -( nljac(x(:,n)) \ f(:,n) );
    x(:,n+1) = x(:,n) + s;
end

%%
% We find the infinity norm of the residuals. 
residual_norm = max(abs(f),[],1)'   % max in dimension 1

%%
% We don't know an exact answer, so we will take the last computed value as
% its surrogate. 
r = x(:,end);
x = x(:,1:end-1);

%%
% The following will subtract r from every column of x.
z = size(x);
e = x - r*ones(1,z(2));

%%
% Now we take infinity norms and check for quadratic convergence. 
logerrs = log(abs( max(e,[],1)' ));
ratios = logerrs(2:end) ./ logerrs(1:end-1)

%%
% For a brief time, we see ratios around 2, but then the limitation of
% double precision makes it impossible for the doubling to continue. 

end   % ignore this line