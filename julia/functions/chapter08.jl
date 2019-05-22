"""
    poweriter(A,numiter)

Perform `numiter` power iterations with the matrix `A`, starting from a random vector,
and return a vector of eigenvalue estimates and the final eigenvector approximation.
"""
function poweriter(A,numiter)
    n = size(A,1)
    x = normalize(randn(n),Inf)
    gamma = zeros(numiter)
    for k = 1:numiter
      y = A*x
      normy,m = findmax(abs.(y))
      gamma[k] = y[m]/x[m]
      x = y/y[m]
    end

    return gamma,x
end

"""
    inviter(A,s,numiter)

    Perform `numiter` inverse iterations with the matrix `A` and shift `s`, starting
    from a random vector, and return a vector of eigenvalue estimates and the final
    eigenvector approximation.
"""
function inviter(A,s,numiter)
    n = size(A,1)
    x = normalize(randn(n),Inf)
    gamma = zeros(numiter)
    fact = lu(A - s*I)
    for k = 1:numiter
      y = fact\x
      normy,m = findmax(abs.(y))
      gamma[k] = x[m]/y[m] + s
      x = y/y[m]
    end

    return gamma,x
end

"""
    arnoldi(A,u,m)

Perform the Arnoldi iteration for `A` starting with vector `u`, out to the Krylov
subspace of degree `m`. Return the orthonormal basis (`m`+1 columns) and the upper
Hessenberg `H` of size `m`+1 by `m`.
"""
function arnoldi(A,u,m)
    n = length(u)
    Q = zeros(n,m+1)
    H = zeros(m+1,m)
    Q[:,1] = u/norm(u)
    for j = 1:m
      # Find the new direction that extends the Krylov subspace.
      v = A*Q[:,j]
      # Remove the projections onto the previous vectors.
      for i = 1:j
        H[i,j] = dot(Q[:,i],v)
        v -= H[i,j]*Q[:,i]
      end
      # Normalize and store the new basis vector.
      H[j+1,j] = norm(v)
      Q[:,j+1] = v/H[j+1,j]
    end

    return Q,H
end

"""
    arngmres(A,b,m)

Do `m` iterations of GMRES for the linear system `A`*x=`b`. Return the final solution
estimate x and a vector with the history of residual norms. (This function is for
demo only, not practical use.)
"""
function arngmres(A,b,m)
    n = length(b)
    Q = zeros(n,m+1)
    Q[:,1] = b/norm(b)
    H = zeros(m+1,m)

    # Initial "solution" is zero.
    residual = [norm(b);zeros(m)]
    
    for j = 1:m
      # Next step of Arnoldi iteration.
      v = A*Q[:,j]
      for i = 1:j
          H[i,j] = dot(Q[:,i],v)
          v -= H[i,j]*Q[:,i]
      end
      H[j+1,j] = norm(v)
      Q[:,j+1] = v/H[j+1,j]

      # Solve the minimum residual problem.
      r = [norm(b); zeros(j)]
      z = H[1:j+1,1:j] \ r
      x = Q[:,1:j]*z
      residual[j+1] = norm( A*x - b )
    end

    return x,residual
end

function sprandsym(n,density,lambda::Vector)
    function randjr(A)
        # Random Jacobi rotation similarity transformation.
        theta = 2pi*rand()
        c,s = cos(theta),sin(theta)
        i,j = rand(1:n,2)
        A[[i,j],:] = [c s;-s c]*A[[i,j],:]
        A[:,[i,j]] = A[:,[i,j]]*[c -s;s c]
        return A
    end

    targetnz = ceil(min(0.98,density)*n^2)
    A = spdiagm(0=>lambda)
    while nnz(A) < targetnz
        A = randjr(A)
    end
    return A
end

function sprandsym(n,density,rcond::Number)
    lambda = [ rcond^(i/(n-1)) for i = 0:n-1 ]
    sprandsym(n,density,lambda)
end
