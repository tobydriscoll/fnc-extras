%% Conditioning of roots of a quadratic polynomial

%% 1. Define exact roots t1 and t2. 
%*** Get the definitions for t1 and t2 from the Preparation of the lab. 

%% 2. Compute error and kappa at s = -0.1.
s = -0.1;
%*** Get the roots of p(x;s). 
%*** Compute the error.
%*** Compute the condition number.

%% 3. Compute error and kappa in a loop.
s = linspace(-1,1,800)';
err1 = zeros(size(s));
kappa = zeros(size(s));
for j = 1:length(s)
    %*** Compute err1(j) and kappa(j) for s(j).
end

subplot(121)
plot(s,err1)
xlabel('s')
ylabel('error')
title('Error')
subplot(122)
plot(s,kappa)
xlabel('s')
ylabel('\kappa')
title('Conditioning')

%% 4. Repeat for logarithmically spaced s.
s = logspace(-15,-1,100)';
%*** Repeat the loop from section 3. 

subplot(121)
loglog(s,err1)
xlabel('s')
ylabel('error')
title('Error')
subplot(122)
loglog(s,kappa)
xlabel('s')
ylabel('\kappa')
title('Conditioning')
