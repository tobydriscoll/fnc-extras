%%
function wave   % ignore this line

%%
% We solve the wave equation (in Maxwell form) for speed $c=2$, with
% homogeneous Dirichlet conditions on the first variable. 
c = 2;  m = 200;
[x,Dx] = diffmat2(m,[0,1]);

%%
% Compute the time derivative of the system at interior points:
    function dwdt = odefun(t,w)
        U = [0; w(1:m-1); 0];
        Z = w(m:2*m);
        dudt = Dx*Z;
        dzdt = c.^2 .* (Dx*U);
        dwdt = [ dudt(2:m); dzdt ];
    end

%%
% Initial conditions.
u_init = exp(-100*(x-0.5).^2);
z_init = -u_init;
w_init = [ u_init(2:m); z_init ];     % all non-boundary values

%%
% Solution by an explicit IVP solver:
t = linspace(0,2,101);
[t,W] = ode45(@odefun,t,w_init);
W = W.';                              % rows for x, columns for t

%%
% We extract the original $u$ and $z$ variables from the results, 
% adding in the zeros at the boundaries for $u$, and plot $u(x,t)$.
n = length(t)-1;
U = [ zeros(1,n+1); W(1:m-1,:); zeros(1,n+1) ];
Z = W(m:2*m,:);

%%
% Show the results for the original $u$ variable. 
subplot(1,2,1)
surf(x,t,U.')
shading flat, view([-20 40])    % ignore this line
xlabel x, ylabel t, title('Wave equation')    % ignore this line
subplot(1,2,2)
pcolor(x,t,U.'), shading flat    % ignore this line
xlabel x, ylabel t, title('top view')    % ignore this line

%%
% The original hump breaks into two pieces of different amplitudes. Each
% travels with speed $c=2$, and they pass through one another without
% interference. When a hump encounters a boundary, it is perfectly
% reflected, but with inverted shape. At time $t=3$ the solution looks
% exactly like the initial condition.

end   % ignore this line