%% MyMainScript

tic;
%% Your code here
clear;
clc;


%% Barbara
image1 = load('../data/barbara.mat');
image1 = mat2gray(image1.imageOrig);

% Scale
image1 = imgaussfilt(image1,0.66);
image1 = image1(1:2:end,1:2:end);

% Corrupt
corruptImage1 = image1 + randn(size(image1)) .* 0.05;

% Filter
filteredImage1 = myPatchBasedFiltering(corruptImage1, 25, 9, 0.5);

% Display
figure('Name', 'Patch-Based Filtering on Image 1');
subplot(1,3,1), imshow(image1), colorbar, title('Original Image');
subplot(1,3,2), imshow(corruptImage1), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filteredImage1), colorbar, title('Filtered Image');

%RSMD
rsmd1 = myRSMD(filteredImage1, image1);



%% Grass

image2 = imread('../data/grass.png');
image2 = mat2gray(image2);

% Scale
% image2 = imgaussfilt(image2,0.66);
% image2 = image2(1:2:end,1:2:end);

% Corrupt
corruptImage2 = image2 + randn(size(image2)) .* 0.05;

% Filter
filteredImage2 = myPatchBasedFiltering(corruptImage2, 25, 9, 0.5);

% Display
figure('Name', 'Patch-Based Filtering on Image 2');
subplot(1,3,1), imshow(image2), colorbar, title('Original Image');
subplot(1,3,2), imshow(corruptImage2), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filteredImage2), colorbar, title('Filtered Image');

%RSMD
rsmd2 = myRSMD(filteredImage2, image2);
    

%% HoneyComb

image3 = imread('../data/honeyCombReal.png');
image3 = mat2gray(image3);

% Scale
% image3 = imgaussfilt(image3,0.66);
% image3 = image3(1:2:end,1:2:end);

% Corrupt
corruptImage3 = image3 + randn(size(image3)) .* 0.05;

% Filter
filteredImage3 = myPatchBasedFiltering(corruptImage3, 25, 9, 0.5);

% Display
figure('Name', 'Patch-Based Filtering on Image 3');
subplot(1,3,1), imshow(image3), colorbar, title('Original Image');
subplot(1,3,2), imshow(corruptImage3), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filteredImage3), colorbar, title('Filtered Image');

%RSMD
rsmd3 = myRSMD(filteredImage3, image3);

 
%% Display mask used to make patches isotropic

mask = ones(25,25);
rCenter = 13;
cCenter = 13;
for r=1:25
    for c=1:25
        mask(r,c) = mask(r,c) * exp(-((rCenter-r)^2+(cCenter-c)^2)/100);
    end
end
figure('Name', 'Mask');
imshow(mask);



%%

toc;

function rsmd = myRSMD(image1, image2)
    rsmd = image1(:) - image2(:);
    rsmd = rsmd .^ 2;
    rsmd = sum(rsmd);
    rsmd = rsmd / size(image1(:),1);
    rsmd = sqrt(rsmd);
end

