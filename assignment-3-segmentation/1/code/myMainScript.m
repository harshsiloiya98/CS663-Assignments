%% MyMainScript
tic;

%% Your code here
clc;
clear;


image = load('../data/boat.mat');
image = mat2gray(image.imageOrig);


[Dx, Dy, eigen1, eigen2, cornerness] = myHarrisCornerDetector(image, 0.9, 25, 0.9, 0.15);

figure('Name', 'Derivative along X'), imshow(Dx), title('Derivative along X'), colorbar;
pause(1);
figure('Name', 'Derivative along Y'), imshow(Dy), title('Derivative along Y'), colorbar;
pause(1);
figure('Name', 'Eigenvalue 1'), imshow(eigen1), title('Eigenvalue 1'), colorbar;
pause(1);
figure('Name', 'Eigenvalue 2'), imshow(eigen2), title('Eigenvalue 2'), colorbar;
pause(1);
figure('Name', 'Harris corner-ness measure'), imshow(mat2gray(cornerness)), title('Harris corner-ness measure'), colorbar;

%% Parameters
% 
% * Gaussian Smoothing Factor for Image = 0.9
% * Gaussian Patch Size = 25
% * Gaussian Patch STD = 0.9
% * k-value = 0.15
% 



%%
toc;
