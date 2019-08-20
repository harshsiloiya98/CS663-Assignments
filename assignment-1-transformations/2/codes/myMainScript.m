%% MyMainScript


%% Part (c)

% Image 1
imgPath1 = "..\data\barbara.png";
img1 = imread(imgPath1);
imshow(img1);
axis image;
axis on;
figure, myHE(img1);

% Image 2
imgPath2 = "..\data\TEM.png";
img2 = imread(imgPath2);
figure, imshow(img2);
axis image;
axis on;
figure, myHE(img2);

% Image 3
imgPath3 = "..\data\canyon.png";
img3 = imread(imgPath3);
figure, imshow(img3);
axis image;
axis on;
figure, myHE(img3);

% Image 5
imgPath5 = "..\data\church.png";
img5 = imread(imgPath5);
figure, imshow(img5);
axis image;
axis on;
figure, myHE(img5);

% Image 6
imgPath6 = "..\data\chestXray.png";
img6 = imread(imgPath6);
figure, imshow(img6);
axis image;
axis on;
figure, myHE(img6);