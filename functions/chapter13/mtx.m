function [F,X,Y] = mtx(f,x,y)
% MTX   Function evaluated on a two-dimensional grid.
% Input: 
%   f     callable function of two variables
%   x     vector of discrete values in the first variable (m+1 by 1)
%   y     vector of discrete values in the second variable (n+1 by 1)
% Output:
%   F     evaluation of f on the grid (m+1 by n+1)
%   X     evaluation of function x on the grid (m+1 by n+1)
%   Y     evaluation of function y on the grid (m+1 by n+1)

% Create the grid. 
[X,Y] = ndgrid(x,y);  

% Try to make sure the function does elementwise operations.
f = eval( vectorize(f) );

% Evaluate.
F = f(X,Y);

end
