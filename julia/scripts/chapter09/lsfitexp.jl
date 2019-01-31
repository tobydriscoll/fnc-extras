
t = range(-1,stop=1,length=40)
y = exp.(t)

using Plots
plot(t,y,m=(3,:o),label="function")

V = [ ti^j for ti in t, j=0:1 ]
c = V\y
plot!(t->c[1]+c[2]*t,-1,1,label="fit",
    xaxis=("x"),yaxis=("value"),title="Least squares fit of exp(x)",leg=:bottomright)

t = range(-1,stop=1,length=200)
y = exp.(t)

plot(t,y,m=(2,:o),label="function")

V = [ ti^j for ti in t, j=0:1 ]
c = V\y
plot!(t->c[1]+c[2]*t,-1,1,label="fit",
    xaxis=("x"),yaxis=("value"),title="Least squares fit of exp(x)",leg=:bottomright)

t = range(-1,stop=1,length=1000)
y = exp.(t)

plot(t,y,m=(1,:o),label="function")

V = [ ti^j for ti in t, j=0:1 ]
c = V\y
plot!(t->c[1]+c[2]*t,-1,1,label="fit",
    xaxis=("x"),yaxis=("value"),title="Least squares fit of exp(x)",leg=:bottomright)
