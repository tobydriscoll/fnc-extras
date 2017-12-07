function p = polyinterp(t,y)
% POLYINTERP Polynomial interpolation by the barycentric formula.
% Input:
%   t   interpolation nodes (vector, length n+1)
%   y   interpolation values (vector, length n+1)
% Output:
%   p   polynomial interpolant (function)

t = t(:);                    % column vector
n = length(t)-1;
C = (t(end)-t(1)) / 4;       % scaling factor to ensure stability
tc = t/C;

% Adding one node at a time, compute inverses of the weights.
omega = ones(n+1,1);
for m = 1:n
    d = (tc(1:m) - tc(m+1));    % vector of node differences
    omega(1:m) = omega(1:m).*d; % update previous 
    omega(m+1) = prod( -d );    % compute the new one
end
w = 1./omega;                   % go from inverses to weights

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
