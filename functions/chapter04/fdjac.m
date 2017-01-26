function J = fdjac(f,x0,f0)
% FDJAC  Finite-difference approximation of a Jacobian.
% Input:
%   f        function to be differentiated
%   x0       evaluation point (n-vector)
%   f0       value of f at x0 (m-vector)
% Output       
%   J        approximate Jacobian (m-by-n)

delta = sqrt(eps);   % FD step size
m = length(f0);  n = length(x0);
J = zeros(m,n);
I = eye(n);
for j = 1:n
    J(:,j) = ( f(x0+delta*I(:,j)) - f0) / delta;
end

end
