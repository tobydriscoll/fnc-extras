%%
% We apply the quadratic formula to find the roots of~\eqref{eq:quadunstable}.
format long    % show all the digits
a = 1;  b = -(1e6+1e-6);  c = 1;

%%
x1 = (-b + sqrt(b^2-4*a*c)) / (2*a)

%%
x2 = (-b - sqrt(b^2-4*a*c)) / (2*a)

%%
% The first value is correct to all stored digits, but the second has fewer
% than six accurate digits:
-log10(  abs(1e-6-x2)/1e-6 )
