function output = myHE(image)
    [I,J,K] = size(image);
    output = zeros(I,J,K);
    for k=1:K
        hist = imhist(image(:,:,k));
        cdf = cumsum(hist);
        cdf_norm = (cdf ./ max(cdf)) .* 255;
        for i=1:I
            for j=1:J
                index = ceil(image(i,j,k)+1);
                output(i,j,k) = cdf_norm(index);
            end
        end
    end
    output = mat2gray(output);
end