%%
f = @(x) sin( exp(x+1) );
exact_value = cos(exp(1))*exp(1);
%%
% We'll run both formulas in parallel for a sequence of $h$ values.
h = 4.^(-1:-1:-8)';
FD1 = 0*h;  FD2 = 0*h;
for k = 1:length(h)
    FD1(k) = (f(h(k)) - f(0)) / h(k);
    FD2(k) = (f(h(k)) - f(-h(k))) / (2*h(k));
end

%%
% In each case $h$ is decreased by a factor of 4, so that the error is
% reduced by a factor of 4 in the first-order method and 16 in the
% second-order method.
error_FD1 = exact_value-FD1;  
error_FD2 = exact_value-FD2;
table(h,error_FD1,error_FD2)
   
%%
% A graphical comparison can be clearer. On a log-log scale, the error
% should (roughly) be a straight line whose slope is the order of accuracy.
% However, it's conventional in convergence plots, to show $h$ _decreasing_
% from left to right, which negates the slopes.
loglog(h,[abs(error_FD1),abs(error_FD2)],'.-')
hold on, loglog(h,[h,h.^2],'--')      % perfect 1st and 2nd order 
set(gca,'xdir','reverse')
xlabel('h'), ylabel('error in f''(0)')     % ignore this line
legend('error FD1','error FD2','order 1','order 2','location','southwest') % ignore this line
title('Convergence of finite differences')   % ignore this line