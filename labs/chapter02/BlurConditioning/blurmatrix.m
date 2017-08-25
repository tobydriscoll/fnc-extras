function B = blurmatrix(n)

z = ones(n,1);
B = diag(0.5*z) + diag(0.25*z(1:n-1),1) + diag(0.25*z(1:n-1),-1);

end