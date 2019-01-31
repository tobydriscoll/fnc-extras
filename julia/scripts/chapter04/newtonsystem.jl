
function nlvalue(x)
    return [ exp(x[2]-x[1]) - 2,
          x[1]*x[2] + x[3],
          x[2]*x[3] + x[1]^2 - x[2]
        ]
end

function nljac(x)
    J = zeros(3,3)
    J[1,:] = [-exp(x[2]-x[1]), exp(x[2]-x[1]), 0]
    J[2,:] = [x[2], x[1], 1]
    J[3,:] = [2*x[1], x[3]-1, x[2]]
    return J
end

x = [0,0,0]

@show f = nlvalue(x);
@show J = nljac(x);

s = -(J\f)
x = [x x[:,1]+s]

nlvalue(x[:,2])

for n = 2:7
    f = [f nlvalue(x[:,n])]
    s = -( nljac(x[:,n]) \ f[:,n] )
    x = [x x[:,n]+s]
end

residual_norm = maximum(abs.(f),dims=1)   # max in dimension 1

r = x[:,end]
x = x[:,1:end-1]

e = x .- r

errs = maximum(abs.(e),dims=1)
ratios = @. log(errs[2:end]) / log(errs[1:end-1])
