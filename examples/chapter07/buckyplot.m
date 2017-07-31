%%
% Here is the adjacency matrix of a graph with 60 nodes from a builtin MATLAB 
% function.  
[A,v] = bucky;
size(A)

%%
% The extra vector $v$ gives particular coordinates for each node on the
% unit sphere. Plotting the nodes and edges with these coordinates reveals
% beautiful structure.
gplot(A,v), axis equal

%%
% As you can see, the edges resemble those on a soccer ball. The same
% structure, when made of carbon atoms at the nodes, is called a
% _buckyball_ in materials science.
