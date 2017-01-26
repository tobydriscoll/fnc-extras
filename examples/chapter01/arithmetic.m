%%
% The value $1+\macheps/2$ is $1+\epsilon$ for $|\epsilon|\le
% \macheps/2$, so according to our rules it is equivalent to the number
% 1. Thus the following difference is zero despite its appearance. 
( 1 + eps/2 ) - 1

%%
% However, $-(1-\macheps/2)$ is a double precision number, so it is
% represented exactly:
1 + ( eps/2 - 1 )

%%
% This is now the correct result. But we have found a rather shocking
% breakdown of the associative law of addition!