%%  MyMainScript

tic;

%%  Reading the images

img1 = imread('../../barbara256.png');
img1 = double(img1);
img2 = imread('../../stream.png');
img2 = double(img2);

%%  Adding noise to the images

noisyImg1 = img1 + randn(size(img1)) * 20;
noisyImg2 = img2 + randn(size(img2)) * 20;

%%  Image denoising using PCA (complete image)

denoisedImg1 = myPCADenoising1(noisyImg1, 20);
displayImage(img1, 'Original image');
displayImage(noisyImg1, 'Noisy image');
displayImage(denoisedImg1, 'Denoised image');
rmse = norm(denoisedImg1(:) - img1(:)) / norm(img1(:));
fprintf("RMSE for barbara256.png = %f\n", rmse);

denoisedImg1 = myPCADenoising1(noisyImg2, 20);
displayImage(img2, 'Original image');
displayImage(noisyImg2, 'Noisy image');
displayImage(denoisedImg1, 'Denoised image');
rmse = norm(denoisedImg1(:) - img2(:)) / norm(img2(:));
fprintf("RMSE for stream.png = %f\n", rmse);

%%  Image denoising using PCA (nearest K = 200 patches)

denoisedImg2 = myPCADenoising2(noisyImg1, 20);
displayImage(img1, 'Original image');
displayImage(noisyImg1, 'Noisy image');
displayImage(denoisedImg2, 'Denoised image');
rmse = norm(denoisedImg2(:) - img1(:)) / norm(img1(:));
fprintf("RMSE for barbara256.png = %f\n", rmse);

denoisedImg2 = myPCADenoising2(noisyImg2, 20);
displayImage(img2, 'Original image');
displayImage(noisyImg2, 'Noisy image');
displayImage(denoisedImg2, 'Denoised image');
rmse = norm(denoisedImg2(:) - img2(:)) / norm(img2(:));
fprintf("RMSE for stream.png = %f\n", rmse);

%%  Image denoising using Bilateral Filtering

denoisedImg3 = myBilateralFiltering(noisyImg1, 20, 10);
displayImage(img1, 'Original image');
displayImage(noisyImg1, 'Noisy image');
displayImage(denoisedImg3, 'Denoised image');
rmse = norm(denoisedImg3(:) - img1(:)) / norm(img1(:));
fprintf("RMSE for barbara256.png = %f\n", rmse);

denoisedImg3 = myBilateralFiltering(noisyImg2, 20, 10);
displayImage(img2, 'Original image');
displayImage(noisyImg2, 'Noisy image');
displayImage(denoisedImg3, 'Denoised image');
rmse = norm(denoisedImg3(:) - img2(:)) / norm(img2(:));
fprintf("RMSE for stream.png = %f\n", rmse);

%%  Image denoising using Poisson distribution

noisyImg1 = poissrnd(img1);
denoisedImg4 = myPCADenoising2(sqrt(noisyImg1 + 3 / 8), 0.25);
denoisedImg4 = denoisedImg4.^2 - 3 / 8;
displayImage(img1, 'Original image');
displayImage(noisyImg1, 'Noisy image');
displayImage(denoisedImg4, 'Denoised image');
rmse = norm(denoisedImg4(:) - img1(:)) / norm(img1(:));
fprintf("RMSE for barbara256.png = %f\n", rmse);

noisyImg2 = poissrnd(img2);
denoisedImg4 = myPCADenoising2(sqrt(noisyImg2 + 3 / 8), 0.25);
denoisedImg4 = denoisedImg4.^2 - 3 / 8;
displayImage(img2, 'Original image');
displayImage(noisyImg2, 'Noisy image');
displayImage(denoisedImg4, 'Denoised image');
rmse = norm(denoisedImg4(:) - img2(:)) / norm(img2(:));
fprintf("RMSE for stream.png = %f\n", rmse);

%  for low exposure image

noisyImg1 = poissrnd(img1 / 20);
denoisedImg5 = myPCADenoising2(sqrt(noisyImg1 + 3 / 8), 0.25);
denoisedImg5 = denoisedImg5.^2 - 3 / 8;
displayImage(img1, 'Original image');
displayImage(noisyImg1, 'Noisy image');
displayImage(denoisedImg5, 'Denoised image');
rmse = norm(denoisedImg5(:) - img1(:)) / norm(img1(:));
fprintf("RMSE for barbara256.png with low exposure = %f\n", rmse);

noisyImg2 = poissrnd(img2 / 20);
denoisedImg5 = myPCADenoising2(sqrt(noisyImg2 + 3 / 8), 0.25);
denoisedImg5 = denoisedImg5.^2 - 3 / 8;
displayImage(img2, 'Original image');
displayImage(noisyImg2, 'Noisy image');
displayImage(denoisedImg5, 'Denoised image');
rmse = norm(denoisedImg5(:) - img2(:)) / norm(img2(:));
fprintf("RMSE for stream.png with low exposure = %f\n", rmse);

%% EXPLANATIONS

%  * The RMSE for PCA denoising is lesser than that of Bilateral Filtering,
%  suggesting that PCA denoising works better than Bilateral Filtering in
%  removing Gaussian noise.
%  * The difference between PCA denoising and Bilateral Filtering is that
%  Bilateral filtering takes the weighted average of nearby pixels having
%  similar value whereas PCA-based denoising is actually averaging pixels
%  having similar texture by taking patches and comparing them (patch-based
%  filtering). The concept of PCA is used to reduce the dimensionality of
%  the patch difference vector (computation time increases if the
%  dimensionality is increased).
%  * A low exposure image with Poisson noise is denoised ineffectively than
%  a high exposure image with Poisson noise.
%  * If the intensity values are clamped in the range [0, 255] and then
%  denoised, then the noise, which was previously uniform Gaussian, is no
%  longer uniform due to values being clamped and since PCA denoising uses
%  a Wiener-like update of the eigencoefficients which relies on the
%  statistical properties of noise as well (independent of the image
%  intensities), the denoising is not as efficient as that with uniform
%  Gaussian noise.