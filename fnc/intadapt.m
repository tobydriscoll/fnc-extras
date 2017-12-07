function [Q,t] = intadapt(f,a,b,tol)
%INTADAPT   Adaptive integration with error estimation.
% Input:
%   f     integrand (function)
%   a,b   interval of integration (scalars)
%   tol   acceptable error
% Output:
%   Q     approximation to integral(f,a,b)
%   t     vector of nodes used

m = (b+a)/2;
[Q,t] = do_integral(a,f(a),b,f(b),m,f(m),tol);

    % Use error estimation and recursive bisection. 
    function [Q,t] = do_integral(a,fa,b,fb,m,fm,tol)
        
        % These are the two new nodes and their f-values.
        xl = (a+m)/2;  fl = f(xl);
        xr = (m+b)/2;  fr = f(xr);
        t = [a;xl;m;xr;b];              % all 5 nodes at this level

        % Compute the trapezoid values iteratively. 
        h = (b-a);
        T(1) = h*(fa+fb)/2;
        T(2) = T(1)/2 + (h/2)*fm;
        T(3) = T(2)/2 + (h/4)*(fl+fr);
        
        S = (4*T(2:3)-T(1:2)) / 3;      % Simpson values
        E = (S(2)-S(1)) / 15;           % error estimate
                
        if abs(E) < tol*(1+abs(S(2)))   % acceptable error?
            Q = S(2);                   % yes--done
        else
            % Error is too large--bisect and recurse. 
            [QL,tL] = do_integral(a,fa,m,fm,xl,fl,tol);
            [QR,tR] = do_integral(m,fm,b,fb,xr,fr,tol);
            Q = QL + QR;
            t = [tL;tR(2:end)];         % merge the nodes w/o duplicate
        end        
    end

end

