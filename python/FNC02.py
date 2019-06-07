from scipy import *

def forwardsub(L,b):
	"""
 	forwardsub(L,b)

	Solve the lower-triangular linear system with matrix L and right-hand side
	vector b.
	"""
	n = len(b)
	x = zeros(n)
	for i in range(n):
		s = L[i,:i] @ x[:i]
		x[i] = ( b[i] - s ) / L[i,i]
	return x


def backsub(U,b):
	"""
	backsub(U,b)

	Solve the upper-triangular linear system with matrix U and right-hand side
	vector b.
	"""
	n = len(b)
	x = zeros(n)
	for i in range(n-1,-1,-1):
		s = U[i,i+1:] @ x[i+1:]
		x[i] = ( b[i] - s ) / U[i,i]
	return x

def lufact(A):
	"""
	lufact(A)

	Compute the LU factorization of square matrix A, returning the factors.
	"""
	n = A.shape[0]
	L = eye(n)      # puts ones on diagonal
	U = copy(A)

	# Gaussian elimination
	for j in range(n-1):
		for i in range(j+1,n):
			L[i,j] = U[i,j] / U[j,j]   # row multiplier
			U[i,j:] = U[i,j:] - L[i,j]*U[j,j:]
	return L,triu(U)
