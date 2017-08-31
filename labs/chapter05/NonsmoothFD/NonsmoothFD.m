%% 1. Errors in the smooth case
f = @(x) exp(sin(x+1));
exact = cos(1)*exp(sin(1));

h = 2.^(-1:-1:-10);

%*** Apply 3 finite difference formulas for all values of h

%*** Make a log-log plot of error for the 3 formulas

xlabel('h'), ylabel('error')
title('Convergence in control case')
legend('W_1','W_2','W_4')
set(gca,'xdir','reverse')

%% 2. Add lines for convergence rates

%*** One dashed line each for orders 1,2,3,4

legend('W_1','W_2','W_4','O(h)','O(h^2)','O(h^3)','O(h^4)')

%% 3. Function g_1
clf
%*** Define f as directed in the lab.
%*** Plot f over [-0.25,0.25].

%% 4. Convergence for g_1
clf
%*** Repeat steps 1-2 for the new f.

%% 5. Convergence for g_2
clf
%*** Change f as directed and repeat steps 1-2 again.
