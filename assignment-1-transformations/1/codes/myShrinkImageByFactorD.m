function [] = myShrinkImageByFactorD(img, d)
% Shrinks image by a factor 'd' along each dimension
[r, c] = size(img);
newImg = img(d:d:r, d:d:c);
imshow(newImg);
axis image;
axis on;
end