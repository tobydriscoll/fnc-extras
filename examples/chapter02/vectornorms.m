%%
% In MATLAB one uses the |norm| command.
x = [2;-3;1;-1]';
twonorm = norm(x)         % also norm(x,2)
infnorm = norm(x,inf)
onenorm = norm(x,1)