%% You've been slimed

%% 1. Euler for small m and a short time
m = 50;
chi = 6; ep = 0.1;
T = 0.05;  n = 100;  
tau = T/n;  t = tau*(0:n)';
U = zeros(m,n+1);  V = U;

%*** Use finite differences with Euler to solve the problem.

waterfall(x,t,U')
xlabel('x'), ylabel('t')
title('Euler solution for m=50')

%% 2. Euler for larger m and longer time
m = 200;
[x,Dx,Dxx] = diffper(m,[-1 1]);

T = 0.6;  n = 1500;

done = false;
while ~done
    n = n+500;
    U = zeros(m,n+1);  V = U;
   
    %*** Solve by Euler and set done=true if the final solution is finite.
end

fprintf('stable n = %i\n\n',n)
%*** Plot the solution at the final time. 

%% 3. Time-derivative function for IVP solver
%*** Write the function timederiv.m in a separate file. Change nothing here.
type timederiv

%% 4. Stiff solver

%*** Use ode15s to solve the problem of step 2.

%*** Plot as in step 1.

%% 5. Multiple starting bumps

%*** Repeat step 4 with new initial condition.
