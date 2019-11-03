function [outputImg] = myPCADenoising2(inputImg, sigma)

[r, c] = size(inputImg);
patchDim = 7;
outputImg = zeros(r, c);
ctMat = zeros(r, c);
K = 200;
M = 31;
halfWin = (M - 1) / 2;

for i = 1:r-patchDim+1
    for j = 1:c-patchDim+1
        
        currpatch = inputImg(i : i + patchDim - 1, j : j + patchDim - 1);
        currpatch = currpatch(:);
        
        % setting the top-left and bottom-right points of the window
        xMin = max(i - halfWin, 1);
        xMax = min(i + halfWin - patchDim + 1, r - patchDim + 1);
        yMin = max(j - halfWin, 1);
        yMax = min(j + halfWin - patchDim + 1, c - patchDim + 1);
        windowR = xMax - xMin + 1;
        windowC = yMax - yMin + 1;
        
        P = zeros(patchDim^2, windowR * windowC);
        
        for x = xMin:xMax
            for y = yMin:yMax
                patch = inputImg(x : x + patchDim - 1, y : y + patchDim - 1);
                patch = patch(:);
                P(:, windowR * (x - xMin + 1) - windowR + (y - yMin + 1)) = patch;
            end
        end
        
        % getting the K nearest patches to the current patch using knnsearch
        nearestPatchIdx = knnsearch(P', currpatch', 'k', K);
        Q = P(:, nearestPatchIdx);
        
        [V, ~] = eig(Q * Q');
        eigencoeff = V' * Q;
        squaredEstimates = max(0, mean(eigencoeff.^2, 2) - sigma^2);
        patchEigencoeff = V' * currpatch;
        denoisedCoeff = patchEigencoeff .* (((squaredEstimates.^(-1)) .* sigma^2) + 1).^(-1);
        denoisedP = V * denoisedCoeff;

        patch = reshape(denoisedP, [patchDim, patchDim]);
        outputImg(i : i + patchDim - 1, j : j + patchDim - 1) = outputImg(i : i + patchDim - 1, j : j + patchDim - 1) + patch;
        ctMat(i : i + patchDim - 1, j : j + patchDim - 1) = ctMat(i : i + patchDim - 1, j : j + patchDim - 1) + 1;
    end
end

outputImg = outputImg ./ ctMat;

end