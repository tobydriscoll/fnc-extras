%% 1. Viewing blur & deblur matrices
%*** Let V be a blur matrix of size 100

subplot(1,2,1)
imagesc(V)
axis equal, colormap(gray(256))
title('V')
colorbar

subplot(1,2,2)
imagesc(inv(V))
axis equal, colormap(gray(256))
title('V^{-1}')
colorbar

%% 2. Equivalent matrices that look different
%*** Imitate step 1 to plot (V^{-1})^6 and (V^6)^{-1}

%% 3. Import your image as the variable X. 

X = imread('Bugs013.jpg');  %*** change to your file's name
X = double(rgb2gray(X));
[m,n] = size(X);

%% 4. Blur once
subplot(1,2,1)
image(X)
axis equal, colormap(gray(256))
title('original')

%*** Let Z be the result of blurring once in each direction

subplot(1,2,2)
image(Z)
axis equal, colormap(gray(256))
title('blurred once')

%% 5. Deblur
%*** Let Y be the result of deblurring Z

subplot(1,2,2)
image(Y)
axis equal, colormap(gray(256))
title('deblurred')

%% 6. Blur/deblur 6 times
%*** Let Z be the result of blurring 6 times in each direction

subplot(1,2,1)
image(Z)
axis equal, colormap(gray(256))
title('blurred 6x')

%*** Let Y be the result of deblurring Z

subplot(1,2,2)
image(Y)
axis equal, colormap(gray(256))
title('deblurred 6x')