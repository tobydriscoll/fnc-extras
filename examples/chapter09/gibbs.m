%%
% This function is discontinuous at zero. 
f = @(x) sign(x+eps);

%%
fplot(f,[-1 1],'k')
hold on

for k = 1:3
    n = 20*k^2;    t = 2*(-n:n)'/(2*n+1);      
    fplot(triginterp(t,f(t)))
    xlim([-0.05 0.15])          
end
