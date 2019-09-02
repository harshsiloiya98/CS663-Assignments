function [ outputImg, radius_matrix ] = mySpatiallyVaryingKernel(originalImg, inputImg, threshold)
% originalImg is the given image (bird.jpg)
% inputImg = black and white image seprating foreground and background

% figure('Name', ' original image'); imshow(uint8(originalImg));
% figure('Name', ' edged image'); imshow(uint8(inputImg));
radius_matrix = bwdist(inputImg,'euclidean'); %calculates distance of each pixel from nearest non-zero pixel value
% figure('Name', ' radial distance image'); imshow(uint8(radius_matrix));

radius_matrix(radius_matrix>threshold) = [threshold];
% figure('Name', ' thresholded radial distance image'); imshow(uint8(radius_matrix));

[a,b,c] = size(originalImg);
% for k=1:c
%     for i=1:a
%         for j=1:b
%             r = radius_matrix(i,j); %r = d_p or d_thresh
% %             x=1:(2*r+1);
% %             y=1:(2*r+1);
% %             [X,Y] = meshgrid(x,y);
% %             X(( (X-(r+1)).^2 + (Y-(r+1)).^2 ) > r*r)=0;
% %             X(( (X-(r+1)).^2 + (Y-(r+1)).^2 ) <= r.^2)=1;
% %             X = X/sum(X);
%             kernel = fspecial('disk',double(r));
%             kernel (kernel>0) = 1;
%             kernel = kernel/sum(kernel(:));
%             temp = conv2(originalImg(:,:,k), kernel, "same");
%                         outputImg(i,j,k)=temp(i,j,k);
%         end
%     end
% end
for r=40:-1:1
    kernel = fspecial('disk',double(r));
    kernel (kernel>0) = 1;
    kernel = kernel/sum(kernel(:));
    for k=1:3
        temp(:,:,k) = conv2(originalImg(:,:,k), kernel, 'same');
    end
    for i=1:a
        for j=1:b
            if (r == radius_matrix(i,j))
                outputImg(i,j,:) = temp(i,j,:);
            end
            if (radius_matrix(i,j) == 0)
                outputImg(i,j,:) = originalImg(i,j,:);
            end
        end
    end          
end
% figure('Name', ' original image'); imshow(uint8(originalImg));
% figure('Name', ' output image'); imshow(uint8(outputImg));
% outputImg = originalImg;
