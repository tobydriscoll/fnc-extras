%%
% There is no double precision number between $1$ and $1+\macheps$. Thus
% the following difference is zero despite its appearance.
( 1 + eps/2 ) - 1

%%
% However, $-(1-\macheps/2)$ is a double precision number, so it is
% represented exactly:
1 + ( eps/2 - 1 )

%%
% This is now the ``correct'' result. But we have found a rather shocking
% breakdown of the associative law of addition!