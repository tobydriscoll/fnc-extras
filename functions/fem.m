function [x,u] = fem(c,s,f,a,b,n)
%FEM     Piecewise linear finite elements for a linear BVP.
% Input:
%   c,s,f    coefficient functions of x describing the ODE (functions) 
%   a,b      domain of the independent variable (scalars)
%   n        number of grid subintervals (scalar) 
% Output:
%   x        grid points (vector, length n+1)
%   u        solution values at x (vector, length n+1)

% Define the grid.
h = (b-a)/n;
x = a + h*(0:n)';  

% Templates for the subinterval matrix and vector contributions.
Ke = [1 -1; -1 1];
Me = (1/6)*[2 1; 1 2];
fe = (1/2)*[1; 1];

% Evaluate coefficent functions and find average values.
cval = c(x);   cbar = (cval(1:n)+cval(2:n+1)) / 2;
sval = s(x);   sbar = (sval(1:n)+sval(2:n+1)) / 2;
fval = f(x);   fbar = (fval(1:n)+fval(2:n+1)) / 2;

% Assemble global system, one interval at a time.
K = zeros(n-1,n-1);  M = zeros(n-1,n-1);  f = zeros(n-1,1);
K(1,1) = cbar(1)/h;  M(1,1) = sbar(1)*h/3;  f(1) = fbar(1)*h/2;
K(n-1,n-1) = cbar(n)/h;  M(n-1,n-1) = sbar(n)*h/3;  f(n-1) = fbar(n)*h/2;
for k = 2:n-1
  K(k-1:k,k-1:k) = K(k-1:k,k-1:k) + (cbar(k)/h) * Ke;
  M(k-1:k,k-1:k) = M(k-1:k,k-1:k) + (sbar(k)*h) * Me;
  f(k-1:k) = f(k-1:k) + (fbar(k)*h) * fe;
end  

% Solve system for the interior values.
u = (K+M) \ f;
u = [0; u; 0];      % put the boundary values into the result
