%% 1. psi(M) for epsilon = 0.1
%*** Create M
psi = zeros(size(M));
ep = 0.1;
for i = 1:length(M)
    %*** Compute a psi value by solving M(i) = psi - ep*sin(psi)
end
plot(M,psi)
xlabel('M'), ylabel('\psi')
title('Eccentric anomaly for \epsilon=0.1')

%% 2. Repeat step 1 for different values of epsilon.
for ep = 0.2:0.1:0.9
    hold on
    for i = 1:length(M)
        %*** Compute a psi value by solving M(i) = psi - ep*sin(psi)
    end
    plot(M,psi)
end
title('Eccentric anomaly for varying \epsilon')

%% 3. Results for 324 Bamberga
ep = 0.338;  tau = 4.40;  % 324 Bamberga
clf
%*** Compute psi from the orbit
%*** Compute nu from psi
%*** Plot nu(M)
xlabel('M'), ylabel('\nu')
title('True anomaly for 324 Bamberga')

%% 4. Sun distance for 324 Bamberga
mu = 39.4312;
%*** Compute a and r
%*** Plot r(M)
xlabel('M'), ylabel('r (in AU)')
title('Distance to sun for 324 Bamberga')

%% 5. Halley's comet
%*** Repeat steps 3-4 for Halley's comet
title('Distance to sun for Halley''s comet')
%*** Find min value (perihelion) and max value (aphelion) of r