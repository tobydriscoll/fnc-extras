"""
    forwardsub(L,b)

Solve the lower-triangular linear system with matrix `L` and right-hand side
vector `b`.
"""
function forwardsub(L,b)

n = size(L,1)
x = zeros(n)
for i = 1:n
    s = i > 1 ? sum( L[i,j]*x[j] for j=1:i-1 ) : 0
    x[i] = ( b[i] - s ) / L[i,i]
end

return x
end

"""
    backsub(U,b)

Solve the upper-triangular linear system with matrix `U` and right-hand side
vector `b`.
"""
function backsub(U,b)

n = size(U,1)
x = zeros(n)
for i = n:-1:1
    s = i < n ? sum( U[i,j]*x[j] for j=i+1:n ) : 0
    x[i] = ( b[i] - s ) / U[i,i]
end

return x
end

"""
    lufact(A)

Compute the LU factorization of square matrix `A`, returning the factors.
"""
function lufact(A)

n = size(A,1)
L = Matrix(Diagonal(ones(n)))    # puts ones on diagonal
U = copy(A)

# Gaussian elimination
for j = 1:n-1
  for i = j+1:n
    L[i,j] = U[i,j] / U[j,j]   # row multiplier
    U[i,j:n] = U[i,j:n] - L[i,j]*U[j,j:n]
  end
end

return L,triu(U)
end
