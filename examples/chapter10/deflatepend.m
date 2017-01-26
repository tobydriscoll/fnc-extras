%%
% Here is one solution for a damped pendulum starting at angle 2.5 radians
% and ending at zero radians (straight down) after 5 time units. 
phi = @(t,theta,omega) -0.05*omega - sin(theta);
init = 2.5*ones(201,1);
[t,theta1,residual] = bvpfd(phi,[0,6],2.5,[],2.5,[],init);
plot(t,theta1)
xlabel('t'), ylabel('\theta(t)')   % ignore this line
title('Pendulum over [0,8]')   % ignore this line

%%
%
f = @(theta) residual(theta)*(1 + 1/norm(theta-theta1));
theta2 = levenberg(f,-theta1);
theta2 = theta2(:,end);
hold on, plot(t,theta2)
xlabel('t'), ylabel('\theta(t)')   % ignore this line
title('Two solutions')   % ignore this line

