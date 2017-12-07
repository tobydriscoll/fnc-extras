%%
% Recall the grade school rational approximation to the
% number $\pi$.
p = 22/7

%%
% Note that not all of the digits displayed for $p$ are the same as for
% $\pi$. As an approximation, its absolute and relative accuracy are
abs_accuracy = abs(p-pi)
rel_accuracy = abs(p-pi)/pi
accurate_digits = -log10(rel_accuracy)
 