%% MyMainScript

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
axis image;
axis on;

% binary mask
binaryMask = myForegroundMask(image7);
figure, imshow(binaryMask);
axis image;
axis on;

% masked image
binaryMask = cast(binaryMask, class(image7));
maskedImage = image7 .* binaryMask;
figure, imshow(maskedImage);
axis image;
axis on;

%% Part (b)

imshow(image1);
axis image;
axis on;
figure, myLinearContrastStretching(image1);


figure, imshow(image2);
axis image;
axis on;
figure, myLinearContrastStretching(image2);


figure, imshow(image3);
axis image;
axis on;
figure, myLinearContrastStretching(image3);


figure, imshow(image5);
axis image;
axis on;
figure, myLinearContrastStretching(image5);


figure, imshow(image6);
axis image;
axis on;
figure, myLinearContrastStretching(image6);

%% Part (c)

% Image 1
imshow(image1);
axis image;
axis on;
figure, myHE(image1);

% Image 2
figure, imshow(image2);
axis image;
axis on;
figure, myHE(image2);

%Image 3
figure, imshow(image3);
axis image;
axis on;
figure, myHE(image3);

% Image 5
figure, imshow(image5);
axis image;
axis on;
figure, myHE(image5);

% Image 6
figure, imshow(image6);
axis image;
axis on;
figure, myHE(image6);

%% Part (d)

% masking the original images
mask = cast(image4Mask, class(image4));
ref_mask = cast(image4RefMask, class(image4Ref));
maskedImage1 = image4 .* mask;
maskedImage2 = image4Ref .* ref_mask;

imshow(maskedImage1);
axis image;
axis on;
figure, myHM(maskedImage1, maskedImage2);