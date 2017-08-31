%% 1. Load and plot data
load pressuredata
%*** Make a labeled plot.

%% 2. Straight line
%*** Set up matrix A and solve for c using backslash.

%*** Compute the residual norm.

hold on
plot(t,c(1) + c(2)*t)

%% 3. Quadratic and cubic fits
%*** Repeat step 2 for a quadratic polynomial fit.

%*** Repeat again for a cubic fit. 

%% 4. Periodic functions fit
%*** Create and plot a fit from periodic functions. 
