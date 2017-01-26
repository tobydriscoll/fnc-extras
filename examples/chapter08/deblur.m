%%
% For this example we will experiment with a grayscale image that comes
% with MATLAB.
load mandrill
image(X)
colormap(gray(256))
[m,n] = size(X)

%%
% Next we define the matrix that blurs by left-multiplication (blurs
% columns). It's only $m\times m$, so we don't need to be very careful
% about dealing with it. 
blurcol = exp(-0.1*(0:m-1).^2);
blurcol(blurcol < 1e-9) = 0;
Gm = toeplitz(blurcol);
Gm = sparse(Gm) / norm(Gm);

%%
% We do the same for the matrix that will blur the rows. 
blurcol = exp(-0.1*(0:n-1).^2);
blurcol = blurcol/sum(blurcol);
Gn = toeplitz(blurcol);
Gn = sparse(Gn)/norm(Gn);

%%
% This is now the blurred version of the original image. It's a linear
% transformation, evaluated at $X$.
Y = Gm*X*Gn';
image(Y)

%%
% We want to use linear algebra to undo the blurring; i.e., map $Y$ back to
% $X$. 

%%
% Recall the vec function that maps a matrix to an equivalent vector, by
% stacking columns. We define a MATLAB function fot that, for convenience.
% We also define a function that does the reverse, mapping an $mn\times 1$
% vector back to its $m\times n$ counterpart.
vec = @(Z) Z(:);
unvec = @(z) reshape(z,[m n]);

%%
% Here comes a key line to understand! Because the matrix mapping an image
% to its blurred result is a linear transformation, it has an associated
% matrix. But the matrix is $mn\times mn$, so we want to avoid it. Instead,
% we define a function that performs the linear transformation. Because
% MATLAB wants to work with actual vectors (rather than vector space
% ``vectors''), we have to pull a vector back to matrix form, apply
% blurring as above, and then map it back to a vector form.
blur_fun = @(z) vec( Gm*unvec(z)*Gn' );

%%
% If we have done things correctly, the result of |blur_fun| on the vector
% form of $X$ is exactly the vector form of $Y$.
norm( vec(Y) - blur_fun(vec(X)) )

%%
% Now we are ready for GMRES. We define a preferred tolerance for the
% residual (relative to the right-hand side vector $\bfb$) and set a
% maximum nuumber of iterations. 
tol = 1e-5;
maxit = 40;

%% 
% There are up to five outputs from |gmres|. We are interested only in the
% first and the last. 
[u,~,~,~,residual] = gmres(blur_fun,vec(Y),[],tol,maxit); 

%%
% We started with $X$, so ideally the inverse of blurring will restore it
% exactly.
relative_error = norm(u - vec(X)) / norm(u)


%%
% That looks like a rather large error. From a convergence plot of GMRES,
% we can see that it struggled to reduce the residual after the first few
% steps. 
semilogy(residual,'.-')

%%
% However, to visual accuracy, the restoration is quite good. 
subplot(1,2,1), image(X)
title('original')
subplot(1,2,2), image(unvec(u))
title('unblurred')