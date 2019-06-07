from scipy import *
from numpy import *
from scipy.linalg import *
from numpy.linalg import *

def hatfun(x,t,k):
	"""
    hatfun(x,t,k)

	Evaluate a piecewise linear "hat" function at `x`, where `t` is a vector of
	n+1 interpolation nodes and `k` is an integer in 0:n giving the index of the node
	where the hat function equals one.
	"""

	n = len(t)-1
    # Return correct node given mathematical index k, including fictitious choices.   
	def node(k):
		if k < 0:
			return 2*t[0]-t[1]
		elif k > n: 
			return 2*t[n]-t[n-1] 
		else:
			return t[k]

	H1 = (x-node(k-1)) / (node(k)-node(k-1))   # upward slope
	H2 = (node(k+1)-x) / (node(k+1)-node(k))   # downward slope
	H = minimum(H1,H2)
	return maximum(0,H)

def plinterp(t,y):
	"""
	plinterp(t,y)

	Create a piecewise linear interpolating function for data values in `y` given at nodes
	in `t`.
	"""

	n = len(t)-1
	return lambda x: sum( y[k]*hatfun(x,t,k) for k in range(n+1) )



def spinterp(t,y):
	"""
	spinterp(t,y)

	Create a cubic not-a-knot spline interpolating function for data values in `y` given at nodes in `t`.
	"""
	n = len(t) - 1
	h = [t[i+1]-t[i] for i in range(n)]    

	# Preliminary definitions.
	Z = zeros([n,n])
	I = eye(n);  E = I[:n-1,:]
	J = eye(n) + diag(-ones(n-1),1)
	H = diag(h)

	# Left endpoint interpolation:
	AL = hstack([I,Z,Z,Z])
	vL = y[:-1]

	# Right endpoint interpolation:
	AR = hstack([I,H,H**2,H**3])
	vR = y[1:]

	# Continuity of first derivative:
	A1 = E @ hstack([Z,J,2*H,3*H**2])
	v1 = zeros(n-1)

	# Continuity of second derivative:
	A2 = E @ hstack([Z,Z,J,3*H])
	v2 = zeros(n-1)

	# Not-a-knot conditions:
	nakL = hstack([ zeros(3*n), hstack([1,-1,zeros(n-2)]) ])
	nakR = hstack([ zeros(3*n), hstack([zeros(n-2),1,-1]) ])

    # Assemble and solve the full system.
	A = vstack( [ AL, AR, A1, A2, nakL, nakR ] )
	v = hstack( [ vL, vR, v1, v2, 0, 0 ] )
	z = solve(A,v)

	# Break the coefficients into separate vectors.
	rows = arange(n)
	a = z[rows]
	b = z[n+rows];  c = z[2*n+rows];  d = z[3*n+rows]
	S = [ poly1d([d[k],c[k],b[k],a[k]]) for k in range(n) ]
	
	# This function evaluates the spline when called with a value for x.
	def evaluate(x):
		f = zeros(x.shape)
		for k in range(n): 
			# Evaluate this piece's cubic at the points inside it.
			index = (x>=t[k]) & (x<=t[k+1])
			f[index] = S[k](x[index]-t[k])
		return f

	return evaluate

def fdweights(t,m):
	"""
	fdweights(t,m)

	Return weights for the `m`th derivative of a function at zero using values at the
	nodes in vector `t`.
	"""
    # This is a compact implementation, not an efficient one.

	def weight(t,m,r,k):
		# Recursion for one weight.
		# Input:
		#   t   nodes (vector)
		#   m   order of derivative sought
		#   r   number of nodes to use from t (<= length(t))
		#   k   index of node whose weight is found

		if (m<0) or (m>r):        # undefined coeffs must be zero
			c = 0
		elif (m==0) and (r==0):  # base case of one-point interpolation
			c = 1
		else:                     # generic recursion
			if k<r:
				c = (t[r]*weight(t,m,r-1,k) -
					m*weight(t,m-1,r-1,k))/(t[r]-t[k])
			else:
				if r <= 1:
					numer = 1.0
				else:
					numer = prod(t[r-1]-t[:r-1])
				if r <= 0: 
					denom = 1.0
				else:
					denom = prod(t[r]-t[:r]) 
				beta =  numer/denom
				c = beta*(m*weight(t,m-1,r-1,r-1) - t[r-1]*weight(t,m,r-1,r-1))
		return c

	r = len(t)-1
	w = zeros(t.shape)
	return [ weight(t,m,r,k) for k in range(r+1) ] 
	#return weight(t,m,r,0)

def trapezoid(f,a,b,n):
	"""
	trapezoid(f,a,b,n)

	Apply the trapezoid integration formula for integrand `f` over interval [`a`,`b`], broken up into `n` equal pieces. Returns estimate, vector of nodes, and vector of integrand values at the nodes.
	"""
	h = (b-a)/n
	t = linspace(a,b,n+1)
	y = f(t)
	T = h * ( sum(y[1:-1]) + 0.5*(y[0] + y[-1]) )

	return T,t,y

def intadapt(f,a,b,tol):
	"""
	intadapt(f,a,b,tol)

	Do adaptive integration to estimate the integral of `f` over [`a`,`b`] to desired
	error tolerance `tol`. Returns estimate and a vector of evaluation nodes used.
	"""
    # Use error estimation and recursive bisection.
	def do_integral(a,fa,b,fb,m,fm,tol):
		# These are the two new nodes and their f-values.
		xl = (a+m)/2;  fl = f(xl)
		xr = (m+b)/2;  fr = f(xr)
		t = array([a,xl,m,xr,b])             # all 5 nodes at this level

		# Compute the trapezoid values iteratively.
		h = (b-a)
		T = array([0.,0.,0.])
		T[0] = h*(fa+fb)/2
		T[1] = T[0]/2 + (h/2)*fm
		T[2] = T[1]/2 + (h/4)*(fl+fr)

		S = (4*T[1:]-T[:-1]) / 3      # Simpson values
		E = (S[1]-S[0]) / 15           # error estimate

		if abs(E) < tol*(1+abs(S[1])):  # acceptable error?
			Q = S[1]                    # yes--done
		else:
			# Error is too large--bisect and recurse.
			QL,tL = do_integral(a,fa,m,fm,xl,fl,tol)
			QR,tR = do_integral(m,fm,b,fb,xr,fr,tol)
			Q = QL + QR
			t = hstack([tL,tR[1:]])    # merge the nodes w/o duplicate
		return Q,t

	m = (b+a)/2
	Q,t = do_integral(a,f(a),b,f(b),m,f(m),tol)
	return Q,t
