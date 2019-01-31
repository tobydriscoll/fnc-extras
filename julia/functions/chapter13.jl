"""
    ndgrid(x,y,...)

For d vector inputs, return d matrices representing the coordinate functions on the
tensor product grid.
"""
function ndgrid(x...)
    I = CartesianIndices( fill(undef,length.(x)) )
    [ [ x[d][i[d]] for i in I]  for d = 1:length(x) ]
end

"""
    rectdisc(m,xspan,n,yspan)

Create matrices and helpers for finite-difference discretization of a rectangle that is
the tensor  product of intervals `xspan` and `yspan`, using `m`+1 and `n`+1 points in
the two coordinates.
"""
function rectdisc(m,xspan,n,yspan)
    # Initialize grid and finite differences.
    x,Dx,Dxx = diffmat2(m,xspan)
    y,Dy,Dyy = diffmat2(n,yspan)
    X = repeat(x,outer=(1,n+1))
    Y = repeat(y',outer=(m+1,1))

    # Locate boundary points.
    isbndy = fill(true,m+1,n+1)
    isbndy[2:m,2:n] .= false

    # Get the diff. matrices recognized as sparse. Also include reshaping functions.
    disc = (
        Dx=sparse(Dx), Dxx=sparse(Dxx),
        Dy=sparse(Dy), Dyy=sparse(Dyy),
        Ix=Diagonal(ones(m+1)), Iy=Diagonal(ones(n+1)),
        isbndy=isbndy,
        vec=vec,
        unvec=u -> reshape(u,m+1,n+1)
        )
    return X,Y,disc
end

"""
    poissonfd(f,g,m,xspan,n,yspan)

Solve Poisson's equation on a rectangle by finite differences. Function `f` is the
forcing function and function `g` gives the  Dirichlet boundary condition. The rectangle
is the tensor product of intervals `xspan` and `yspan`,  and the discretization uses
`m`+1 and `n`+1 points in the two coordinates.

Return matrices of the solution values, and the coordinate functions, on the grid.
"""
function poissonfd(f,g,m,xspan,n,yspan)
    # Initialize the rectangle discretization.
    X,Y,d = rectdisc(m,xspan,n,yspan)

    # Form the collocated PDE as a linear system.
    A = kron(d.Iy,d.Dxx) + kron(d.Dyy,d.Ix)  # Laplacian matrix
    b = d.vec(f.(X,Y))

    # Replace collocation equations on the boundary.
    scale = maximum(abs.(A[n+2,:]))
    I = kron(d.Iy,d.Ix)
    A[d.isbndy[:],:] = scale*I[d.isbndy[:],:]                 # Dirichet assignment
    b[d.isbndy[:]] = scale*g.( X[d.isbndy],Y[d.isbndy] )  # assigned values

    # Solve the linear sytem and reshape the output.
    u = A\b
    U = d.unvec(u)
    return U,X,Y
end

"""
    newtonpde(f,g,m,xspan,n,yspan)

Newton's method with finite differences to solve the PDE `f`(u,x,y,disc)=0 on the
rectangle `xspan` ``\times`` `yspan`, subject to `g`(x,y)=0 on the boundary. Use `m`+1
points in x by `n`+1 points in y.

Return matrices of the solution values, and the coordinate functions, on the grid.
"""

function newtonpde(f,g,m,xspan,n,yspan)
    # Discretization.
    X,Y,d = rectdisc(n,xspan,n,yspan)

    # This evaluates the discretized PDE and its Jacobian, with all the
    # boundary condition modifications applied.
    function residual(U)
        R,J = f(U,X,Y,d)
        Ixy = Diagonal(ones(size(J,1)))   # used for row replacements
        scale = maximum(abs.(J))
        J[vec(d.isbndy),:] = scale*Ixy[d.isbndy[:],:]
        XB = X[d.isbndy];  YB = Y[d.isbndy];
        @. R[d.isbndy] = scale*(U[d.isbndy] - g(XB,YB))
        r = d.vec(R)
        return r,J
    end

    # Intialize the Newton iteration.
    U = zeros(size(X))
    r,J = residual(U)
    tol = 1e-10;  itermax = 20;
    s = Inf;  normr = norm(r);  k = 1;

    lambda = 1
    while (norm(s) > tol) && (normr > tol)
        s = -(J'*J + lambda*I) \ Vector(J'*r)  # damped step
        Unew = U + d.unvec(s)
        rnew,Jnew = residual(Unew)

        if norm(rnew) < normr
            # Accept and update.
            lambda = lambda/6;   # dampen the Newton step less
            U = Unew;  r = rnew;  J = Jnew;
            normr = norm(r)
            k = k+1
            println("Norm of residual = $normr")
        else
            # Reject.
            lambda = lambda*4;   # dampen the Newton step more
        end

        if k==itermax
            @warn "Maximum number of Newton iterations reached."
            break
        end
    end
    return U,X,Y
end
