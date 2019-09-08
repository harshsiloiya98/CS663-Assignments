function outputImg = myMeanShiftSegmentation(inputImg, h_spatial, h_color, num_iterations)
% performs mean shift segmentation on an image using a Gaussian kernel

[r, c, channels] = size(inputImg);
outputImg = zeros(r, c, channels);

% storing the spatial and color data
X = zeros(2 + channels, r * c);
for i = 1:r
    for j = 1:c
        X(1, j + c * (i - 1)) = i;
        X(2, j + c * (i - 1)) = j;
        X(3, j + c * (i - 1)) = inputImg(i, j, 1);
        X(4, j + c * (i - 1)) = inputImg(i, j, 2);
        X(5, j + c * (i - 1)) = inputImg(i, j, 3);
    end
end

for i = 1:r
    for j = 1:c
        current_pixel = X(:, j + c * (i - 1));
        new_pixel = current_pixel;
        for it = 1:num_iterations
            
            % calculating distances for spatial and color kernels
            squared_spatial_distances = sum(bsxfun(@minus, new_pixel(1:2, :), X(1:2, :)).^2);
            squared_color_distances = sum(bsxfun(@minus, new_pixel(3:5, :), X(3:5, :)).^2);
            
            nearest_pixels = knnsearch(X', new_pixel', 'K', 20, 'Distance', 'euclidean');
            
            % spatial gaussian kernel
            k1 = exp(-1 * squared_spatial_distances(nearest_pixels).^2 / (2 * h_spatial^2));
            
            % color gaussian kernel
            k2 = exp(-1 * squared_color_distances(nearest_pixels).^2 / (2 * h_color^2));
            
            % gradient of multivariate kernel
            k1 = k1 .* (sqrt(squared_spatial_distances(nearest_pixels)) / h_spatial^2);
            k2 = k2 .* (sqrt(squared_color_distances(nearest_pixels)) / h_color^2);
            K = k1 + k2;
            normalized_K = K / sum(K);
            
            new_pixel = sum(bsxfun(@times, X(:, nearest_pixels), normalized_K), 2);
        end
        for ch = 1:channels
            outputImg(i, j, ch) = new_pixel(ch, 1);
        end
    end
end
end