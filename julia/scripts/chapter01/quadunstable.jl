
a = 1;  b = -(1e6+1e-6);  c = 1;

x1 = (-b + sqrt(b^2-4*a*c)) / (2*a)

x2 = (-b - sqrt(b^2-4*a*c)) / (2*a)

-log(10, abs(1e-6-x2)/1e-6 )
