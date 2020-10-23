from scipy import *
from numpy import *
from matplotlib.pyplot import *
from scipy.linalg import *
from numpy.linalg import *

def polyinterp(t,y):
    """
    polyinterp(t,y)

    Return a callable polynomial interpolant through the points in vectors `t`,`y`. Uses
    the barycentric interpolation formula.
    """
    n = len(t)-1
    C = (t[-1]-t[0]) / 4       # scaling factor to ensure stability
    tc = t/C

    # Adding one node at a time, compute inverses of the weights.
    omega = ones(n+1)
    for m in range(n):
        d = tc[:m+1] - tc[m+1]          # vector of node differences
        omega[:m+1] = omega[:m+1]*d     # update previous
        omega[m+1] = prod( -d )         # compute the new one
    w = 1 / omega                   # go from inverses to weights

    def p(x):
        # Compute interpolant.
        z = where(x==t)[0]
        if len(z)>0:       # avoid dividing by zero
            # Apply L'Hopital's Rule exactly.
             f = y[z[0]]
        else:
            terms = w / (x - t)
            f = sum(y*terms) / sum(terms)
        return f
        
    return vectorize(p)

def triginterp(t,y):
    """
        triginterp(t,y)

    Return trigonometric interpolant for points defined by vectors `t` and `y`.
    """
    N = len(t)

    def trigcardinal(x):
        if x==0:
            tau = 1.
        elif mod(N,2)==1:      # odd
            tau = sin(N*pi*x/2) / (N*sin(pi*x/2))
        else:                # even
            tau = sin(N*pi*x/2) / (N*tan(pi*x/2))
        return tau

    def p(x):
        return sum( [y[k]*trigcardinal(x-t[k]) for k in range(N)] )
        
    return vectorize(p)

def ccint(f,n):
    """
    ccint(f,n)

    Perform Clenshaw-Curtis integration for the function `f` on `n`+1 nodes in [-1,1]. Return
    integral and a vector of the nodes used. Note: `n` must be even.
    """
    # Find Chebyshev extreme nodes.
    theta = linspace(0,pi,n+1)
    x = -cos(theta)

    # Compute the C-C weights.
    c = zeros(n+1)
    c[[0,n]] = 1/(n**2-1)
    v = ones(n-1)
    for k in range(1,int(n/2)):
        v -= 2*cos(2*k*theta[1:-1])/(4*k**2-1)
    v -= cos(n*theta[1:-1])/(n**2-1)
    c[1:-1] = 2*v/n

    # Evaluate integrand and integral.
    I = dot(c,f(x))   # use vector inner product
    return I,x

def glint(f,n):
    """
    glint(f,n)

    Perform Gauss-Legendre integration for the function `f` on `n` nodes in (-1,1). Return
    integral and a vector of the nodes used.
    """
    # Nodes and weights are found via a tridiagonal eigenvalue problem.
    beta = 0.5/sqrt(1-(2.0*arange(1,n))**(-2))
    T = diag(beta,1) + diag(beta,-1)
    ev,V = eig(T)
    ev = real_if_close(ev)
    p = argsort(ev)
    x = ev[p]               # nodes
    c = 2*V[0,p]**2         # weights

    # Evaluate the integrand and compute the integral.
    I = dot(c,f(x))         # vector inner product
    return I,x

def intde(f,h,M):
    """
    intde(f,h,M)

    Perform doubly-exponential integration of function `f` over (-Inf,Inf), using
    discretization size `h` and truncation point `M`. Return integral and a vector of the
    nodes used.
    """
    # Find where to truncate the trapezoid sum.
    K = ceil( log(4/pi*log(2*M))/h )

    # Integrate by trapezoids in a transformed variable t.
    t = h*arange(-K,K+1)
    x = sinh(pi/2*sinh(t))
    dxdt = pi/2*cosh(t)*cosh(pi/2*sinh(t))

    I = h*dot(f(x),dxdt)
    return I,x

def intsing(f,h,delta):
    """
    intsing(f,h,delta)

    Integrate function `f` (possibly singular at 1 and -1) over [-1+`delta`,1-`delta`]
    using discretization size `h`. Return integral and a vector of the
    nodes used.
    """
    # Find where to truncate the trapezoid sum.
    K = ceil(log(-2/pi*log(delta/2))/h)

    # Integrate over a transformed variable.
    t = h*arange(-K,K+1)
    x = tanh(pi/2*sinh(t))
    dxdt = pi/2*cosh(t) / (cosh(pi/2*sinh(t))**2)

    I = h*dot(f(x),dxdt)
    return I,x
