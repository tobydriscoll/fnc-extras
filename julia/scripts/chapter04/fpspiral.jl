
f = x -> x^2 - 4*x + 3.5
using Polynomials
@show r = roots(Poly([3.5,-4,1]));

g = x -> x - f(x)
using Plots
plot([g,x->x],2,3,label=["\$y=g(x)\$","\$y=x\$"],aspect_ratio=1,linewidth=2,
    title="Finding a fixed point",legend=:bottomright)

x = 2.1;  y = g(x)

plot!([x,y],[y,y],label="",arrow=true)

x = y;  y = g(x)
plot!([x,x],[x,y],label="",arrow=true)

for k = 1:5
    plot!([x,y],[y,y],label="");  x = y;    # y --> new x
    y = g(x);  plot!([x,x],[x,y],label="")  # g(x) --> new y
end
plot!([],[],label="")

abs(y-r[1])/r[1]

plot([g,x->x],1,2,label=["\$y=g(x)\$","\$y=x\$"],aspect_ratio=1,linewidth=2,
    title="No convergence",legend=:bottomright)
x = 1.3; y = g(x);
for k = 1:5
    plot!([x,y],[y,y],label="",arrow=true);  x = y;    # y --> new x
    y = g(x);  plot!([x,x],[x,y],label="",arrow=true)  # g(x) --> new y
end
plot!([],[],label="")
