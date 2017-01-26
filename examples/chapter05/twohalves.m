%%
% This function gets increasingly oscillatory near the right endpoint.
f = @(x) (x+1).^2.*cos((2*x+1)./(x-4.3));
fplot(f,[0 4],2000)

%%
% Accordingly, the trapezoid rule is more accurate on the left half of the
% interval than on the right half.
T = [];
n_ = 50*2.^(0:3)';
for n = n_'
    T = [ T; trapezoid(f,0,2,n), trapezoid(f,2,4,n) ];
end

format short e
left_error  = integral(f,0,2,'abstol',1e-12,'reltol',1e-12) - T(:,1)
right_error = integral(f,2,4,'abstol',1e-12,'reltol',1e-12) - T(:,2)

%%
% Both the picture and the numbers suggest that more nodes should be used
% on the right half of the interval than on the left half.
