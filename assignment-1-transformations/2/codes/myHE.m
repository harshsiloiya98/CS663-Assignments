function finalNewImg = myHE(img)
% Performs histogram equalization of image

    [r, c, channels] = size(img);
    num_pixels = r * c;
    finalNewImg = zeros(r, c, channels);

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
    finalNewImg = cast(finalNewImg, class(img));

end