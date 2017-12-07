function J = fdjac(f,x0,y0)
% FDJAC   Finite-difference approximation of a Jacobian.
% Input:
%   f        function to be differentiated
%   x0       evaluation point (n-vector)
%   y0       value of f at x0 (m-vector)
% Output       
%   J        approximate Jacobian (m-by-n)

delta = sqrt(eps);   % FD step size
m = length(y0);  n = length(x0);
J = zeros(m,n);
I = eye(n);
for j = 1:n
    J(:,j) = ( f(x0+delta*I(:,j)) - y0) / delta;
end

end
