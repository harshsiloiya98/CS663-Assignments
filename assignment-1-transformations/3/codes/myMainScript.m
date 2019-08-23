%% MyMainScript
% Reference - https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=754419
tic;

img = imread('../data/testImage.png');

[r, c, channels] = size(img);
num_pixels = r * c;
finalNewImg = zeros(r, c, channels);

% NORMAL HISTOGRAM EQUALIZATION
% looping for each channel (3 in case of RGB, 1 in grayscale)
for i = 1:channels
    tmp_img = img(:, :, i);
    [counts, ~] = imhist(tmp_img);
    max_intensity = size(counts, 1) - 1;
    
    % probability distribution function for original image
    pdf = counts / num_pixels;
    
    % calculating the cumulative pdf for the image and the transformation
    % function
    cdf = cumsum(pdf);
    T = round(cdf * max_intensity);
    
    % applying the transformation function on original image
    range = 1:num_pixels;
    newImg = T(tmp_img(range) + 1);
    newImg = reshape(newImg, [r, c]);
    
    finalNewImg(:, :, i) = newImg;
end

% converting matrix to image
normalHE_img = cast(finalNewImg, class(img));

finalNewImg = zeros(r, c, channels);

% HISTOGRAM EQUALIZATION USING MEDIAN
% looping for each channel (3 in case of RGB, 1 in grayscale)
for i = 1:channels
    tmp_img = img(:, :, i);
    [counts, ~] = imhist(tmp_img);
    maxIntensity = size(counts, 1) - 1;
    
    % finding the median intensity of the image
    medianIntensity = double(median(tmp_img(:)));
    
    % probability distribution function for original image
    pdf = counts / num_pixels;
    
    % Let p1 be the left part's PDF and p2 be the right part's PDF
    % (left part - left part of the divided histogram)
    p1 = pdf(1:medianIntensity);
    p2 = pdf(medianIntensity + 1:end);
    p1_total = sum(p1);
    p1 = p1 / p1_total;
    p2 = p2 / (1 - p1_total);
    
    % calculating the cumulative pdfs for the sub-histograms and the
    % transformation functions
    cdf1 = cumsum(p1);
    cdf2 = sum(p2);
    T1 = round(cdf1 * maxIntensity);
    T2 = round(cdf2 * maxIntensity);
    
    % applying the transformation function on original image
    for range = 1:num_pixels
        if (tmp_img(range) < medianIntensity)
            newImg(range) = T1(tmp_img(range) + 1);
        else
            newImg(range) = T2;
        end
    end
    newImg = reshape(newImg, [r, c]);
    
    finalNewImg(:, :, i) = newImg;
end

% converting matrix to image
medianHE_img = cast(finalNewImg, class(img));

figure('Name', 'Original'), imshow(img);
axis image;
axis on;
figure('Name', 'Normal HE'), imshow(normalHE_img);
axis image;
axis on;
figure('Name', 'Median HE'), imshow(medianHE_img);
axis image;
axis on;
figure('Name', 'Original Histogram'), plot(imhist(img));
figure('Name', 'Normal HE Histogram'), plot(imhist(normalHE_img));
figure('Name', 'Median HE Histogram'), plot(imhist(medianHE_img));
toc;