from scipy import *
from numpy import *
from scipy.linalg import *
import scipy.sparse as sp
from scipy.sparse.linalg import spsolve
import warnings
from FNC10 import diffmat2

def rectdisc(m,xspan,n,yspan):
	"""
	rectdisc(m,xspan,n,yspan)

	Create matrices and helpers for finite-difference discretization of a rectangle that is
	the tensor  product of intervals `xspan` and `yspan`, using `m`+1 and `n`+1 points in
	the two coordinates.
	"""
	# Initialize grid and finite differences.
	x,Dx,Dxx = diffmat2(m,xspan)
	y,Dy,Dyy = diffmat2(n,yspan)
	X,Y = meshgrid(x,y)

	# Locate boundary points.
	isbndy = tile(True,(n+1,m+1))
	isbndy[1:-1,1:-1] = False

    # Get the diff. matrices recognized as sparse. Also include reshaping functions.
	disc = {
		"Dx":sp.lil_matrix(Dx), "Dxx":sp.lil_matrix(Dxx),
		"Dy":sp.lil_matrix(Dy), "Dyy":sp.lil_matrix(Dyy),
		"Ix":sp.eye(m+1,format="lil"), "Iy":sp.eye(n+1,format="lil"),
		"isbndy":isbndy,
		"vec": lambda U: U.flatten(),
		"unvec": lambda u: reshape(u,(n+1,m+1))
	}
	return X,Y,disc

def poissonfd(f,g,m,xspan,n,yspan):
	"""
	poissonfd(f,g,m,xspan,n,yspan)

	Solve Poisson's equation on a rectangle by finite differences. Function `f` is the
	forcing function and function `g` gives the  Dirichlet boundary condition. The rectangle
	is the tensor product of intervals `xspan` and `yspan`,  and the discretization uses
	`m`+1 and `n`+1 points in the two coordinates.

	Return matrices of the solution values, and the coordinate functions, on the grid.
	"""
	# Initialize the rectangle discretization.
	X,Y,d = rectdisc(m,xspan,n,yspan)

	# Form the collocated PDE as a linear system.
	A = sp.kron(d["Iy"],d["Dxx"]) + sp.kron(d["Dyy"],d["Ix"])  # Laplacian matrix
	b = d["vec"](f(X,Y))

	# Replace collocation equations on the boundary.
	scale = amax(abs(A[n+1,:]))
	I = sp.lil_matrix(sp.eye((m+1)*(n+1)))
	isbndy = d["isbndy"]
	vec = d["vec"]
	A[vec(isbndy),:] = scale*I[vec(isbndy),:]                 # Dirichet assignment
	b[vec(isbndy)] = scale*g( X[isbndy],Y[isbndy] )  # assigned values

	# Solve the linear sytem and reshape the output.
	u = spsolve(A,b)
	U = d["unvec"](u)
	return U,X,Y


def newtonpde(f,g,m,xspan,n,yspan):
	"""
	newtonpde(f,g,m,xspan,n,yspan)

	Newton's method with finite differences to solve the PDE `f`(u,x,y,disc)=0 on the
	rectangle `xspan` ``\times`` `yspan`, subject to `g`(x,y)=0 on the boundary. Use `m`+1
	points in x by `n`+1 points in y.

	Return matrices of the solution values, and the coordinate functions, on the grid.
	"""
	# Discretization.
	X,Y,d = rectdisc(m,xspan,n,yspan)

	# This evaluates the discretized PDE and its Jacobian, with all the
	# boundary condition modifications applied.
	bndy = d["isbndy"]
	vec = d["vec"]
	def residual(U):
		R,J = f(U,X,Y,d)
		scale = amax(abs(J))
		I = sp.eye((m+1)*(n+1),format="lil")
		J[vec(bndy),:] = scale*I[vec(bndy),:]
		XB = X[bndy];  YB = Y[bndy];
		R[bndy] = scale*(U[bndy] - g(XB,YB))
		r = vec(R)
		return r,J

	# Intialize the Newton iteration.
	U = zeros(X.shape)
	r,J = residual(U)
	tol = 1e-10;  itermax = 20;
	s = 2;  normr = norm(r);  k = 1;

	lamb = 1
	I = sp.eye((m+1)*(n+1))
	while (norm(s) > tol) and (normr > tol):
		s = -spsolve(J.T@J + lamb*I, J.T@r)  # damped step
		Unew = U + d["unvec"](s)
		rnew,Jnew = residual(Unew)

		if norm(rnew) < normr:
			# Accept and update.
			lamb = lamb/6;   # dampen the Newton step less
			U = Unew;  r = rnew;  J = Jnew;
			normr = norm(r)
			k = k+1
			print(f"Norm of residual = {normr:.4g}")
		else:
			# Reject.
			lamb = lamb*4;   # dampen the Newton step more

		if k==itermax:
			warnings.warn("Maximum number of Newton iterations reached.")
			break

	return U,X,Y

