%%
% We construct a symmetric matrix with a known EVD.
n = 20;
lambda = (1:n)';  D = diag(lambda);
[V,~] = qr(randn(n));   % get a random orthogonal V
A = V*D*V';

%%
% The Rayleigh quotient of an eigenvector is its eigenvalue.
R = @(x) (x'*A*x)/(x'*x);
format long, R(V(:,7))

%% 
% The Rayleigh quotient's value is much closer to an eigenvalue than its
% input is to an eigenvector. In this experiment, each additional digit of
% accuracy in the eigenvector estimate gives two more digits to the
% eigenvalue estimate.
delta = 1./10.^(1:4)';
quotient = 0*delta;
for k = 1:4
    e = randn(n,1);  e = delta(k)*e/norm(e);
    x = V(:,7)+e;
    quotient(k) = R(x);
end
table(delta,quotient)