from scipy import *
from numpy import *
from scipy.linalg import *
from numpy.linalg import *
from scipy.sparse import csc_matrix,diags

def poweriter(A,numiter):
	"""
	poweriter(A,numiter)

	Perform `numiter` power iterations with the matrix `A`, starting from a random vector,	and return a vector of eigenvalue estimates and the final eigenvector approximation.
	"""
	n = A.shape[0]
	x = randn(n)
	x = x/norm(x,Inf)
	gamma = zeros(numiter)
	for k in range(numiter):
		y = A@x
		m = argmax(abs(y))
		gamma[k] = y[m]/x[m]
		x = y/y[m]

	return gamma,x

def inviter(A,s,numiter):
	"""
	inviter(A,s,numiter)

	Perform `numiter` inverse iterations with the matrix `A` and shift `s`, starting
	from a random vector, and return a vector of eigenvalue estimates and the final
	eigenvector approximation.
	"""
	n = A.shape[0]
	x = randn(n)
	x = x/norm(x,Inf)
	gamma = zeros(numiter)
	PL,U = lu(A - s*eye(n),permute_l=True)
	for k in range(numiter):
		y = solve(U,solve(PL,x))
		m = argmax(abs(y))
		gamma[k] = x[m]/y[m] + s
		x = y/y[m]

	return gamma,x

def arnoldi(A,u,m):
	"""
	arnoldi(A,u,m)

	Perform the Arnoldi iteration for `A` starting with vector `u`, out to the Krylov
	subspace of degree `m`. Return the orthonormal basis (`m`+1 columns) and the upper
	Hessenberg `H` of size `m`+1 by `m`.
	"""
	n = u.size
	Q = zeros([n,m+1])
	H = zeros([m+1,m])
	Q[:,0] = u/norm(u)
	for j in range(m):
		# Find the new direction that extends the Krylov subspace.
		v = A@Q[:,j]
		# Remove the projections onto the previous vectors.
		for i in range(j+1):
			H[i,j] = Q[:,i]@v
			v -= H[i,j]*Q[:,i]
		# Normalize and store the new basis vector.
		H[j+1,j] = norm(v)
		Q[:,j+1] = v/H[j+1,j]

	return Q,H

def arngmres(A,b,m):
	"""
	arngmres(A,b,m)

	Do `m` iterations of GMRES for the linear system `A`*x=`b`. Return the final solution
	estimate x and a vector with the history of residual norms. (This function is for
	demo only, not practical use.)
	"""
	n = len(b)
	Q = zeros([n,m+1])
	Q[:,0] = b/norm(b)
	H = zeros([m+1,m])

	# Initial "solution" is zero.
	residual = hstack([norm(b),zeros(m)])

	for j in range(m):
		# Next step of Arnoldi iteration.
		v = A@Q[:,j]
		for i in range(j+1):
			H[i,j] = Q[:,i]@v
			v -= H[i,j]*Q[:,i]
		H[j+1,j] = norm(v)
		Q[:,j+1] = v/H[j+1,j]

		# Solve the minimum residual problem.
		r = hstack([norm(b), zeros(j+1)])
		z = lstsq(H[:j+2,:j+1],r)[0]
		x = Q[:,:j+1]@z
		residual[j+1] = norm( A@x - b )

	return x,residual

def sprandsym(n,density,**kwargs):
	if "rcond" in kwargs:
		ev = array([ kwargs["rcond"]**(i/(n-1)) for i in range(n) ])
	elif "eigvals" in kwargs:
		ev = kwargs["eigvals"]
	else:
		ev = sqrt(n)*randn(n)

	def randjr(A):
		# Random Jacobi rotation similarity transformation.
		theta = 2*pi*rand()
		c = cos(theta); s = sin(theta)
		idx = [int(k) for k in floor(n*rand(2)) ]
		R = array([[c,s],[-s,c]])
		A[idx,:] = R @ A[idx,:]
		A[:,idx] = A[:,idx] @ R.T
		return A

	targetnz = ceil(min(0.98,density)*n*n)
	A = diags(ev,0,format="lil")
	while A.nnz < targetnz:
		A = randjr(A)
	
	return csc_matrix(A)
