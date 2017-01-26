function wavereflect   % ignore this line

%%
% We set a wave speed that is discontinuous at $x=0$. 
speedfun = @(x) 1 + (sign(x)+1)/2;

%%
m = 120;
[x,Dx] = diffcheb(m,[-1,1]);
c = speedfun(x);

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
u_init = exp(-100*(x+0.5).^2);
z_init = -u_init;
w_init = [ u_init(2:m); z_init ];     % all non-boundary values

%%
% Solution by explicit IVP solver:
t = linspace(0,2,101);
[t,W] = ode45(@odefun,t,w_init);
W = W.';                              % rows for x, columns for t

%%
% We extract the original $u$ and $z$ variables from the results,
% adding in the zeros at the boundaries for $u$.
n = length(t)-1;
U = [ zeros(1,n+1); W(1:m-1,:); zeros(1,n+1) ];
Z = W(m:2*m,:);

%%
% Show the results.
pcolor(x,t,U.')
shading flat  % shading interp looks better on screen   % ignore this line
xlabel('x'), ylabel('t'),  title('Different wave speeds')    % ignore this line

%%
% Each pass through the interface at $x=0$ generates a reflected and
% transmitted wave. By conservation of energy, these are both smaller in
% amplitude than the incoming bump. 

end   % ignore this line