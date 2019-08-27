function outputImg = myBilateralFiltering(inputImg, stddev_space, stddev_range)
% performs bilateral filtering on a noisy image

[r, c] = size(inputImg);
outputImg = zeros(r, c);

% creates a window of (windowSize + 1) x (windowSize + 1) dimensions
windowSize = 9;

% for spatial kernel, magnitude of distance between center pixel and
% boundaries = (+-)windowSize, hence the kernel values are constant
% x -> x coordinate difference; y -> y coordinate difference
[x, y] = meshgrid(-windowSize:windowSize, -windowSize:windowSize);
distances_squared = x.^2 + y.^2;

% using Gaussian function as spatial kernel
spatial_kernel = (1 / sqrt(2 * pi * stddev_space^2)) * ... 
    exp(-1 * distances_squared / (2 * stddev_space^2));

for i = 1:r
    for j = 1:c
        currentPixel = inputImg(i, j);
        
        % defining the window pixels' borders
        p1 = max(i - windowSize, 1);
        p2 = min(i + windowSize, r);
        p3 = max(j - windowSize, 1);
        p4 = min(j + windowSize, c);
        window = inputImg(p1:p2, p3:p4);
        
        % using Gaussian function as range kernel
        range_kernel = (1 / sqrt(2 * pi * stddev_range^2)) * ... 
            exp(-1 * (window - currentPixel).^2 / (2 * stddev_range^2));
        
        % taking values from the spatial kernel in the particular window
        row_range = p1:p2;
        col_range = p3:p4;
        tmp_spatial_kernel = spatial_kernel((row_range - i + windowSize + 1), (col_range - j + windowSize + 1));
        
        % normalization term
        Wp = range_kernel .* tmp_spatial_kernel;
        
        outputImg(i, j) = sum(Wp(:) .* currentPixel(:)) / sum(Wp(:));
    end
end
end