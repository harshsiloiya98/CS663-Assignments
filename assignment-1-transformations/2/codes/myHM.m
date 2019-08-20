function output = myHM(image, ref)
    [I,J,K] = size(image);
    output = zeros(I,J,K);
    for k=1:K
        hist = imhist(image(:,:,k));
        cdf = cumsum(hist);
        cdf_norm = (cdf ./ max(cdf)) .* 255;
        
        histRef = imhist(ref(:,:,k));
        cdfRef = cumsum(histRef);
        cdf_normRef = (cdfRef ./ max(cdfRef)) .* 255;
        
        match = zeros(256);
        for i=1:256
            [~,index] = min(abs(cdf_normRef-cdf_norm(i)));
            match(i) = index;
        end
        
        for i=1:I
            for j=1:J
                index = image(i,j,k);
                output(i,j,k) = match(index+1);
            end
        end
    end
    output = mat2gray(output);
end

% https://stackoverflow.com/questions/26763974/histogram-matching-of-two-images-without-using-histeq