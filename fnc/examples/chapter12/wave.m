%%
function wave   % ignore this line

%%
% We solve the wave equation (in Maxwell form) for speed $c=2$, with
% homogeneous Dirichlet conditions on the first variable. 
c = 2;  m = 200;
[x,Dx] = diffmat2(m,[-1,1]);

%%
% The boundary values of $u$ are given to be zero, so they are not unknowns
% in the ODEs we solve. Instead they are added or removed as necessary. 
chop = @(u) u(2:m);
extend = @(v) [0;v;0];

%%
% The following function computes the time derivative of the system at
% interior points. (This entire example is written as a function, not a
% script, to make this definition possible.)
    function dwdt = odefun(t,w)
        u = extend(w(1:m-1));
        z = w(m:2*m);
        dudt = Dx*z;
        dzdt = c.^2 .* (Dx*u);
        dwdt = [ chop(dudt); dzdt ];
    end

%%
% Our initial condition is a single hump for $u$.
u_init = exp(-100*(x).^2);
z_init = -u_init;
w_init = [ chop(u_init); z_init ];  

%%
% Because the wave equation is hyperbolic, we can use the nonstiff IVP
% solver |ode45|.
t = linspace(0,2,101);
[t,W] = ode45(@odefun,t,w_init);
W = W.';              % rows for x, columns for t

%%
% We extract the original $u$ and $z$ variables from the results, 
% adding in the zeros at the boundaries for $u$.
n = length(t)-1;
U = [ zeros(1,n+1); W(1:m-1,:); zeros(1,n+1) ];
Z = W(m:2*m,:);

%%
% We plot the results for the original $u$ variable. 
subplot(1,2,1)
waterfall(x,t,U.')
shading flat, view([-20 40])    % ignore this line
xlabel x, ylabel t, title('Wave equation')    % ignore this line
subplot(1,2,2)
pcolor(x,t,U.')
shading flat    % ignore this line
xlabel x, ylabel t, title('top view')    % ignore this line

%%
% The original hump breaks into two pieces of different amplitudes. Each
% travels with speed $c=2$, and they pass through one another without
% interference. When a hump encounters a boundary, it is perfectly
% reflected, but with inverted shape. At time $t=2$ the exact solution looks
% just like the initial condition.

end   % ignore this line