%%
[I,x] = intadapt(@sqrt,0,1,1e-10);
err = I - 2/3
number_of_nodes = length(x)

%%
% The adaptive integrator was reasonably successful. But if we integrate
% $1/\sqrt{x}$, which in unbounded at the origin, the number of nodes goes
% up dramatically. 
[I,x] = intadapt(@(x) 1./sqrt(x),eps,1,1e-10);
err = I - 2
number_of_nodes = length(x)

%%
% The nodes are packed in very closely at the origin; in fact they are
% placed with exponential spacing.
loglog(x(1:end-1),diff(x),'.')
xlabel('x'), ylabel('distance')  % ignore this line
title('Distance between nodes')  % ignore this line
xlim([1e-16 1]), ylim([1e-16 1])

