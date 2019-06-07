from scipy import *
from scipy.linalg import norm,lstsq
from numpy import finfo
eps = finfo(double).eps 
import warnings

def newton(f,dfdx,x1):
	"""
	newton(f,dfdx,x1)

	Use Newton's method to find a root of `f` starting from `x1`, where `dfdx` is the
	derivative of `f`. Returns a vector of root estimates.
	"""
	# Operating parameters.
	funtol = 100*eps
	xtol = 100*eps  
	maxiter = 40

	x = zeros(maxiter)
	x[0] = x1
	y = f(x1)
	dx = Inf   # for initial pass below
	k = 0

	while (abs(dx) > xtol) and (abs(y) > funtol) and (k < maxiter):
		dydx = dfdx(x[k])
		dx = -y/dydx            # Newton step
		x[k+1] = x[k]+dx        # new estimate

		k = k+1
		y = f(x[k])

	if k==maxiter:
		warnings.warn("Maximum number of iterations reached.")

	return x[:k+1]

def secant(f,x1,x2):
	"""
	secant(f,x1,x2)

	Use the secant method to find a root of `f` starting from `x1` and `x2`. Returns a
	vector of root estimates.
	"""
    # Operating parameters.
	funtol = 100*eps
	xtol = 100*eps  
	maxiter = 40

	x = zeros(maxiter)
	x[:2] = [x1,x2]
	y1 = f(x1)
	y2 = 100
	dx = Inf   # for initial pass below
	k = 1

	while (abs(dx) > xtol) and (abs(y2) > funtol) and (k < maxiter):
		y2 = f(x[k])
		dx = -y2 * (x[k]-x[k-1]) / (y2-y1)   # secant step
		x[k+1] = x[k]+dx        # new estimate

		k = k+1
		y1 = y2    # current f-value becomes the old one next time

	if k==maxiter:		
		warnings.warn("Maximum number of iterations reached.")

	return x[:k+1]

def newtonsys(f,x1):
	"""
		newtonsys(f,x1)

	Use Newton's method to find a root of a system of equations, starting from `x1`. The
	function `f` should return both the residual vector and the Jacobian matrix. Returns
	root estimates as a matrix, one estimate per column.
	"""
	# Operating parameters.
	funtol = 1000*eps
	xtol = 1000*eps
	maxiter = 40

	x = zeros((len(x1),maxiter))
	x[:,0] = x1
	y,J = f(x1)
	dx = 10.   # for initial pass below
	k = 0

	while (norm(dx) > xtol) and (norm(y) > funtol) and (k < maxiter):
		dx = -lstsq(J,y)[0]            # Newton step
		x[:,k+1] = x[:,k] + dx

		k = k+1
		y,J = f(x[:,k])

	if k==maxiter:
		warnings.warn("Maximum number of iterations reached.")

	return x[:,:k+1]

def fdjac(f,x0,y0):
	"""
	fdjac(f,x0,y0)

	Compute a finite-difference approximation of the Jacobian matrix for `f` at `x0`,
	where `y0`=`f(x0)` is given.
	"""

	delta = sqrt(eps)   # FD step size
	m,n = (len(y0),len(x0))
	J = zeros((m,n))
	I = eye(n)
	for j in range(n):
		J[:,j] = ( f(x0 + delta*I[:,j]) - y0) / delta

	return J

def levenberg(f,x1,tol=1e-12):
	"""
	levenberg(f,x1,tol)

	Use Levenberg's quasi-Newton iteration to find a root of the system `f`, starting from
	`x1`, with `tol` as the stopping tolerance in both step size and residual norm. Returns
	root estimates as a matrix, one estimate per column.
	"""

	# Operating parameters.
	ftol = tol
	xtol = tol
	maxiter = 40

	n = len(x1)
	x = zeros((n,maxiter))
	x[:,0] = x1
	fk = f(x1)
	k = 0
	s = 10.
	Ak = fdjac(f,x[:,0],fk)   # start with FD Jacobian
	jac_is_new = True

	lam = 10
	while (norm(s) > xtol) and (norm(fk) > ftol) and (k < maxiter):
		# Compute the proposed step.
		B = Ak.T@Ak + lam*eye(n)
		z = Ak.T@fk
		s = -lstsq(B,z)[0]

		xnew = x[:,k] + s;   
		fnew = f(xnew)

		# Do we accept the result?
		if norm(fnew) < norm(fk):    # accept
			y = fnew - fk
			x[:,k+1] = xnew
			fk = fnew
			k = k+1

			lam = lam/10   # get closer to Newton
			# Broyden update of the Jacobian.
			Ak = Ak + outer( y-Ak@s, s/dot(s,s) )
			jac_is_new = False
		else:                       # don't accept
			# Get closer to steepest descent.
			lam = lam*4
			# Re-initialize the Jacobian if it's out of date.
			if not jac_is_new:
				Ak = fdjac(f,x[:,k],fk)
				jac_is_new = True

	if (norm(fk) > 1e-3):
		warnings.warn("Iteration did not find a root.")

	return x[:,:k+1]
