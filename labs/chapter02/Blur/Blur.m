%% Blurred lines

%% 1. blurmatrix function
%*** Complete the function in blurmatrix.m. 
type blurmatrix    % this displays the code in the output of your script

%% 2. Show 7x7 B
blurmatrix(7)

%% 3. Import image
X = imread('myimage.jpg');    %*** change file name as needed
X = double(rgb2gray(X));
clf
imshow(X,[0 255])
title('Original image')

%% 4. Blur 60 times vertically

%*** Let Z be the result of blurring 60 times in the vertical direction.
title('Blurred vertically')

%% 5. Blur 60 times in both directions

%*** Let Z be the result of blurring 60 times in both directions.
title('Blurred in both directions')

