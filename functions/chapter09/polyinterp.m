function p = polyinterp(t,y)
% POLYINTERP Global polynomial interpolant using barycentric formulas.
% Input:
%   t   interpolation nodes (vector, length n+1)
%   y   interpolation values (vector, length n+1)
% Output:
%   p   function that evaluates the interpolant (function)

t = t(:);                    % column vector
n = length(t)-1;

% Compute barycentric weights.
C = (t(end)-t(1)) / 4;       % scaling factor to ensure stability
tc = t/C;

% Adding one node at a time, compute inverses of the weights.
w = ones(n+1,1);
for m = 1:n
    d = (tc(1:m) - tc(m+1));   % a vector of node differences
    w(1:m) = w(1:m) .* d;      % update previous inv. weights
    w(m+1) = prod( -d );       % compute the new one
end
w = 1./w;                    % go from inverses to weights

p = @evaluate;

    function f = evaluate(x)
        % % Compute interpolant, one value of x at a time.
        f = zeros(size(x));
        for j = 1:numel(x)
            terms = w ./ (x(j) - t );
            f(j) = sum(y.*terms) / sum(terms);
        end
        
        % Apply L'Hopital's Rule exactly.
        for j = find( isnan(f(:)) )'      % divided by zero here
            [~,idx] = min( abs(x(j)-t) );   % node closest to x(j)
            f(j) = y(idx);                  % value at node
        end        
    end

end
