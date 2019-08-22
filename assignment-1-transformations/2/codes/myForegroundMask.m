function mask = myForegroundMask(img)
% generates the binary mask for image

[r, c] = size(img);
mask = zeros(r, c);
threshold_intensity = 15;

% filters out the intensities which are lower than 15
mask(img > threshold_intensity) = 1;

end