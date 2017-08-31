%% 1. Write function spring.m
%*** Change nothing here.
type myspring

%% 2. Reference solution
%*** Define u0 and use the code given in the directions.
%*** Plot the solution, putting the number of steps in the title.
xlabel('t'), ylabel('y(t)')
str = sprintf('Reference solution, in %d steps',length(t)-1);
title(str)

%% 3. Phase plot of RK23 solution
%*** Solve using rk23, tol = 1e-4.
%*** Make a phase plot.
axis equal

%% 4. Convergence study
tol = 10.^(-2:-1:-12)';
err = 0*tol;
nsteps = 0*tol;

%*** For each tolerance, apply rk23, recording error and number of steps.

results = table;
results.Tolerance = tol;
results.Numsteps = nsteps;
results.Error = err

%% 5. Convergenge plot
clf

%*** Make log-log plot of error versus number of steps.

hold on
%*** Add lines for 2nd order and 3rd order convergence.

%% 6. Solution for stiffer spring
clf
%*** Redefine gamma = 5000 and repeat steps 2-3.

%% 7. Convergence with stiffer spring
%*** With gamma = 5000, repeat steps 4-5. 
