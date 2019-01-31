
A = [ 1 2 3 4 5; 50 40 30 20 10
    pi sqrt(2) exp(1) (1+sqrt(5))/2 log(3) ]

m,n = size(A)

x = [ 3, 3, 0, 1, 0 ]
size(x)

size( [3;3;0;1;0] )

AA = [ A; A ]

B = [ zeros(3,2) ones(3,1) ]

A'

x'

y = 1:4              # start:stop

z = ( 0:3:12 )'     # start:step:stop

s = range(-1,stop=1,length=5)  

a = A[2,end-1]

x[2]

A[1:2,end-2:end]    # first two rows, last three columns

A[:,1:2:end]        # all of the odd columns

using LinearAlgebra
B = diagm( 0=>[-1,0,-5] )     # create a diagonal matrix

BA = B*A     # matrix product

A*B

B^3    # same as B*B*B

C = -A;

elementwise = A.*C

xtotwo = x.^2

twotox = 2 .^ x

@show cos.(pi*x);      # vectorize a single function
@show @. cos(pi*x);    # vectorize an entire expression
