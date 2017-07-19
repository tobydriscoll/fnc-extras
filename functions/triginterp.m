function p = triginterp(t,y)
% TRIGINTERP Trigonometric interpolation.
% Input:
%   t   equispaced interpolation nodes (vector, length N)
%   y   interpolation values (vector, length N)
% Output:
%   p   trigonometric interpolant (function)

N = length(t);
p = @value;

    function f = value(x)
        f = zeros(size(x));
        for k = 1:N
            f = f + y(k)*trigcardinal(x-t(k));
        end
    end
        
    function tau = trigcardinal(x)
        if rem(N,2)==1   % odd
            tau = sin(N*pi*x/2) ./ (N*sin(pi*x/2));
        else             % even
            tau = sin(N*pi*x/2) ./ (N*tan(pi*x/2));
        end
        tau(isnan(tau)) = 1;
    end
        
end