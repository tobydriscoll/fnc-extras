
function nlsystem(x)
    f = zeros(3)  
    f[1] = exp(x[2]-x[1]) - 2;
    f[2] = x[1]*x[2] + x[3];
    f[3] = x[2]*x[3] + x[1]^2 - x[2];
    
    J = zeros(3,3)
    J[1,:] = [-exp(x[2]-x[1]),exp(x[2]-x[1]), 0]
    J[2,:] = [x[2], x[1], 1]
    J[3,:] = [2*x[1], x[3]-1, x[2]]
    
    return f,J
end

x1 = [0,0,0]
include("../FNC.jl")
x = FNC.newtonsys(nlsystem,x1)

r = x[:,end]
f,J = nlsystem(r)
f

@. log( 10,abs(x[1,1:end-1]-r[1]) )
