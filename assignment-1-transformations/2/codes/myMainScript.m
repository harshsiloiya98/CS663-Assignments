%% MyMainScript
clc;
clear;
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

%% (a) Foreground Mask

% mask7 = myForegroundMask(image7);
% 
% figure(1), imshow(image7), title('(a) Original Image');
% 
% figure(2), imshow(mask7), title('(a) Binary Mask');
% 
% figure(3), imshow(image7.*uint8(mask7)), title('(a) Masked Image');


%% (b) Linear Contrast Stretching

% figure(4);
% imshow(image1), colorbar, title('(b) Original Image 1');
% 
% figure(5);
% imshow(myLinearContrastStretching(image1)), colorbar, title('(b) Contrast-Enhanced Image 1');
% 
% figure(6);
% imshow(image2);
% colorbar;
% title('(b) Original Image 2');
% 
% figure(7);
% imshow(myLinearContrastStretching(image2));
% colorbar;
% title('(b) Contrast-Enhanced Image 2');
% 
% figure(8);
% imshow(image3);
% colorbar;
% title('(b) Original Image 3');
% 
% figure(9);
% imshow(myLinearContrastStretching(image3));
% colorbar;
% title('(b) Contrast-Enhanced Image 3');
% 
% figure(10);
% imshow(image5);
% colorbar;
% title('(b) Original Image 5');
% 
% figure(11);
% imshow(myLinearContrastStretching(image5));
% colorbar;
% title('(b) Contrast-Enhanced Image 5');
% 
% figure(12);
% imshow(image6);
% colorbar;
% title('(b) Original Image 6');
% 
% figure(13);
% imshow(myLinearContrastStretching(image6));
% colorbar;
% title('(b) Contrast-Enhanced Image 6');
% 
% figure(14);
% imshow(image7.*uint8(mask7));
% colorbar;
% title('(b) Original Masked Image 7');
% 
% figure(15);
% imshow(myLinearContrastStretching(image7.*uint8(mask7)));
% colorbar;
% title('(b) Contrast-Enhanced Masked Image 7');




%% (c) Histogram Equalization (HE)


% figure(16), imshow(image1), colorbar, title('(c) Original Image 1');
% 
% figure(17), imshow(myHE(image1)), colorbar, title('(c) Contrast-Enhanced Image 1');



%% (d) Histogram Matching (HM)


% figure(18), imshow(image4 .* uint8(image4Mask)), colorbar, title('(d) Original Image 4');
% 
% figure(19), imshow(myHM(image4 .* uint8(image4Mask), image4Ref .* uint8(image4RefMask))), colorbar, title('(d) Contrast-Enhanced Image 4');




%% End
toc;
