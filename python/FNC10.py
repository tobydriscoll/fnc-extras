from scipy import *
from numpy import *
from matplotlib.pyplot import *
from scipy.linalg import *
from numpy.linalg import *
from scipy.optimize import root_scalar
from scipy.integrate import solve_ivp
from FNC04 import levenberg

def shoot(phi,xspan,lval,lder,rval,rder,init):
	"""
	shoot(phi,xspan,lval,lder,rval,rder,init)

	Use the shooting method to solve a two-point boundary value problem. The ODE is
	u'' = `phi`(x,u,u') for x in `xspan`. Specify a function value or derivative at
	the left endpoint using `lval` and `lder`, respectively, and similarly for the
	right endpoint  using `rval` and `rder`. (Use an empty array to denote an
	unknown quantity.) The value `init` is an initial guess for whichever value is
	missing at the left endpoint.

	Return vectors for the nodes, the values of u, and the values of u'.
	"""

	# Tolerances for IVP solver and rootfinder.
	ivp_opt = 1e-6
	optim_opt = 1e-5

	# Evaluate the difference between computed and target values at x=b.
	def objective(s):
		nonlocal x, v   # change these values in outer scope
		# Combine s with the known left endpoint value.
		if len(lder)==0:
			v_init = [ lval[0], s ]  
		else: 
			v_init = [ s, lder[0] ]

		# ODE posed as a first-order equation in 2 variables.
		def shootivp(x,v):
			return array([ v[1], phi(x,v[0],v[1]) ])

		x = linspace(xspan[0],xspan[1],400)  # make decent plots on return
		sol = solve_ivp(shootivp,xspan,v_init,t_eval=x)
		x = sol.t;  v = sol.y

		if len(rder)==0:
			return v[0,-1] - rval[0] 
		else:
			return v[1,-1] - rder[0]

	# Find the unknown quantity at x=a by rootfinding.
	x = [];  v = [];   # the values will be overwritten
	s = root_scalar(objective,x0=init,x1=init+0.05,xtol=optim_opt).root

	# Don't need to solve the IVP again. It was done within the
	# objective function already.
	u = v[0]            # solution
	dudx = v[1]         # derivative

	return x,u,dudx


def diffmat2(n,xspan):
	"""
	diffmat2(n,xspan)

	Compute 2nd-order-accurate differentiation matrices on `n`+1 points in the
	interval `xspan`. Return a vector of nodes, and the matrices for the first
	and second derivatives.
	"""
	a,b = xspan
	h = (b-a)/n
	x = linspace(a,b,n+1)   # nodes

	# Define most of Dx by its diagonals.
	dp = 0.5/h*ones(n)         # superdiagonal
	dm = -0.5/h*ones(n)        # subdiagonal
	Dx = diag(dm,-1) + diag(dp,1)

	# Fix first and last rows.
	Dx[0,:3] = array([-1.5,2,-0.5])/h
	Dx[-1,-3:] = array([0.5,-2,1.5])/h

	# Define most of Dxx by its diagonals.
	d0 =  -2/h**2*ones(n+1)    # main diagonal
	dp =  ones(n)/h**2         # superdiagonal and subdiagonal
	Dxx = diag(d0,0) + diag(dp,-1) + diag(dp,1)

	# Fix first and last rows.
	Dxx[0,:4] = array([2,-5,4,-1])/h**2
	Dxx[-1,-4:] = array([-1,4,-5,2])/h**2

	return x,Dx,Dxx

def diffcheb(n,xspan):
	"""
	diffcheb(n,xspan)

	Compute Chebyshev differentiation matrices on `n`+1 points in the
	interval `xspan`. Return a vector of nodes, and the matrices for the first
	and second derivatives.
	"""
	x = -cos( arange(n+1)*pi/n )   # nodes in [-1,1]
	Dx = zeros([n+1,n+1])
	c = hstack([2.,ones(n-1),2.])    # endpoint factors

	# Off-diagonal entries
	Dx = zeros([n+1,n+1])
	for i in range(n+1):
		for j in range(n+1):
			if i != j:
				Dx[i,j] = (-1)**(i+j) * c[i] / (c[j]*(x[i]-x[j])) 

	# Diagonal entries by the "negative sum trick"
	for i in range(n+1):
		Dx[i,i] = -sum( [Dx[i,j] for j in range(n+1) if j!=i] )    

	# Transplant to [a,b]
	a,b = xspan
	x = a + (b-a)*(x+1)/2
	Dx = 2*Dx/(b-a)

	# Second derivative
	Dxx = Dx @ Dx

	return x,Dx,Dxx

