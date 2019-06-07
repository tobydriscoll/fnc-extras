from scipy import *
from numpy import *
from scipy.linalg import *
from numpy.linalg import *

def diffper(n,xspan):
	"""
	diffper(n,xspan)

	Construct 2nd-order differentiation matrices for functions with periodic end
	conditions, using `n` unique nodes in the interval `xspan`. Return a vector of
	nodes and the  matrices for the first and second derivatives.
	"""
	a,b = xspan
	h = (b-a)/n
	x = a + h*arange(n)   # nodes, omitting the repeated data

	# Construct Dx by diagonals, then correct the corners.
	dp = 0.5/h*ones(n-1)        # superdiagonal
	dm = -0.5/h*ones(n-1)       # subdiagonal
	Dx = diag(dm,-1) + diag(dp,1)
	Dx[0,-1] = -1/(2*h)
	Dx[-1,0] = 1/(2*h)

	# Construct Dxx by diagonals, then correct the corners.
	d0 =  -2/h**2*ones(n)         # main diagonal
	dp =  ones(n-1)/h**2         # superdiagonal and subdiagonal
	Dxx = diag(d0) + diag(dp,-1) + diag(dp,1)
	Dxx[0,-1] = 1/(h**2)
	Dxx[-1,0] = 1/(h**2)

	return x,Dx,Dxx
