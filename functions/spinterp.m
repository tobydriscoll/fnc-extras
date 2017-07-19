function S = spinterp(t,y)
% SPINTERP   Cubic not-a-knot spline interpolation.
% Input:
%   t     interpolation nodes (vector, length n+1)
%   y     interpolation values (vector, length n+1)
% Output:
%   S     not-a-knot cubic spline (function)

t = t(:);  y = y(:);  % ensure column vectors
n = length(t)-1;
h = diff(t);          % differences of all adjacent pairs

% Preliminary definitions.
Z = zeros(n);
I = eye(n);  E = I(1:n-1,:);
J = I - diag(ones(n-1,1),1);
H = diag(h);

% Left endpoint interpolation:
AL = [ I, Z, Z, Z ];
vL = y(1:n);

% Right endpoint interpolation:
AR = [ I, H, H^2, H^3 ];
vR = y(2:n+1);

% Continuity of first derivative:
A1 = E*[ Z, J, 2*H, 3*H^2 ];
v1 = zeros(n-1,1);

% Continuity of second derivative:
A2 = E*[ Z, Z, J, 3*H ];
v2 = zeros(n-1,1);

% Not-a-knot conditions:
nakL = [ zeros(1,3*n), [1,-1, zeros(1,n-2)] ];
nakR = [ zeros(1,3*n), [zeros(1,n-2), 1,-1] ];

% Assemble and solve the full system.
A = [ AL; AR; A1; A2; nakL; nakR ];
v = [ vL; vR; v1; v2; 0 ;0 ];
z = A\v;

% Break the coefficients into separate vectors.
rows = 1:n;
a = z(rows);
b = z(n+rows);  c = z(2*n+rows);  d = z(3*n+rows);
S = @evaulate;

    % This function evaluates the spline when called with a value for x.
    function f = evaulate(x)
        f = zeros(size(x));
        for k = 1:n       % iterate over the pieces
            % Evalaute this piece's cubic at the points inside it.
            index = (x>=t(k)) & (x<=t(k+1));   
            f(index) = polyval( [d(k),c(k),b(k),a(k)], x(index)-t(k) );
        end
    end

end