function [x,u,dudx] = shoot(phi,xspan,lval,lder,rval,rder,init)
%SHOOT   Shooting method for a two-point boundary-value problem.
% Input:
%   phi      defines u'' = phi(x,u,u') (function)
%   xspan    endpoints of the domain (vector)
%   lval     prescribed value for u(a) (use [] if unknown) 
%   lder     prescribed value for u'(a) (use [] if unknown) 
%   rval     prescribed value for u(b) (use [] if unknown) 
%   rder     prescribed value for u'(b) (use [] if unknown) 
%   init     initial guess for lval or lder (scalar)
% Output:
%   x        nodes in x (length n+1)
%   u        values of u(x)  (length n+1)
%   dudx     values of u'(x) (length n+1)

% Tolerances for IVP solver and rootfinder.
ivp_opt = odeset('reltol',1e-6,'abstol',1e-6);
optim_opt = optimset('tolx',1e-5);

% Find the unknown quantity at x=a by rootfinding. 
s = fzero(@objective,init,optim_opt); 

% Don't need to solve the IVP again. It was done within the
% objective function already.
u = v(:,1);            % solution     
dudx = v(:,2);         % derivative

  % Difference between computed and target values at x=b. 
  function F = objective(s)
    if isempty(lder)   % u(a) given
      v_init = [ lval; s ];
    else               % u'(a) given
      v_init = [ s; lder ];
    end
      
    [x,v] = ode45(@shootivp,xspan,v_init,ivp_opt);
      
    if isempty(rder)   % u(b) given
      F = v(end,1) - rval;
    else               % u'(b) given
      F = v(end,2) - rder;
    end
  end

  % ODE posed as a first-order equation in 2 variables. 
  function f = shootivp(x,v)
    f = [ v(2); phi(x,v(1),v(2)) ];
  end

end