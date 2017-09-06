%% 1. Load data
load shapes
[m,n] = size(T)

%% 2. Raw data
%*** Plot first 3 columns of T.

xlabel('arclength s'), ylabel('\theta(s)')
title('Data')

%% 3. Compute the thin SVD
%*** Compute U, S, and V using svd.

%% 4. Analyze the singular values
%*** Plot 1-tau_r as function of r.

xlabel('r'), ylabel('1-\tau_r')
title('Fraction of uncaptured variance')

%% 5. Plot the eigenworms (as theta(s))
clf

%% 6. Projection onto eigenworms
%*** Find and plot the least squares projections of the first 3 columns.

xlabel('arclength s'), ylabel('\theta(s)')
title('Data projected onto eigenworms')
