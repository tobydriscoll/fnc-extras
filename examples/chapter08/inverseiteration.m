%%
% We set up a $5\times 5$ matrix with prescribed eigenvalues.
lambda = [1 -0.75 0.6 -0.4 0];
A = triu(ones(5),1) + diag(lambda); 
format long

%%
% We run the inverse iteration with a shift $s=0.7$, and take the final
% estimate as our "exact" answer to observe the convergence. 
[gamma,x] = inviter(A,0.7,30);
eigval = gamma(end)

%%
% As expected, the eigenvalue that was found is the one closest to $0.5$.
% The convergence is again linear.
err = eigval - gamma;
semilogy(abs(err),'.-')
title('Convergence of inverse iteration')   % ignore this line
xlabel('k'), ylabel('|\lambda_1 - \gamma_k|')    % ignore this line

%%
% And the theory predicts the rate.
theory = (lambda(3)-0.7) / (lambda(1)-0.7)
observed = err(27)/err(26)
