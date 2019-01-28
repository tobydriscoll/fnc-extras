"""
    lsnormal(A,b)

Solve a linear least squares problem by the normal equations. Returns the
minimizer of ||b-Ax||.
"""
function lsnormal(A,b)

N = A'*A;  z = A'*b;
R = cholesky(N).U
w = forwardsub(R',z)                   # solve R'z=c
x = backsub(R,w)                       # solve Rx=z

return x
end


"""
    lsqrfact(A,b)

Solve a linear least squares problem by QR factorization. Returns the
minimizer of ||b-Ax||.
"""
function lsqrfact(A,b)

Q,R = qr(A)
c = Q'*b
x = backsub(R,c)

return x
end
