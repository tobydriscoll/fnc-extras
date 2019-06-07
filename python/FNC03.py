from scipy import *
from scipy.linalg import qr

def lsnormal(A,b):
	"""
    lsnormal(A,b)

	Solve a linear least squares problem by the normal equations. Returns the
	minimizer of ||b-Ax||.
	"""

	N = A.T@A
	z = A.T@b
	R = cholesky(N)
	w = forwardsub(R.T,z)                   # solve R'z=c
	x = backsub(R,w)                        # solve Rx=z

	return x

def lsqrfact(A,b):
	"""
	lsqrfact(A,b)

	Solve a linear least squares problem by QR factorization. Returns the
	minimizer of ||b-Ax||.
	"""

	Q,R = qr(A)
	c = Q.T@b
	x = backsub(R,c)

	return x
