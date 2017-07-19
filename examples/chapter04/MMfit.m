function MMfit   % ignore this line
%%
% Inhibited enzyme reactions often follow what are known as
% _Michaelis--Menten_ kinetics, in which a reaction rate $v$ follows a law
% of the form
%
% $$v(x) = \frac{V x}{K_m + x},$$
% 
%%
% where $x$ is the concentration of a substrate. The real values $V$ and
% $K_m$ are parameters that are free to fit to data. For this example we
% cook up some artificial data with $V=2$ and $K_m=1/2$.
m = 25;
x = linspace(0.05,6,m)';
y = 2*x./(0.5+x);                   % exactly on the curve
y = y + 0.15*cos(2*exp(x/16).*x);   % noise added
plot(x,y,'.')
title('Data')    % ignore this line
xlabel('x'), ylabel('v')    % ignore this line

%%
% The idea is to pretend that we know nothing of the origins of this data
% and use nonlinear least squares on the misfit to find the parameters in
% the theoretical model function $v(x)$. Note in the Jacobian that the
% derivatives are _not_ with respect to $x$, but with respect to the two
% parameters, which are contained in the vector |c|.

    function [f,J] = misfit(c)
        V = c(1);   Km = c(2);
        f = V*x./(Km+x) - y;
        J(:,1) = x./(Km+x);            % d/d(V)
        J(:,2) = -V*x./(Km+x).^2;      % d/d(Km)
    end

%%
c1 = [1; 0.75];
c = newtonsys(@misfit,c1);
V = c(1,end),  Km = c(2,end)   % final values
model = @(x) V*x./(Km+x);

%%
% The final values are close to the noise-free values of $V=2$, $K_m=0.5$
% that we used to generate the data. We can calculate the amount of misfit
% at the end, although it's not completely clear what a "good" value would
% be. Graphically, the model looks reasonable.
final_misfit_norm = norm(model(x)-y) 
hold on
fplot( model, [0 6] )
title('Michaelis-Menten fitting')    % ignore this line
xlabel('concentration'), ylabel('reaction rate')    % ignore this line

%%
% For this model, we also have the option of linearizing the fit process.
% Rewrite the model as $1/v= (a/x)+b$ for the new parameters $\alpha=K_m/V$
% and $\beta=1/V$. This corresponds to the misfit function whose entries
% are
%
% $$f_i(\alpha,\beta) = \alpha \cdot \frac{1}{x_i} + \beta - \frac{1}{y_i},$$
%
% for $i=1,\ldots,m$. Although the misfit is nonlinear in $x$ and $y$, it's
% linear in the unknown parameters $\alpha$ and $\beta$, and so can be
% posed and solved as a linear least-squares problem.
A = [ x.^(-1), x.^0 ];  u = 1./y;
z =  A\u;
alpha = z(1);  beta = z(2);

%%
% The two fits are different, because they do not optimize the same
% quantities. 
linmodel = @(x) 1 ./ (beta + alpha./x);
final_misfit_linearized = norm(linmodel(x)-y)
fplot(linmodel, [0 6] )

end    % ignore this line