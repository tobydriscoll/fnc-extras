%% We didn't start the fire
clear all
close all

%% 1. Reference solution
r0 = 0.01;

%*** Define the high-accuracy reference solution r_hat as instructed.

clf
fplot(r_hat,[0 200])
xlabel('t'), ylabel('r(t)')
title('Reference (exact) solution')

%% 2. Euler solution with h=1

%*** Make a call to eulerivp to get t and r, using h=1
%*** (You must first figure out what n is.)

plot(t,r,t,r_hat(t))
xlabel('t'), ylabel('r(t)')
title('Exact solution and Euler method, h=1')

%% 3. Convergence of the Euler solution at t=100
n = (50:50:10000)';
err = [];
for i = 1:length(n)
    %*** Compute the Euler solution for n(i)
    %*** Compute the error at t=100 and assign it to err(i,1) in next line  
    err(i,1);
end

clf, loglog(n,abs(err),'-o')
xlabel('n'), ylabel('error')
title('Convergence of Euler at t=100')
hold on, axis tight
loglog([1000 8000],20./[1000 8000],'k--')
text(6000,25/6000,'O(n^{-1})')

%% 4. Convergence at t=500
n = (50:50:10000)';
err = [];
for i = 1:length(n)
    %*** Compute the Euler solution for n(i)
    %*** Compute the error at t=500 and assign it to err(i,1) in next line  
    err(i,1);
end

clf
loglog(n,abs(err),'-o')
xlabel('n'), ylabel('error')
title('Convergence of Euler at t=500')
hold on
loglog([1000 8000],20./[1000 8000],'k--')
text(6000,30/6000,'O(n^{-1})')

%% 5. Plot the Euler solutions as functions of time
clf
n = [100 150 200 250];
for i = 1:4
    subplot(4,1,i)

    %*** Compute solution for n(i), and plot it
    
    xlabel('t')
    ylabel('r(t)')
    title(['n = ' num2str(n(i))])
end
xlabel('t')
