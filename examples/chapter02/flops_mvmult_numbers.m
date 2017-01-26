%%
% Here is a simple algorithm implementing the multiplication of an $n\times
% n$ matrix and an $n\times 1$ vector. We use only scalar operations here
% for maximum transparency. 
n = 6;
A = magic(n);
x = ones(n,1);
y = zeros(n,1);
for i = 1:n
    for j = 1:n
        y(i) = y(i) + A(i,j)*x(j);   % 2 flops
    end
end

%%
% Each of the loops implies a summation of operations. The total flop count
% for this algorithm is
%
% $$ \sum_{i=1}^n \sum_{j=1}^n 2 = \sum_{i=1}^n 2n = 2n^2.$$
%
%%
% Since the matrix $A$ has $n^2$ elements, all of which have to be involved
% in the product, it seems unlikely that we could get a flop count that is
% smaller than $O(n^2)$.
%%
% Let's run an experiment with the built-in matrix-vector multiplication.
% We use @glsbegin@tic@glsend@ and @glsbegin@toc@glsend@ to start and 
% end ``stopwatch" timing of the computation.
t_ = [];
n_ = 400:400:4000;
for n = n_
    A = randn(n,n);  x = randn(n,1);
    tic  % start a timer
    for j = 1:10  % repeat ten times
        A*x;
    end
    t = toc;      % read the timer
    t_ = [t_,t/10];  % time per instance
end

%%
% The reason for doing multiple repetitions at each value of $n$ is to
% avoid having times so short that the resolution of the timer is a factor.
% 

%%
fprintf('   n    time (sec)\n')
fprintf(' %4i    %7.2e\n',[n_;t_])
fprintf('\n\n')
