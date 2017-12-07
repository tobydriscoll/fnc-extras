%%
format long    % show all the digits
a = 1;  b = -(1e6+1e-6);  c = 1;

%%
% First, we find the ``good'' root using the quadratic forumla. 
x1 = (-b + sqrt(b^2-4*a*c)) / (2*a);

%%
% Then we use the better formula for computing the other root. 
x2 = c/(a*x1)