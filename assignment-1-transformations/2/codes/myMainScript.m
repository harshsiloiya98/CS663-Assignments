%% MyMainScript
tic;

image1 = imread('../data/barbara.png');
image2 = imread('../data/TEM.png');
image3 = imread('../data/canyon.png');
image4 = imread('../data/retina.png');
image5 = imread('../data/church.png');
image6 = imread('../data/chestXray.png');
image7 = imread('../data/statue.png');

image4Ref = imread('../data/retinaRef.png');
image4Mask = imread('../data/retinaMask.png');
image4RefMask = imread('../data/retinaRefMask.png');


%% Part (a) Foreground Mask

% original image
figure('Name', '(a) Original Image 7'), imshow(image7);
colorbar;
axis image;
axis on;

% binary mask
binaryMask = myForegroundMask(image7);
figure('Name', '(a) Binary Mask for Image 7'), imshow(binaryMask);
colorbar;
axis image;
axis on;

% masked image
binaryMask = cast(binaryMask, class(image7));
maskedImage = image7 .* binaryMask;
figure('Name', '(a) Masked Image 7'), imshow(maskedImage);
colorbar;
axis image;
axis on;




%% Part (b) Linear Contrast Stretching

figure('Name', '(b) Original Image 1'), imshow(image1);
colorbar;
axis image;
axis on;
figure('Name', '(b) Linear Contrast Stretched Image 1'), imshow(myLinearContrastStretching(image1));
colorbar;
axis image;
axis on;


figure('Name', '(b) Original Image 2'), imshow(image2);
colorbar;
axis image;
axis on;
figure('Name', '(b) Linear Contrast Stretched Image 2'), imshow(myLinearContrastStretching(image2));
colorbar;
axis image;
axis on;


figure('Name', '(b) Original Image 3'), imshow(image3);
colorbar;
axis image;
axis on;
figure('Name', '(b) Linear Contrast Stretched Image 3'), imshow(myLinearContrastStretching(image3));
colorbar;
axis image;
axis on;


figure('Name', '(b) Original Image 5'), imshow(image5);
colorbar;
axis image;
axis on;
figure('Name', '(b) Linear Contrast Stretched Image 5'), imshow(myLinearContrastStretching(image5));
colorbar;
axis image;
axis on;


figure('Name', '(b) Original Image 6'), imshow(image6);
colorbar;
axis image;
axis on;
figure('Name', '(b) Linear Contrast Stretched Image 6'), imshow(myLinearContrastStretching(image6));
colorbar;
axis image;
axis on;


figure('Name', '(b) Original Image 7 (Masked)'), imshow(image7 .* cast(myForegroundMask(image7), class(image7)));
colorbar;
axis image;
axis on;
figure('Name', '(b) Linear Contrast Stretched Image 7 (Masked)'), imshow(myLinearContrastStretching(image7 .* cast(myForegroundMask(image7), class(image7))));
colorbar;
axis image;
axis on;






%% Part (c) Histogram Equalization (HE)

% Image 1
figure('Name', '(c) Original Image 1'), imshow(image1);
colorbar;
axis image;
axis on;
figure('Name', '(c) Histogram Equalised Image 1'), imshow(myHE(image1));
colorbar;
axis image;
axis on;

% Image 2
figure('Name', '(c) Original Image 2'), imshow(image2);
colorbar;
axis image;
axis on;
figure('Name', '(c) Histogram Equalised Image 2'), imshow(myHE(image2));
colorbar;
axis image;
axis on;

%Image 3
figure('Name', '(c) Original Image 3'), imshow(image3);
colorbar;
axis image;
axis on;
figure('Name', '(c) Histogram Equalised Image 3'), imshow(myHE(image3));
colorbar;
axis image;
axis on;

% Image 5
figure('Name', '(c) Original Image 5'), imshow(image5);
colorbar;
axis image;
axis on;
figure('Name', '(c) Histogram Equalised Image 5'), imshow(myHE(image5));
colorbar;
axis image;
axis on;

