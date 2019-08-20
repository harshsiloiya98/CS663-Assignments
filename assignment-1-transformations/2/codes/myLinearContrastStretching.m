function output = myLinearContrastStretching(image)
    image = im2double(image);
    [I,J,K] = size(image);
    output = zeros(I,J,K);
    for k=1:K
        maxvalue = max(max(image(:,:,k)));
        minvalue = min(min(image(:,:,k)));
        for i=1:I
            for j=1:J               
                output(i,j,k) = ((image(i,j,k) - minvalue)) / (maxvalue - minvalue);
            end
        end
    end
end
