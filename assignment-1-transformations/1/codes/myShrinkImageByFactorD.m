function [] = myShrinkImageByFactorD(img, d)
% Shrinks image by a factor 'd' along each dimension

[r, c] = size(img);

% Samples only the d-th rows and columns from the image
newImg = img(d:d:r, d:d:c);

imshow(newImg);
axis image;
axis on;
end