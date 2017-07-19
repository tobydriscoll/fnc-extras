function [x,Dx,Dxx] = diffcheb(n,xspan)
%DIFFCHEB   Chebyshev differentiation matrices.
% Input:
%   n      number of subintervals (integer)
%   xspan  interval endpoints (vector)
% Output:
%   x      Chebyshev nodes in domain (length n+1)
%   Dx     matrix for first derivative (n+1 by n+1)
%   Dxx    matrix for second derivative (n+1 by n+1)

x = -cos( (0:n)'*pi/n );    % nodes in [-1,1]
Dx = zeros(n+1);
c = [2; ones(n-1,1); 2];    % endpoint factors
i = (0:n)';                 % row indices

% Off-diagonal entries
for j = 0:n
  num = c(i+1).*(-1).^(i+j);
  den = c(j+1)*(x-x(j+1));
  Dx(:,j+1) = num./den;
end

% Diagonal entries
Dx(isinf(Dx)) = 0;          % fix divisions by zero on diagonal
Dx = Dx - diag(sum(Dx,2));  % "negative sum trick" 
  
% Transplant to [a,b]
a = xspan(1);  b = xspan(2);
x = a + (b-a)*(x+1)/2;
Dx = 2*Dx/(b-a);

% Second derivative
Dxx = Dx^2;

end
    