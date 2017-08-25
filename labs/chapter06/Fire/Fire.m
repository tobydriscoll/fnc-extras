%% 1. Reference solution
f = @(t,r) r^2*(1-r);
tspan = [0 500];
opt = odeset('reltol',1e-12,'abstol',1e-12);
sol = ode15s(f,tspan,0.01,opt);
ref = @(t) deval(sol,t);
% You can now evaluate ref(t) to get the solution at time t. 

%*** Plot the reference solution over [0,500]

%% 2. Convergence at t=100
tspan = [0 100];
n = 100*[1 2 4 8 16 64 256];
err = zeros(size(n));

%*** Compute Euler error at t=100 for each n.

loglog(n,err,'-o')
title('Convergence at t=100')
xlabel('n')
ylabel('error')

%*** Add a curve to the plot for first-order error.

%% 3. Convergence at t=200
%*** Repeat step 2 for t=200. 

loglog(n,err,'-o')
title('Convergence at t=200')
xlabel('n')
ylabel('error')

%% 4. Solutions as functions of time
n = [150 200 250];

%*** Plot r(t) versus t for each n, over t in [0,500].

