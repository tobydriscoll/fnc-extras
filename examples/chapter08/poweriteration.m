%%
% We set up a $5\times 5$ matrix with prescribed eigenvalues, then apply
% the power iteration.
lambda = [1 -0.75 0.6 -0.4 0];
A = triu(ones(5),1) + diag(lambda)   % triangular matrix, eigs on diagonal

%%
% We run the power iteration 60 times. The best estimate of the dominant
% eigenvalue is the last entry of |gamma|. 
[gamma,x] = poweriter(A,60);
eigval = gamma(end)

%%
% We check linear convergence using a log-linear plot of the error. We use
% our best estimate in order to compute the error at each step.
err = eigval - gamma;
semilogy(abs(err),'.-')
title('Convergence of power iteration')   % ignore this line
xlabel('k'), ylabel('|\lambda_1 - \gamma_k|')    % ignore this line

%%
% The trend is clearly a straight line asymptotically. We can get a refined
% estimate of the error reduction in each step by using the exact
% eigenvalues.
theory = lambda(2)/lambda(1)
observed = err(40)/err(39)

%%
% Note that the error is supposed to change sign on each iteration. An
% effect of these alternating signs is that estimates oscillate around the
% exact value.
format long
gamma(36:40)'
