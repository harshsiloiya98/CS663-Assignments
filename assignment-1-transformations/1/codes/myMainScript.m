%% MyMainScript
tic;

% This script generates result for Q1.
% There is an interval of 10s between image generation for each subpart.

%% PART (a)

imgPath = '..\data\circles_concentric.png';
img = imread(imgPath);
% displays the original image
figure('Name', '(a) Original image'), imshow(img);
colorbar;
axis image;
axis on;
d1 = 2;
d2 = 3;
% displays shrunken images
figure('Name', '(a) Image with shrink factor = 2'), myShrinkImageByFactorD(img, d1);
figure('Name', '(a) Image with shrink factor = 3'), myShrinkImageByFactorD(img, d2);

%%
pause(10);

%% PART (b)

imgPath = '..\data\barbaraSmall.png';
img = imread(imgPath);
% displays the original image
figure('Name', '(b) Original image'), imshow(img);
colorbar;
axis image;
axis on;
% displays the enlarged image
figure('Name', '(b) Image enlarged using bilinear interpolation'), myBilinearInterpolation(img);

%%
pause(10);

%% PART (c)

% displays the original image
figure('Name', '(c) Original image'), imshow(img);
colorbar;
axis image;
axis on;
% displays the enlarged image
figure('Name', '(c) Image enlarged using nearest neighbour'), myNearestNeighbourInterpolation(img);

toc;