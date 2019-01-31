
A = [
     2    0    4    3 
    -4    5   -7  -10 
     1   15    2   -4.5
    -2    0    2  -13
    ];

b = [ 4, 9, 29, 40 ];

S = [A b]

@show mult21 = S[2,1]/S[1,1];
S[2,:] -= mult21*S[1,:];   # -= means "subtract the following from"
S

@show mult31 = S[3,1]/S[1,1];
S[3,:] -= mult31*S[1,:];
@show mult41 = S[4,1]/S[1,1];
S[4,:] -= mult41*S[1,:];
S

for i = 3:4
    mult = S[i,2]/S[2,2]
    S[i,:] -= mult*S[2,:]
end
S

for i = 4
    mult = S[i,3]/S[3,3]
    S[i,:] -= mult*S[3,:]
end
S

U = S[:,1:4]

z = S[:,5]

include("../FNC.jl")
x = FNC.backsub(U,z)

b - A*x
