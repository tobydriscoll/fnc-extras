%% 1. Load data
%*** Load the data

%% 2. Memory usage and density
%*** Compute the density of nonzero elements.
%*** Find out the actual memory used.
%*** Calculate the memory for an equivalent full matrix.

%% 3. Outgoing edge degrees
%*** Calculate the outdegree s of each node

histogram(s,32)
title('Distribution of outdegree')
xlabel('s')
ylabel('number')

%% 4. Construct B
B = A';   % allocate space and initialize B
%*** Loop over columns of B.

%% 5. Power iteration
p = 0.9;
%*** Let x be a random probability vector.

%*** Do 100 power iterations.

%*** Check convergence of x.

%% 6. Get the top 10 actors. 
%*** Use x to sort in descending order.

%*** Find the actor names.
