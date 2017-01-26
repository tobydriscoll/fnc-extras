%%
% Let's define a set of 6 nodes (i.e., $n=5$ in our formulas). 
t = [0 0.075 0.25 0.55 0.7 1]';

%%
% We plot the hat functions $H_0,\ldots,H_5$.  
for k = 0:5
    fplot(@(x) hatfun(x,t,k),[0 1])
    hold on
end
xlabel('x'), ylabel('H_k(x)'), title('Hat functions')