% Image 6
figure('Name', '(c) Original Image 6'), imshow(image6);
colorbar;
axis image;
axis on;
figure('Name', '(c) Histogram Equalised Image 6'), imshow(myHE(image6));
colorbar;
axis image;
axis on;

% Image 7
figure('Name', '(c) Original Image 7 (Masked)'), imshow(image7 .* cast(myForegroundMask(image7), class(image7)));
colorbar;
axis image;
axis on;
figure('Name', '(c) Histogram Equalised Image 7 (Masked)'), imshow(myHE(image7 .* cast(myForegroundMask(image7), class(image7))));
colorbar;
axis image;
axis on;




%% Part (d) Histogram Matching (HM)

% masking the original images
mask = cast(image4Mask, class(image4));
ref_mask = cast(image4RefMask, class(image4Ref));
maskedImage4 = image4 .* mask;
maskedImage4Ref = image4Ref .* ref_mask;

figure('Name', '(d) Original Image 4 (Masked)'), imshow(maskedImage4);
colorbar;
axis image;
axis on;
figure('Name', '(d) Histogram Matched Image 4 (Masked)'), imshow(myHM(maskedImage4, maskedImage4Ref));
colorbar;
axis image;
axis on;
figure('Name', '(d) Histogram Equalised Image 4 (Masked)'), imshow(myHE(maskedImage4));
colorbar;
axis image;
axis on;




%% Part (e) Contrast-Limited Adaptive Histogram Equalization (CLAHE)

%% CLAHE on Image 1
figure('Name', '(e) Original Image 1'), imshow(image1);
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(100, 0.01) on Image 1'), imshow(myCLAHE(image1, 100, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(10, 0.01) on Image 1'), imshow(myCLAHE(image1, 10, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(1000, 0.01) on Image 1'), imshow(myCLAHE(image1, 1000, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(100, 0.005) on Image 1'), imshow(myCLAHE(image1, 100, 0.005));
colorbar;
axis image;
axis on;

%% CLAHE on Image 2
figure('Name', '(e) Original Image 2'), imshow(image2);
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(100, 0.01) on Image 2'), imshow(myCLAHE(image2, 100, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(10, 0.01) on Image 2'), imshow(myCLAHE(image2, 10, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(1000, 0.01) on Image 2'), imshow(myCLAHE(image2, 1000, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(100, 0.005) on Image 2'), imshow(myCLAHE(image2, 100, 0.005));
colorbar;
axis image;
axis on;

%% CLAHE on Image 3
% figure('Name', '(e) Original Image 3'), imshow(image3);
% colorbar;
% axis image;
% axis on;
% figure('Name', '(e) CLAHE(100, 0.01) on Image 3'), imshow(myCLAHE(image3, 100, 0.01));
% colorbar;
% axis image;
% axis on;
figure('Name', '(e) CLAHE(10, 0.01) on Image 3'), imshow(myCLAHE(image3, 10, 0.01));
colorbar;
axis image;
axis on;
% figure('Name', '(e) CLAHE(1000, 0.01) on Image 3'), imshow(myCLAHE(image3, 1000, 0.01));
% colorbar;
% axis image;
% axis on;
% figure('Name', '(e) CLAHE(100, 0.005) on Image 3'), imshow(myCLAHE(image3, 100, 0.005));
% colorbar;
% axis image;
% axis on;

%% CLAHE on Image 6
figure('Name', '(e) Original Image 6'), imshow(image6);
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(100, 0.01) on Image 6'), imshow(myCLAHE(image6, 100, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(10, 0.01) on Image 6'), imshow(myCLAHE(image6, 10, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(1000, 0.01) on Image 6'), imshow(myCLAHE(image6, 1000, 0.01));
colorbar;
axis image;
axis on;
figure('Name', '(e) CLAHE(100, 0.005) on Image 6'), imshow(myCLAHE(image6, 100, 0.005));
colorbar;
axis image;
axis on;

%%
toc;