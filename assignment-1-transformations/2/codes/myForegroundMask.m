function mask = myForegroundMask(image)
    [I,J,K] = size(image);
    mask = zeros(I,J,K);
    for i=1:I
        for j=1:J
            for k=1:K
                if image(i,j,k) > 5
                    mask(i,j,k) = 1;
                else
                    mask(i,j,k) = 0;
                end
            end
        end
    end