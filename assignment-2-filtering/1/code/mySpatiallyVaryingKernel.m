function [ outputImg ] = mySpatiallyVaryingKernel(originalImg, inputImg, threshold)
% originalImg is the given image (bird.jpg)
% inputImg = black and white image seprating foreground and background

% figure('Name', ' original image'); imshow(uint8(originalImg));
figure('Name', ' edged image'); imshow(uint8(inputImg));
radius_matrix = bwdist(inputImg,'euclidean'); %calculates distance of each pixel from nearest non-zero pixel value
% figure('Name', ' radial distance image'); imshow(uint8(radius_matrix));

radius_matrix(radius_matrix>threshold) = [threshold];
figure('Name', ' thresholded radial distance image'); imshow(uint8(radius_matrix));

[a,b,c] = size(originalImg);
for i=1:a
    for j=1:b
        for k=1:c
            r = radius_matrix(i,j); %r = d_p or d_thresh
            x=1:(2*r+1);
            y=1:(2*r+1);
            [X,Y] = meshgrid(x,y);
            X(( (X-(r+1)).^2 + (Y-(r+1)).^2 ) > 1)=0;
            X(( (X-(r+1)).^2 + (Y-(r+1)).^2 ) < 1)=1;
            X = X/sum(X);
%             print(class(originalImg));
%             print(class(X));
            outputImg = conv2(originalImg(:,:,k), X, "same");
        end
    end
end
end
% figure('Name', ' original image'); imshow(uint8(originalImg));
% figure('Name', ' output image'); imshow(uint8(outputImg));
% outputImg = originalImg;
