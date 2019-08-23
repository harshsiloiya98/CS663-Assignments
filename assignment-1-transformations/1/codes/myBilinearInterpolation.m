function [] = myBilinearInterpolation(img)
% Uses bilinear interpolation for image resizing
% References 
%    - https://ia802707.us.archive.org/23/items/Lectures_on_Image_Processing/EECE_4353_15_Resampling.pdf
%    - https://stackoverflow.com/questions/26142288/resize-an-image-with-bilinear-interpolation-without-imresize

[r, c] = size(img);

% Initializing new row and column values
new_r = 3 * r - 2;
new_c = 2 * c - 1;

% scale factors which are used to calculate areas of the 4 regions around
% the interpolated pixel
row_ratio = r / new_r;
col_ratio = c / new_c;

% created a matrix of row and column indexes to avoid two for loops
[cf, rf] = meshgrid(1:new_c, 1:new_r);

rf = floor(rf * row_ratio);
cf = floor(cf * col_ratio);
r0 = floor(rf);
c0 = floor(cf);

% this element replacement ensures that the pixel indexes are in the range
% (1, r-1) or (1, c-1) so that while interpolating, the pixel index does
% not go out of range
r0(r0 < 1) = 1;
c0(c0 < 1) = 1;
r0(r0 > r - 1) = r - 1;
c0(c0 > c - 1) = c - 1;

del_r = rf - r0;
del_c = cf - c0;

% getting the column-major indices of the pixels in the original image
% 4 sets for 4-neighbour areas around the interpolated pixel
index1 = sub2ind([r, c], r0, c0);
index2 = sub2ind([r, c], r0 + 1, c0);
index3 = sub2ind([r, c], r0, c0 + 1);
index4 = sub2ind([r, c], r0 + 1, c0 + 1);

% need to convert image to double for multiplication
temp = double(img);

% multiplying the pixel intensities with the areas of the opposite
% rectangles
temp = temp(index1).*(1 - del_r).*(1 - del_c) + temp(index2).*(del_r).*(1 - del_c) + temp(index3).*(1 - del_r).*(del_c) + temp(index4).*(del_r).*(del_c);

% converting the double matrix back to image
newImg = cast(temp, class(img));

imshow(newImg);
colorbar;
axis image;
axis on;
end