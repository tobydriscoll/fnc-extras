%%
% Suppose we want to solve $e^x=x+c$ for multiple values of $c$. We can
% create functions for $f$ and $f'$ in each case.
for c = [2 4 7.5 11]
    f = @(x) exp(x) - x - c;
    dfdx = @(x) exp(x) - 1;
    x = newton(f,dfdx,1);  r = x(end);
    fprintf('root with c = %4.1f is %.14f\n',c,r)
end

%%
% The definition of |f| locks in whatever value is defined for |c| at the
% moment of definition. Even if we later change the value assigned to |c|,
% the function is unaffected.
f(r)
c = 100; f(r)

%%
% This can get a little tricky, because the function is not executed or
% checked at definition time. So you might discover an error such a
% definition only later in the code.
clear c
f = @(x) exp(x) - x - c;  % executes OK
c = 1;                    % does not change f  

%% 
% A call such as |f(1)| would create an error, since the assignment of |c|
% did not come until after |f| was defined.                