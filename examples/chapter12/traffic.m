%%
% We solve for traffic flow using periodic boundary conditions. These are
% necessary parameters and a function.
rho_c = 1080;  rho_m = 380;  q_m = 10000;
Q0prime = @(rho) q_m*4*rho_c^2*(rho_c-rho_m)*rho_m ...
    *(rho_m-rho)./(rho*(rho_c-2*rho_m) + rho_c*rho_m).^3;
ep = 0.02;

%%
% Here we create the discretization.
[x,Dx,Dxx] = diffper(800,[0,4]);

%%
% Define the ODE in the method of lines.
odefun = @(t,w) -Q0prime(w).*(Dx*w) + ep*(Dxx*w);

%%
% This initial condition has moderate density with a small bump.
rho_init = 400 + 10*exp(-20*(x-3).^2);
t = linspace(0,1,61);
[t,RHO] = ode15s(odefun,t,rho_init);
plot(x,RHO(1:10:end,:))

%%
% The bump slowly moves backward on the roadway, spreading out and
% gradually fading away.

%%
% Now we use an initial condition with a larger bump. 
rho_init = 400 + 80*exp(-16*(x-3).^2);
t = linspace(0,0.5,61);
[t,RHO] = ode15s(odefun,t,rho_init);
plot(x,RHO(1:10:end,:))

%%
% In this case the density bump travels backward along the road but also
% steepens on the side facing the incoming traffic and decreases much more
% slowly on the other side. A motorist would experience this as an abrupt
% and large increase in density, followed by a much more gradual decrease
% in density and resulting gradual increase in speed.