%%
f = @(x) (x+1).^2.*cos((2*x+1)./(x-4.3));
I = integral(f,0,4,'abstol',1e-14,'reltol',1e-14);  % 'exact' value

%%
% We perform the integration and show the nodes selected underneath the
% curve. 
[Q,t] = intadapt(f,0,4,0.001);
fplot(f,[0 4],2000,'k'), hold on
stem(t,f(t),'.-')
num_nodes = length(t)
title('Adaptive node selection')

%%
% The error turns out to be a bit more than we requested. It's only an
% estimate, not a guarantee.
err = I - Q
 
%%
% Let's see how the number of integrand evaluations and the error vary with the requested
% tolerance.
tol_ = 10.^(-2:-1:-14)';
err_ = [];
num_ = [];

for tol = tol_'
    [Q,t] = intadapt(f,0,4,tol);
    err_ = [err_; I - Q];
    num_ = [num_; length(t)];
end

fprintf('%5s %14s %13s\n\n','tol','error','f-evals')
fprintf('%7.1e %14.3e %10d\n',[tol_,err_,num_]')

%%
% As you can see, even though the errors are not less than the estimates,
% the two columns decrease in tandem. If we consider now the convergence
% not in $h$ (which is poorly defined) but in the number of nodes
% actually chosen, we come close to the fourth order accuracy of the
% underlying quadrature scheme.

%%
clf,  loglog(num_,abs(err_),'.-')
hold on
loglog(num_,0.01*(num_/num_(1)).^(-4),'--')
title('Convergence of adaptive quadrature')
xlabel('number of nodes'),  ylabel('error')
legend('error','O(n^{-4})')
xlim(num_([1 end]))