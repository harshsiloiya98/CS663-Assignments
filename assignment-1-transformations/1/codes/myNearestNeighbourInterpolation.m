function [] = myNearestNeighbourInterpolation(img)
% Uses nearest-neighbour interpolation for image resizing
% Reference - https://ia802707.us.archive.org/23/items/Lectures_on_Image_Processing/EECE_4353_15_Resampling.pdf

[r, c] = size(img);

% Initializing new row and column values
new_r = 3 * r - 2;
new_c = 2 * c - 1;

% scale factors which are used to calculate areas of the 4 regions around
% the interpolated pixel
row_ratio = r / new_r;
col_ratio = c / new_c;

% these represent the new pixel indexes to be sampled from the original
% image (some pixel values will be repeated if new image is larger)
rf = (1:new_r) * row_ratio;
cf = (1:new_c) * col_ratio;

% this generates nearest neighbours of the float values depending on the
% new image size
if (row_ratio > 1)
    rf = floor(rf);
else
    rf = ceil(rf);
end
if (col_ratio > 1)
    cf = floor(cf);
else
    cf = ceil(cf);
end

% this element replacement ensures that the pixel indexes are in the range
% (1, r) or (1, c) so that while interpolating, the pixel index does
% not go out of range
rf(rf < 1) = 1;
cf(cf < 1) = 1;
rf(rf > r) = r;
cf(cf > c) = c;

% we repeat (or skip, if new image size is lesser) more pixels from the
% original image to the new image based on the distance
newImg = img(rf, cf);

imshow(newImg);
axis image;
axis on;
end