function [] = myShrinkImageByFactorD(img, d)
% Shrinks image by a factor 'd' along each dimension
[r, c] = size(img);
img(d:d:r, d:d:c) = NaN;
imshow(img);
axis image;
axis on;
end

