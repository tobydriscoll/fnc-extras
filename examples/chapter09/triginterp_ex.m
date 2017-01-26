%%
% We interpolate the periodic function $f(x)=e^{\sin(3\pi x)-\cos(\pi x)}$.
f = @(x) exp(sin(3*pi*x)-cos(pi*x));

%%
xx = linspace(-1,1,400)';      % evaluation points
for k = 1:2
    n = 5*k;
    x = 2*(-n:n)'/(2*n+1);     % nodes
    y = f(x);                  % values

    p = triginterp(x,y);
    yy = p(xx);                % evaluation values
    
    subplot(2,1,k)
    plot( xx,yy,'-', x,y,'.', xx,f(xx),'k-' )
end
