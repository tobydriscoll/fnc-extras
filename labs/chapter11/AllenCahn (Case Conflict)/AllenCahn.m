function Allencahn

%% 1.
m = 200;
[x,Dx,Dxx] = diffcheb(m,[-1 1]);
%*** Fix the definitions of the extend and chop functions.
extend = [];
chop = [];

%% 2.
function fI = timederiv(t,uI)
    u = extend(uI);
    %*** Compute f to define the PDE.
    fI = chop(f);
end

%% 3.
beta = 1.6;
%*** Define u0 using the initial condition.
u0 = [];

t = linspace(0,5,50);
%*** Call ode15s for the solution.

%% This section works as given.
plot(x,u0)
f = getframe;
[im,map] = rgb2ind(f.cdata,256,'nodither');
for k=1:length(t)
    plot(x,extend(uI(k,:)'))
    axis([-1 1 -1 1])
    f=getframe;
    im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
end
imwrite(im,map,'animation.gif','DelayTime',0,'LoopCount',inf);


end