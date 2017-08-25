%% 1. Plot norm of blurring versus n
n = 50:50:800;
normB = 0*n;  
for i = 1:length(n)
    %*** Let normB(i) be the norm of blur matrix of size n(i)
end

plot(n,normB,'o-')
xlabel('n'), ylabel('||B_n||')
title('Norms of blur matrices')

%% 2. Plot conditioning of blurring versus n
%*** Let condB(i) be the conditioning of blur matrix of size n(i)
    
loglog(n,condB,'o-')  
xlabel('n'), ylabel('\kappa(B_n)')
title('Conditioning of blur matrices')

%% 3. Plot conditioning versus number of blurs
k = (1:8)';
condV = zeros(8,1);
for i = 1:8
    %*** Let condV(i) be the conditioning of (blur_matrix_100)^k(i)
end

semilogy(k,condV,'o-')  
xlabel('k'), ylabel('\kappa(B^k)')
title('Conditioning of blur matrix powers')

%% 4. Blur and deblur a random "image" vector
x = rand(n,1);
%*** Let error(i) be relative error of blur/deblur k(i) times

table(k,condV*eps,error,'variablenames',{'k','upper_bound','error'})