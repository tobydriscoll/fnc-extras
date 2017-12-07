%%
% $\relax$
m = 2;  n = 3;
v = (1:6)';

%%
% The unvec operation:
V = reshape(v,2,3)   

%%
% Two equivalent syntaxes for the vec operation:
reshape(V,6,1);      
v = V(:)                 