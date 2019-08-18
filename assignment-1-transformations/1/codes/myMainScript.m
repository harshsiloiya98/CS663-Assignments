%% MyMainScript

% This script generates result for Q1.
% There is an interval of 10s between image generation for each subpart.

%% PART (a)

imgPath = "..\data\circles_concentric.png";
img = imread(imgPath);
% displays the original image
imshow(img);
axis image;
axis on;
d1 = 2;
d2 = 3;
% displays shrunken images
figure, myShrinkImageByFactorD(img, d1);
figure, myShrinkImageByFactorD(img, d2);

%%
pause(10);

%% PART (b)

imgPath = "..\data\barbaraSmall.png";
img = imread(imgPath);
% displays the original image
imshow(img);
axis image;
axis on;
% displays the enlarged image
figure, myBilinearInterpolation(img);

%%
pause(10);

%% PART (c)

figure, myNearestNeighbourInterpolation(img);