%%
% In MATLAB one uses the @glsbegin@normmatlab@glsend@ command.
x = [2;-3;1;-1]';
twonorm = norm(x)         % or norm(x,2)
infnorm = norm(x,inf)
onenorm = norm(x,1)