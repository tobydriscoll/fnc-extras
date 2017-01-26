A = [ -2 5; -1 0 ]

%%

u0 = [1;0];
t = linspace(0,6,600);  % times for plotting
u = zeros(length(t),length(u0));
for j=1:length(t)
    ut = expm(t(j)*A)*u0;  
    u(j,:) = ut';
end

%%
plot(t,u)
