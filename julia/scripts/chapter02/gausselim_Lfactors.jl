
A = [2 0 4 3 ; -4 5 -7 -10 ; 1 15 2 -4.5 ; -2 0 2 -13];

using LinearAlgebra
I = diagm(0=>ones(4))

mult21 = A[2,1]/A[1,1]
L21 = I - mult21*I[:,2]*I[:,1]'
A = L21*A

mult31 = A[3,1]/A[1,1];
L31 = I - mult31*I[:,3]*I[:,1]';
A = L31*A;

mult41 = A[4,1]/A[1,1];
L41 = I - mult41*I[:,4]*I[:,1]';
A = L41*A
