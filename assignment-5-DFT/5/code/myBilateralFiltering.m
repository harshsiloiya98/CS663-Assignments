function outputImg = myBilateralFiltering(inputImg, stddev_space, stddev_range)
% performs bilateral filtering on a noisy image

[r, c] = size(inputImg);
outputImg = zeros(r, c);

% creates a window of (windowSize + 1) x (windowSize + 1) dimensions
windowSize = 6;

% for spatial kernel, magnitude of distance between center pixel and
% boundaries = (+-)windowSize, hence the kernel values are constant
% x -> x coordinate difference; y -> y coordinate difference
[x, y] = meshgrid(-windowSize:windowSize, -windowSize:windowSize);
distances_squared = x.^2 + y.^2;

% using Gaussian function as spatial kernel
spatial_kernel = (1 / sqrt(2 * pi * stddev_space^2)) * ... 
    exp(-0.5 * distances_squared / stddev_space^2);

for i = 1:r
    for j = 1:c
        currentPixel = inputImg(i, j);
        weight = 0;
        weighted_intensity = 0;
        
        % defining the window pixels' borders
        p1 = max(-windowSize, 1 - i);
        p2 = min(windowSize, r - i);
        p3 = max(-windowSize, 1 - j);
        p4 = min(windowSize, c - j);
        
        for m = p1:p2
            for n = p3:p4
                intensity_diff = inputImg(i + m, j + n) - currentPixel;
                range_kernel_value = (1 / sqrt(2 * pi * stddev_range^2)) * ...
                    exp(-0.5 * intensity_diff^2 / stddev_range^2);
                spatial_kernel_value = spatial_kernel(m + windowSize + 1, n + windowSize + 1);
                weighted_intensity = weighted_intensity + ...
                    range_kernel_value * spatial_kernel_value * inputImg(i + m, j + n);
                weight = weight + range_kernel_value * spatial_kernel_value;
            end
        end
        
        outputImg(i, j) = weighted_intensity / weight;
    end
end
end