%%
% In this example we compare MINRES and CG on some basic problems. 
% There is a command to make pseudo-random sparse, SPD matrices that we
% will exploit here.
n = 1000;
density = 0.008;
A = sprandsym(n,density,1e-2,2);

%%
% We cook up a linear system whose solution we happen to know exactly.
x = (1:n)'/n;
b = A*x;

%%
% Now we apply both methods and compare the convergence of the system
% residuals, using the built-in function |pcg| in the latter case.
[xMR,residMR] = minres(A,b,100);
[xCG,~,~,~,residCG] = pcg(A,b,1e-12,100);
semilogy(residMR,'.-')
hold on
semilogy(residCG,'.-')

%%
% There is virtually no difference between the two methods here when
% measuring the residual. We see little difference in the errors as well. 
errorMR = norm( xMR - x )
errorCG = norm( xCG - x)

%%
% Here we use a system matrix with a key difference to be explained
% shortly.
A = sprandsym(n,density,1e-4,2);

%%
% Now we find that the CG residual jumps up initially, and then both
% methods converge at about the same linear rate. Note that both methods
% have actually made very little progress after 100 iterations, though. 
[xMR,residMR] = minres(A,b,100);
[xCG,~,~,~,residCG] = pcg(A,b,1e-12,100);
clf
semilogy(residMR,'.-')
hold on
semilogy(residCG,'.-')

%%
% The errors confirm that we are nowhere near the correct solution in
% either case.
errorMR = norm( xMR - x )
errorCG = norm( xCG - x)

