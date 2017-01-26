%%
% We solve the nonlinear problem $u_t = u_{xx} + u^2$ over $[0,1]$ with
% homogeneous Dirichlet boundary conditions. 
phi = @(x,t,u,ux,uxx) uxx + u.^2;
u0 = @(x) 60*x.^3.*sin(pi*x);
[U,x,t] = pdestiff(phi,[0,1],300,1,u0,0,[],0,[]);
waterfall(x,t,U')
xlabel('x'),  ylabel('t'),  zlabel('u(x,t)')
