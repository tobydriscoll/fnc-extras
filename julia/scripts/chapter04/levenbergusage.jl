
function nlsystem(x)
    return [ exp(x[2]-x[1]) - 2,
          x[1]*x[2] + x[3],
          x[2]*x[3] + x[1]^2 - x[2]
        ]
end

include("../FNC.jl")
x1 = [0,0,0]   
x = FNC.levenberg(nlsystem,x1)

using LinearAlgebra
r = x[:,end]
@show backward_err = norm(nlsystem(r));

@. log( 10, abs(x[1,1:end-1]-r[1]) )
