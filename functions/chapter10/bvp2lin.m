function [x,u] = bvp2lin(p,q,r,xspan,lval,rval,n)
% BVP2LIN Solve linear BVP, 2nd order finite differences.
% Input:
%   p,q,r   u'' + pu' + qu = r (functions)
%   xspan   endpoints of problem domain (vector)
%   lval    value at left boundary (scalar)
%   rval    value at right boundary (scalar)
%   n       number of subintervals (integer)
% Output:
%   x       collocation nodes (vector, length n+1)
%   u       solution at nodes (vector, length n+1)

[x,Dx,Dxx] = diffmat2(n,xspan);

P = diag(p(x));
Q = diag(q(x));
L = Dxx + P*Dx + Q;    % ODE expressed at the nodes
r = r(x);    

% Replace first and last rows using boundary conditions. 
I = eye(n+1); 
A = [ I(:,1)'; L(2:n,:); I(:,n+1)' ];
b = [ lval; r(2:n); rval ];

% Solve the system.
u = A\b;
