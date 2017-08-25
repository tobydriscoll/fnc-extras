%%
%% 1. Load a picture of the eye.
X = imread('myeye.jpg');  %*** use your file name
image(X)
axis equal

%% 2. Click along the top boundary (right to left).
[xup,yup] = ginput(10);

%% 3. Click along the bottom boundary (left to right).
[xlo,ylo] = ginput(10);

%% 4. Combine upper and lower points.

%*** Stack points into vectors x and y

hold on
plot(x,y,'o')
title('Selected points')

%% 5. Create matrix A.

%*** Define column vector t (length 20).
%*** Define 20x7 matrix A.

%% 6. Solve the least squares problems.

%*** Solve min ||A*b-x|| using backslash
%*** Solve min ||A*c-y|| using backslash

%% 7. Evaluate and plot

tt = linspace(0,1,500)';
%*** Evaluate (2) at tt using the found b, to get xx.
%*** Evaluate (3) at tt using the found c, to get yy.

plot(xx,yy,'linewidth',3)
title('Least squares fit')
