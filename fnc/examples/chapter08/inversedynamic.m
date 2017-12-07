%%
lambda = [1 -0.75 0.6 -0.4 0];
A = triu(ones(5),1) + diag(lambda); 
format long

%%
% We begin with a shift $s=0.7$, which is closest to the eigenvalue 0.6.
I = eye(5);  s = 0.7;
x = ones(5,1);
y = (A-s*I)\x;  gamma = x(1)/y(1) + s

%%
% Note that the result is not yet any closer to the targeted $0.6$. But we
% proceed (without being too picky about normalization here).
s = gamma;
x = y/y(1);
y = (A-s*I)\x;  gamma = x(1)/y(1) + s

%%
% Still not much apparent progress. However, in just a few more iterations
% the results are dramatically better.
for k = 1:4
    s = gamma;  x = y/y(1);
    y = (A-s*I)\x;  gamma = x(1)/y(1) + s
end
