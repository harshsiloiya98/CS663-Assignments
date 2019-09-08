function [Dx, Dy, eigen1, eigen2, cornerness] = myHarrisCornerDetector(image, smoothingFactor, patchSize, patchStd, k)
    
    image = imgaussfilt(image, smoothingFactor);
    [X, Y] = size(image);
    Dx = zeros(X,Y);
    Dy = zeros(X,Y);
    maskX = [-1,0,1; -2,0,2; -1,0,1];
    maskY = [-1,-2,-1; 0,0,0; 1,2,1];
    for x=1:X
        for y=1:Y
            x1 = max(1,x-1);
            x2 = x1+2;
            x2 = min(X, x2);
            x1 = x2-2;
            y1 = max(1,y-1);
            y2 = y1+2;
            y2 = min(Y, y2);
            y1 = y2-2;
            window = image(x1:x2, y1:y2);
            Dx(x,y) = sum(dot(window, maskX));
            Dy(x,y) = sum(dot(window, maskY));
        end
    end

    eigen1 = zeros(X,Y);
    eigen2 = zeros(X,Y);
    cornerness = zeros(X,Y);
    patch = fspecial('gaussian', patchSize, patchStd);
    Ax2 = conv2(Dx .* Dx, patch, 'same');
    Ay2 = conv2(Dy .* Dy, patch, 'same');
    Axy = conv2(Dx .* Dy, patch, 'same');
    for x=1:X
        for y=1:Y
            A = [Ax2(x,y), Axy(x,y);  Axy(x,y), Ay2(x,y)];
            eigens = eig(A);
            e1 = eigens(1);
            e2 = eigens(2);
            eigen1(x,y) = e1;
            eigen2(x,y) = e2;
            cornerness(x,y) = e1*e2 - k*(e1+e2)*(e1+e2);
        end
    end
    
end

