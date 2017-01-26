%%
% Let's repeat the experiment of the previous figure for more, and larger,
% values of $n$.
t_ = [];
n_ = 400:200:6000;
for n = n_
    A = randn(n,n);  x = randn(n,1);
    tic  % start a timer
    for j = 1:10  % repeat ten times
        A*x;
    end
    t = toc;  % read the timer
    t_ = [t_,t/10];  
end


%%
% Plotting the time as a function of $n$ on log-log scales is equivalent to
% plotting the logs of the variables, but is formatted more neatly. 
loglog(n_,t_,'.-')
xlabel('size of matrix'), ylabel('time (sec)')
title('Timing of matrix-vector multiplications')

%%
% You can see that the graph is trending to a straight line of positive
% slope. For comparison, we can plot a line that represents $O(n^2)$
% growth. (All such lines have slope equal to 2.)
hold on, loglog(n_,t_(1)*(n_/n_(1)).^2,'--')
axis tight
legend('data','O(n^2)','location','southeast')

%%
% It's too complicated to be a perfect match, but the asymptotic approach
% to $O(n^2)$ is unmistakable. 