def bvplin(p,q,r,xspan,lval,rval,n):
	"""
		bvplin(p,q,r,xspan,lval,rval,n)

	Use finite differences to solve a linear bopundary value problem. The ODE is
	u''+`p`(x)u'+`q`(x)u = `r`(x) on the interval `xspan`, with endpoint function
	values given as `lval` and `rval`. There will be `n`+1 equally spaced nodes,
	including the endpoints.

	Return vectors of the nodes and the solution values.
	"""
	x,Dx,Dxx = diffmat2(n,xspan)

	P = diag(p(x))
	Q = diag(q(x))
	L = Dxx + P@Dx + Q     # ODE expressed at the nodes

	# Replace first and last rows using boundary conditions.
	I = eye(n+1)
	A = vstack([ I[0], L[1:-1], I[-1] ] )
	b = hstack([ lval, r(x[1:-1]), rval ])

	# Solve the system.
	u = solve(A,b)

	return x,u

def bvp(phi,xspan,lval,lder,rval,rder,init):
	"""
	bvp(phi,xspan,lval,lder,rval,rder,init)

	Use finite differences to solve a two-point boundary value problem. The ODE is
	u'' = `phi`(x,u,u') for x in `xspan`. Specify a function value or derivative at
	the left endpoint using `lval` and `lder`, respectively, and similarly for the
	right endpoint  using `rval` and `rder`. (Use an empty array to denote an
	unknown quantity.) The value `init` is an initial guess for whichever value is
	missing at the left endpoint.

	Return vectors for the nodes and the values of u.
	"""
	n = len(init) - 1
	x,Dx,Dxx = diffmat2(n,xspan)
	h = x[1]-x[0]

	def residual(u):
		# Compute the difference between u'' and phi(x,u,u') at the
		# interior nodes and appends the error at the boundaries.
		dudx = Dx@u                   # discrete u'
		d2udx2 = Dxx@u                # discrete u''
		f = d2udx2 - phi(x,u,dudx)

		# Replace first and last values by boundary conditions.
		if len(lder)==0:
			f[0] = (u[0] - lval[0])/h**2
		else:
			f[0] = (dudx[0] - lder[0])/h
		if len(rder)==0:
			f[-1] = (u[-1] - rval[0])/h**2
		else:
			f[-1] = (dudx[-1] - rder[0])/h
		return f

	u = levenberg(residual,init)
	return x,u[:,-1]

def fem(c,s,f,a,b,n):
	"""
	fem(c,s,f,a,b,n)

	Use a piecewise linear finite element method to solve a two-point boundary
	value problem. The ODE is (`c`(x)u')' + `s`(x)u = `f`(x) on the interval
	[`a`,`b`], and the boundary values are zero. The discretization uses `n` equal
	subintervals.

	Return vectors for the nodes and the values of u.
	"""
	# Define the grid.
	h = (b-a)/n
	x = linspace(a,b,n+1)

	# Templates for the subinterval matrix and vector contributions.
	Ke = array( [[1,-1], [-1,1]] )
	Me = (1/6)*array( [[2,1], [1,2]] )
	fe = (1/2)*array([1, 1])

	# Evaluate coefficent functions and find average values.
	cval = c(x);   cbar = (cval[:-1]+cval[1:]) / 2
	sval = s(x);   sbar = (sval[:-1]+sval[1:]) / 2
	fval = f(x);   fbar = (fval[:-1]+fval[1:]) / 2

	# Assemble global system, one interval at a time.
	K = zeros([n-1,n-1]);  M = zeros([n-1,n-1]);  f = zeros(n-1)
	K[0,0] = cbar[0]/h;  M[0,0] = sbar[0]*h/3;  f[0] = fbar[0]*h/2
	K[-1,-1] = cbar[-1]/h;  M[-1,-1] = sbar[-1]*h/3;  f[-1] = fbar[-1]*h/2
	for k in range(1,n-1):
		K[k-1:k+1,k-1:k+1] += (cbar[k]/h) * Ke
		M[k-1:k+1,k-1:k+1] += (sbar[k]*h) * Me
		f[k-1:k+1] += (fbar[k]*h) * fe

	# Solve system for the interior values.
	u = solve(K+M,f)
	u = hstack([0, u, 0])      # put the boundary values into the result

	return x,u
