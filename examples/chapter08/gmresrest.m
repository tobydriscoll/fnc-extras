%%
% The following experiments are based on a matrix resulting from
% discretization of a partial differential equation.
maxit = 120;  rtol = 1e-8;
d = 50;
A = d^2*gallery('poisson',d);
n = length(A)
b = ones(n,1);

%%
% We compare unrestarted GMRES with three different thresholds for
% restarting.
rest = [maxit 20 30 40];
for j = 1:4
    [~,~,~,~,rv1] = gmres(A,b,rest(j),rtol,maxit/rest(j));
    semilogy(0:length(rv1)-1,rv1,'.-'), hold on
end
axis tight, title('Convergence of restarted GMRES')    % ignore this line
xlabel('m'), ylabel('residual norm')   % ignore this line

%%
% The ``pure'' curve is the lowest one. All of the other curves agree with
% it until they encounter their first restart. 