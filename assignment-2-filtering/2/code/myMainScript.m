%% MyMainScript

image1 = load("..\data\barbara.mat");
image1 = mat2gray(image1.imageOrig);
image2 = imread("..\data\grass.png");
image2 = mat2gray(image2);
image3 = imread("..\data\honeyCombReal.png");
image3 = mat2gray(image3);

%% corrupting images using Gaussian noise

noisy_image1 = image1 + randn(size(image1)) .* 0.05;
noisy_image2 = image2 + randn(size(image2)) .* 0.05;
noisy_image3 = image3 + randn(size(image3)) .* 0.05;

%% perform bilateral filtering over corrupted images

optimal_sigma_space_kernel = 0.5;
optimal_sigma_range_kernel = 100;

% image1
filtered_image1 = myBilateralFiltering(noisy_image1, optimal_sigma_space_kernel, optimal_sigma_range_kernel);
figure('Name', 'Bilateral Filtering on Image 1');
subplot(1,3,1), imshow(image1), colorbar, title('Original Image');
subplot(1,3,2), imshow(noisy_image1), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filtered_image1), colorbar, title('Filtered Image');

% image2
filtered_image2 = myBilateralFiltering(noisy_image2, optimal_sigma_space_kernel, optimal_sigma_range_kernel);
figure('Name', 'Bilateral Filtering on Image 2');
subplot(1,3,1), imshow(image2), colorbar, title('Original Image');
subplot(1,3,2), imshow(noisy_image2), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filtered_image2), colorbar, title('Filtered Image');

% image3
filtered_image3 = myBilateralFiltering(noisy_image3, optimal_sigma_space_kernel, optimal_sigma_range_kernel);
figure('Name', 'Bilateral Filtering on Image 3');
subplot(1,3,1), imshow(image3), colorbar, title('Original Image');
subplot(1,3,2), imshow(noisy_image3), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filtered_image3), colorbar, title('Filtered Image');

%% find the RMSD

% image1
num_pixels = size(image1, 1) * size(image1, 2);
rmsd_image1 = sqrt(sum((image1(:) - filtered_image1(:)).^2) / num_pixels);
fprintf("RMSD for image 1 = %f\n", rmsd_image1);

% image2
num_pixels = size(image2, 1) * size(image2, 2);
rmsd_image2 = sqrt(sum((image2(:) - filtered_image2(:)).^2) / num_pixels);
fprintf("RMSD for image 2 = %f\n", rmsd_image2);

% image3
num_pixels = size(image3, 1) * size(image3, 2);
rmsd_image3 = sqrt(sum((image3(:) - filtered_image3(:)).^2) / num_pixels);
fprintf("RMSD for image 3 = %f\n", rmsd_image3);

%% Mask for spatial Gaussian

%% RMSD for different values of the parameter

% 0.9*sigma_space, sigma_intensity

% 1.1*sigma_space, sigma_intensity

% sigma_space, 0.9*sigma_intensity

% sigma_space, 1.1*sigma_intensity