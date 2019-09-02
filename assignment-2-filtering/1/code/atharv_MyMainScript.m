%% MyMainScript
tic;

% This script generates result for Q1.
% There is an interval of 10s between image generation for each subpart.

%% PART (a)
% displays the original image
image1 = imread('bird.jpg');
image2 = imread('flower.jpg');
% figure('Name', '(a) Original image'), imshow(image1);
% figure('Name', '(a) Original image'), imshow(image2);
% function [x,y,z]=abc(kjfn,sdf)
grayscale_image1 = rgb2gray(image1);
grayscale_image2 = rgb2gray(image2); 

sobelX = [-1 0 1; -2 0 2; -1 0 1];
sobelY = [ 1 2 1; 0 0 0;-1 -2 -1];

% figure('Name', 'RGB2Gray image'), imshow(I);

% Applying Sobel Operator
%image1
convX_image1 = conv2(grayscale_image1, sobelX, 'same');
convY_image1 = conv2(grayscale_image1, sobelY, 'same');
conv_image1 = sqrt(convX_image1.^2+convY_image1.^2);
conv_image1 = (conv_image1*255)/ (max(conv_image1(:)));

%image2
convX_image2 = conv2(grayscale_image2, sobelX, 'same');
convY_image2 = conv2(grayscale_image2, sobelY, 'same');
conv_image2 = sqrt(convX_image2.^2+convY_image2.^2);
conv_image2 = (conv_image2*255)/ (max(conv_image2(:)));

% max(ans(:))
figure('Name', ' Convolved image'); imshow(uint8(conv_image1));
% figure('Name', ' Convolved image'); imshow(uint8(conv_image2));

imfill_image1 = imfill(conv_image1, 'holes');
imfill_image2 = imfill(conv_image2, 'holes');
% figure('Name', ' imfill image'); imshow(uint8(imfill_image1));

%for IMAGE1
c=imfill_image1>49;
mask_image1=c*255;
mask_image1(1:30,850:910) = 0;
mask_image1(120:150,1075:1100) = 0;
mask_image1(315:350,260:345) = 0;
mask_image1(400:420,160:220) = 0;
mask_image1(585:615,740:755) = 255;
% blackening the borders
mask_image1(:,1000:end)=0;
mask_image1(:,1:10)=0;
mask_image1(720:end,:)=0;
mask_image1(1:10,:)=0;
%answer for part 1 (a)
figure('Name', ' Mask Image'); imshow(uint8(mask_image1)); 

%for IMAGE2
c1=imfill_image2>29;
mask_image2=c1*255;

d_threshold_image1 = 40;
d_threshold_image2 = 20;


ANS_image1 = mySpatiallyVaryingKernel(image1,mask_image1,d_threshold_image1);
% ANS_image2 = mySpatiallyVaryingKernel(image2,mask_image2,d_threshold_image2);
% figure('Name', ' distance image'); imshow(uint8(ANS_image1));
colorbar;
axis image;
axis on;
% pause(10);