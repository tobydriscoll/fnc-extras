"""
    hatfun(x,t,k)

Evaluate a piecewise linear "hat" function at `x`, where `t` is a vector of
n+1 interpolation nodes and `k` is an integer in 0:n giving the index of the node
where the hat function equals one.
"""

function hatfun(x,t,k)
    n = length(t)-1
    # Return correct node given mathematical index k, including fictitious choices.   
    function node(k)
        if k < 0
            2*t[1]-t[2]
        elseif k > n 
            2*t[n+1]-t[n] 
        else
            t[k+1]
        end
    end

    H1 = (x-node(k-1))/(node(k)-node(k-1))   # upward slope
    H2 = (node(k+1)-x)/(node(k+1)-node(k))   # downward slope

    H = min(H1,H2)
    return max(0,H)
end

"""
    plinterp(t,y)

Create a piecewise linear interpolating function for data values in `y` given at nodes
in `t`.
"""
function plinterp(t,y)
n = length(t)-1
return x -> sum( y[k+1]*hatfun(x,t,k) for k=0:n )
end

"""
    spinterp(t,y)

Create a cubic not-a-knot spline interpolating function for data values in `y` given at nodes
in `t`.
"""
function spinterp(t,y)

    n = length(t)-1
    h = diff(t)         # differences of all adjacent pairs

    # Preliminary definitions.
    Z = zeros(n,n);
    I = diagm(0=>ones(n));  E = I[1:n-1,:];
    J = diagm(0=>ones(n),1=>-ones(n-1))
    H = diagm(0=>h)

    # Left endpoint interpolation:
    AL = [ I Z Z Z ]
    vL = y[1:n]

    # Right endpoint interpolation:
    AR = [ I H H^2 H^3 ];
    vR = y[2:n+1]

    # Continuity of first derivative:
    A1 = E*[ Z J 2*H 3*H^2 ]
    v1 = zeros(n-1)

    # Continuity of second derivative:
    A2 = E*[ Z Z J 3*H ]
    v2 = zeros(n-1)

    # Not-a-knot conditions:
    nakL = [ zeros(1,3*n) [1 -1 zeros(1,n-2)] ]
    nakR = [ zeros(1,3*n) [zeros(1,n-2) 1 -1] ]

    # Assemble and solve the full system.
    A = [ AL; AR; A1; A2; nakL; nakR ]
    v = [ vL; vR; v1; v2; 0; 0 ]
    z = A\v

    # Break the coefficients into separate vectors.
    rows = 1:n
    a = z[rows]
    b = z[n.+rows];  c = z[2*n.+rows];  d = z[3*n.+rows]
    S = [ Poly([a[k],b[k],c[k],d[k]]) for k = 1:n ]
    # This function evaluates the spline when called with a value for x.
    function evaluate(x)
        k = findfirst(@. x<t)   # one more than interval x belongs to
        k==1 && return NaN
        if k==nothing
            return x==t[end] ? y[end] : NaN
        end
        return S[k-1](x-t[k-1])
    end
    return evaluate
end

"""
fdweights(t,m)

Return weights for the `m`th derivative of a function at zero using values at the
nodes in vector `t`.
"""
function fdweights(t,m)
    # This is a compact implementation, not an efficient one.

    function weight(t,m,r,k)
        # Recursion for one weight.
        # Input:
        #   t   nodes (vector)
        #   m   order of derivative sought
        #   r   number of nodes to use from t (<= length(t))
        #   k   index of node whose weight is found

        if (m<0) || (m>r)        # undefined coeffs must be zero
            c = 0
        elseif (m==0) && (r==0)  # base case of one-point interpolation
            c = 1
        else                     # generic recursion
            if k<r
                c = (t[r+1]*weight(t,m,r-1,k) -
                    m*weight(t,m-1,r-1,k))/(t[r+1]-t[k+1])
            else
                numer = r > 1 ? prod(t[r]-x for x in t[1:r-1]) : 1.0
                denom = r > 0 ? prod(t[r+1]-x for x in t[1:r]) : 1.0
                beta =  numer/denom
                c = beta*(m*weight(t,m-1,r-1,r-1) - t[r]*weight(t,m,r-1,r-1))
            end
        end
        return c
    end

    r = length(t)-1
    w = zeros(size(t))
    return [ weight(t,m,r,k) for k=0:r ]
end

"""
    trapezoid(f,a,b,n)

Apply the trapezoid integration formula for integrand `f` over interval [`a`,`b`],
broken up into `n` equal pieces. Returns estimate, vector of nodes, and vector of
integrand values at the nodes.
"""
function trapezoid(f,a,b,n)
    h = (b-a)/n
    t = a .+ h*(0:n)
    y = f.(t)
    T = h * ( sum(y[2:n]) + 0.5*(y[1] + y[n+1]) )

    return T,t,y
end

"""
    intadapt(f,a,b,tol)

Do adaptive integration to estimate the integral of `f` over [`a`,`b`] to desired
error tolerance `tol`. Returns estimate and a vector of evaluation nodes used.
"""
function intadapt(f,a,b,tol)
    # Use error estimation and recursive bisection.
    function do_integral(a,fa,b,fb,m,fm,tol)
        # These are the two new nodes and their f-values.
        xl = (a+m)/2;  fl = f(xl);
        xr = (m+b)/2;  fr = f(xr);
        t = [a,xl,m,xr,b]              # all 5 nodes at this level

        # Compute the trapezoid values iteratively.
        h = (b-a)
        T = [0.,0.,0.]
        T[1] = h*(fa+fb)/2
        T[2] = T[1]/2 + (h/2)*fm
        T[3] = T[2]/2 + (h/4)*(fl+fr)

        S = (4*T[2:3]-T[1:2]) / 3      # Simpson values
        E = (S[2]-S[1]) / 15           # error estimate

        if abs(E) < tol*(1+abs(S[2]))  # acceptable error?
            Q = S[2]                   # yes--done
        else
            # Error is too large--bisect and recurse.
            QL,tL = do_integral(a,fa,m,fm,xl,fl,tol)
            QR,tR = do_integral(m,fm,b,fb,xr,fr,tol)
            Q = QL + QR
            t = [tL;tR[2:end]]         # merge the nodes w/o duplicate
        end
        return Q,t
    end

    m = (b+a)/2
    Q,t = do_integral(a,f(a),b,f(b),m,f(m),tol)
    return Q,t
end
