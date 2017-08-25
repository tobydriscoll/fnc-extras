%% 1. Load data
%*** Load and plot data

title('Data points')
xlabel('time')
ylabel('mass of tumor')

%% 2. Write function gomp.m (separate file)
%*** Change nothing here.
type gomp

%% 3. Least squares fit
%*** Make a call to levenberg. 
%*** Keep the last column as the solution for x.

%% 4. Limiting (asymptotic) tumor size
%*** Compute A.

%% 5. Plot the fit with the data
tt = linspace(0,40,200);
hold on
%*** Plot the fit as a function of the entries of tt.

title('Data and least squares fit')

