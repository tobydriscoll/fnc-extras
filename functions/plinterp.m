function p = plinterp(t,y)
% PLINTERP   Piecewise linear interpolation.
% Input:
%   t     interpolation nodes (vector, length n+1)
%   y     interpolation values (vector, length n+1)
% Output:
%   p     piecewise linear interpolant (function)

n = length(t)-1;
p = @evaluate;

    % This function evaluates p when called.
    function f = evaluate(x)
        f = 0;
        for k = 0:n
            f = f + y(k+1)*hatfun(x,t,k);
        end
    end

end