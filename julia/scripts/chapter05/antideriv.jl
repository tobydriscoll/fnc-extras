
I = exp(1)-1

using QuadGK
Q,errest = quadgk(x->exp(x),0,1)
@show Q;

Q,errest = quadgk(x->exp(sin(x)),0,1)
@show Q;

using Plots
plot([exp,x->exp(sin(x))],0,1,fill=0,leg=:none,
    ylabel=["exp(x)" "exp(sin(x))"],ylim=[0,2.7],layout=(2,1))
