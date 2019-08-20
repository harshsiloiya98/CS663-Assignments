function output = myCLAHE(image, windowSize, threshold)
    [I,J,K] = size(image);
    output = zeros(I,J,K);
    for k=1:K
        for i=1:I
            disp([num2str(k), '  ', num2str(i)])
            for j=1:J
                i1 = max(1, i - windowSize);
                i2 = min(I, i + windowSize);
                j1 = max(1, j - windowSize);
                j2 = min(J, j + windowSize);
                window = image(i1:i2,j1:j2,k);
                hist = imhist(window);
                hist = hist ./ sum(hist);
                topsum = sum(hist(hist >= threshold) - threshold);
                hist = hist .* (hist < threshold) + threshold .* (hist >= threshold);
                hist = hist + topsum/256;
                cdf = cumsum(hist);
                cdf_norm = (cdf ./ max(cdf)) .* 255;
                if i<windowSize
                    if j<windowSize
                        index = ceil(window(i-i1+1,j-j1+1));
                    else
                        index = ceil(window(i-i1+1,windowSize+1));
                    end
                else
                    if j<windowSize
                        index = ceil(window(windowSize+1,j-j1+1));
                    else
                        index = ceil(window(windowSize+1,windowSize+1));
                    end
                end
                output(i,j,k) = cdf_norm(index+1);
            end
        end
    end
    output = mat2gray(output);
end