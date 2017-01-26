%%
% We repeat the exa
format long    % show all the digits
a = 1;  b = -(1e6+1e-6);  c = 1;

%%
% The ``good'' root. 
x1 = (-b + sqrt(b^2-4*a*c)) / (2*a);

%%
% The better formula for computing the other root. 
x2 = c/(a*x1)