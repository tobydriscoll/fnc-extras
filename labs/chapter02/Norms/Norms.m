
%% 1. Points on the unit 2-norm circle
%*** Define theta as 200 values from 0 to 2*pi
%*** Define x_j = cos(theta_j), y_j = sin(theta_j) (no loops)

clf, plot(x,y,'o')
axis equal
title('Points on the unit circle (2 norm)')
xlabel('x'), ylabel('y')

%% 2. Map points by matrix A 
A = magic(2);
clf    % clear figure
normu = zeros(size(x));
for j = 1:length(x)
    %*** Let v be the vector [x_j y_j]^T.
    %*** Let u = Av.
    plot(u(1),u(2),'ko')
    hold on
    normu(j) = norm(u);
end
    
axis equal
title('Points after mapping by A')
xlabel('x'), ylabel('y')

%% 3. Plot ||Av||_2 as function of theta
clf

%*** Make the plot.

title('2-Norm of mapped points')
xlabel('\theta'), ylabel('||Av||')

%% 4. Estimate ||A||_2 from data
format long
estimate = 
actual = 

%% 5. Points on the unit inf-norm circle
s = linspace(-1,1,100)';
t = ones(100,1);
x = [ s; t; -s; -t ];
y = [ t; -s; -t; s ];

%*** Make labeled plot of x and y points.

%% 6. Map points by matrix A 

%*** Repeat step 2, with infinity norm.

%% 7. Plot ||Av||_inf 

%*** Make a plot like step 3.

%% 8. Estimate ||A||_inf from data

%*** Repeat step 4 with infinity norm.

