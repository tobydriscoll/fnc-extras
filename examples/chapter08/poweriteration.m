A= [ 6 3 3; 1 10 1; 2 5 5];
[V,D] = eig(A);
x = [2;-1;2]+1e-8;
for n = 1:100
    y = A*x;
    [~,m] = max(abs(y));
    gamma(n) = y(m)/x(m);
    x = y/y(m);
end
semilogy(abs(gamma-6))
hold on, semilogy(abs(gamma-12))