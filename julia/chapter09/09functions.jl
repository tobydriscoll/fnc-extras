"""
    polyinterp(t,y)

Return a callable polynomial interpolant through the points in vectors `t`,`y`. Uses
the barycentric interpolation formula.
"""
function polyinterp(t,y)
    n = length(t)-1
    C = (t[end]-t[1]) / 4       # scaling factor to ensure stability
    tc = t/C

    # Adding one node at a time, compute inverses of the weights.
    omega = ones(n+1)
    for m = 1:n
        d = tc[1:m] .- tc[m+1]      # vector of node differences
        omega[1:m] = omega[1:m].*d  # update previous
        omega[m+1] = prod( -d )     # compute the new one
    end
    w = 1 ./ omega                  # go from inverses to weights

    p = function (x)
        # Compute interpolant.
        terms = @. w / (x - t)
        if any(isinf.(terms))       # divided by zero here
            # Apply L'Hopital's Rule exactly.
            idx = findfirst(x.==t)
            f = y[idx]
        else
            f = sum(y.*terms) / sum(terms)
        end
    end
    return p
end

"""
    triginterp(t,y)

Return trigonometric interpolant for points defined by vectors `t` and `y`.
"""
function triginterp(t,y)
    N = length(t)

    function trigcardinal(x)
        if isodd(N)      # odd
            tau = sin(N*pi*x/2) / (N*sin(pi*x/2))
        else             # even
            tau = sin(N*pi*x/2) / (N*tan(pi*x/2))
        end
        if isnan(tau)
            tau = 1
        end
        return tau
    end

    p = function (x)
        sum( y[k]*trigcardinal(x-t[k]) for k=1:N )
    end
    return p
end

"""
    ccint(f,n)

Perform Clenshaw-Curtis integration for the function `f` on `n`+1 nodes in [-1,1]. Return
integral and a vector of the nodes used. Note: `n` must be even.
"""
function ccint(f,n)
    # Find Chebyshev extreme nodes.
    theta = [ i*pi/n for i=0:n ]
    x = -cos.(theta)

    # Compute the C-C weights.
    c = zeros(n+1)
    c[[1,n+1]] .= 1/(n^2-1)
    v = 1 .- 2*sum( cos.(2*k*theta[2:n])/(4*k^2-1) for k=1:n/2-1 )
    v -= cos.(n*theta[2:n])/(n^2-1)
    c[2:n] = 2*v/n

    # Evaluate integrand and integral.
    I = dot(c,f.(x))   # use vector inner product
    return I,x
end

"""
    glint(f,n)

Perform Gauss-Legendre integration for the function `f` on `n` nodes in (-1,1). Return
integral and a vector of the nodes used.
"""
function glint(f,n)
    # Nodes and weights are found via a tridiagonal eigenvalue problem.
    beta = @. 0.5/sqrt(1-(2*(1:n-1))^(-2))
    T = diagm(-1=>beta,1=>beta)
    lambda,V = eigen(T)
    p = sortperm(lambda)
    x = lambda[p]           # nodes
    c = @. 2*V[1,p]^2       # weights

    # Evaluate the integrand and compute the integral.
    I = dot(c,f.(x))      # vector inner product
    return I,x
end

"""
    intde(f,h,M)

Perform doubly-exponential integration of function `f` over (-Inf,Inf), using
discretization size `h` and truncation point `M`. Return integral and a vector of the
nodes used.
"""
function intde(f,h,M)
    # Find where to truncate the trapezoid sum.
    K = ceil( log(4/pi*log(2*M))/h )

    # Integrate by trapezoids in a transformed variable t.
    t = h*(-K:K)
    x = @. sinh(pi/2*sinh(t))
    dxdt = @. pi/2*cosh(t)*cosh(pi/2*sinh(t))

    I = h*dot(f.(x),dxdt)
    return I,x
end

"""
    intsing(f,h,delta)

Integrate function `f` (possibly singular at 1 and -1) over [-1+`delta`,1-`delta`]
using discretization size `h`. Return integral and a vector of the
nodes used.
"""
function intsing(f,h,delta)
    # Find where to truncate the trapezoid sum.
    K = ceil(log(-2/pi*log(delta/2))/h)

    # Integrate over a transformed variable.
    t = h*(-K:K)
    x = @. tanh(pi/2*sinh(t))
    dxdt = @. pi/2*cosh(t) / (cosh(pi/2*sinh(t))^2)

    I = h*dot(f.(x),dxdt)
    return I,x
end
