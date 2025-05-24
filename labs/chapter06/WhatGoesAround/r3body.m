function dudt = r3body(t,u)

mu = 0.012277471;
mustar = 1 - mu;

x = u(1);  y = u(2);
r = ((x + mu)^2 + y^2) ^ 1.5;
rstar = ((x - mustar)^2 + y^2) ^ 1.5;
xdot = u(3);  ydot = u(4);

xdotdot = 2*ydot + x - mustar*((x + mu)/r) - mu*((x - mustar)/rstar);
ydotdot = -2*xdot + y - mustar*(y/r) - mu*(y/rstar);

dudt = [xdot;ydot;xdotdot;ydotdot];

end
