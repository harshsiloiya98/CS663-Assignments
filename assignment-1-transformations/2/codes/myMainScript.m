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


%% Part (a)

% original image
imshow(image7);
colorbar;
axis image;
axis on;

% binary mask
binaryMask = myForegroundMask(image7);
figure, imshow(binaryMask);
colorbar;
axis image;
axis on;

% masked image
binaryMask = cast(binaryMask, class(image7));
maskedImage = image7 .* binaryMask;
figure, imshow(maskedImage);
colorbar;
axis image;
axis on;

%% Part (b)

figure, imshow(image1);
colorbar;
axis image;
axis on;
figure, imshow(myLinearContrastStretching(image1));
colorbar;
axis image;
axis on;


figure, imshow(image2);
colorbar;
axis image;
axis on;
figure, imshow(myLinearContrastStretching(image2));
colorbar;
axis image;
axis on;


figure, imshow(image3);
colorbar;
axis image;
axis on;
figure, imshow(myLinearContrastStretching(image3));
colorbar;
axis image;
axis on;


figure, imshow(image5);
colorbar;
axis image;
axis on;
figure, imshow(myLinearContrastStretching(image5));
colorbar;
axis image;
axis on;


figure, imshow(image6);
colorbar;
axis image;
axis on;
figure, imshow(myLinearContrastStretching(image6));
colorbar;
axis image;
axis on;

%% Part (c)

% Image 1
imshow(image1);
colorbar;
axis image;
axis on;
figure, imshow(myHE(image1));
colorbar;
axis image;
axis on;

% Image 2
figure, imshow(image2);
colorbar;
axis image;
axis on;
figure, imshow(myHE(image2));
colorbar;
axis image;
axis on;

%Image 3
figure, imshow(image3);
colorbar;
axis image;
axis on;
figure, imshow(myHE(image3));
colorbar;
axis image;
axis on;

% Image 5
figure, imshow(image5);
colorbar;
axis image;
axis on;
figure, imshow(myHE(image5));
colorbar;
axis image;
axis on;

% Image 6
figure, imshow(image6);
colorbar;
axis image;
axis on;
figure, imshow(myHE(image6));
colorbar;
axis image;
axis on;

%% Part (d)

% masking the original images
mask = cast(image4Mask, class(image4));
ref_mask = cast(image4RefMask, class(image4Ref));
maskedImage1 = image4 .* mask;
maskedImage2 = image4Ref .* ref_mask;

figure, imshow(maskedImage1);
colorbar;
axis image;
axis on;
figure, imshow(myHM(maskedImage1, maskedImage2));
colorbar;
axis image;
axis on;

%% Part (e)

% Image 1
figure, imshow(image1);
colorbar;
axis image;
axis on;
figure, imshow(myCLAHE(image1, 200, 0.01));
colorbar;
axis image;
axis on;

% Image 2
figure, imshow(image2);
colorbar;
axis image;
axis on;
figure, imshow(myCLAHE(image2, 200, 0.01));
colorbar;
axis image;
axis on;

%Image 3
figure, imshow(image3);
colorbar;
axis image;
axis on;
figure, imshow(myCLAHE(image3, 200, 0.01));
colorbar;
axis image;
axis on;

% Image 6
figure, imshow(image6);
colorbar;
axis image;
axis on;
figure, imshow(myCLAHE(image6, 200, 0.01));
colorbar;
axis image;
axis on;

toc;