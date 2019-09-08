%% MyMainScript

%% NOTE: For the original image, it takes ~2 hours to generate a segmented image. For faster results, uncomment the imresize line and set the rows and columns as per your choice.

tic;

image = imread("../data/flower.png");

% uncomment the line below for scaled down image segmentation
% image = imresize(image, [64 64]);

%% Optimal parameters

% spatial bandwidth
h_spatial = 32;

% color bandwidth
h_color = 16;

% number of iterations
num_iterations = 10;

%% Image segmentation using Mean Shift Algorithm

out = myMeanShiftSegmentation(image, h_spatial, h_color, num_iterations);
out = uint8(out);

%% Displaying the images

figure('Name', 'Mean Shift Segmentation on flower.png');
subplot(1, 2, 1), imshow(image), colorbar, title('Original Image');
subplot(1, 2, 2), imshow(out), colorbar, title('Segmented Image');

%%
toc;