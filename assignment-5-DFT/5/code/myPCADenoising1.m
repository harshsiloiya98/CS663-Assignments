function [outputImg] = myPCADenoising1(inputImg, sigma)

[r, c] = size(inputImg);
patchDim = 7;
outputImg = zeros(r, c);
N = (r - patchDim + 1) * (c - patchDim + 1);
P = zeros(patchDim^2, N);
ctMat = zeros(r, c);

for i = 1:r-patchDim+1
    for j = 1:c-patchDim+1
        patch = inputImg(i : i + patchDim - 1, j : j + patchDim - 1);
        patch = patch(:);
        P(:, i * (r - patchDim + 1) - (c - patchDim + 1) + j) = patch;
    end
end

[V, ~] = eig(P * P');
eigencoeff = V' * P;
squaredEstimates = max(0, mean(eigencoeff.^2, 2) - sigma^2);
denoisedCoeff = eigencoeff .* ((squaredEstimates.^(-1) * sigma^2) + 1).^(-1);
denoisedP = V * denoisedCoeff;

for i = 1:r-patchDim+1
    for j = 1:c-patchDim+1
        patch = denoisedP(:, i * (r - patchDim + 1) - (c - patchDim + 1) + j);
        patch = reshape(patch, [patchDim, patchDim]);
        outputImg(i : i + patchDim - 1, j : j + patchDim - 1) = outputImg(i : i + patchDim - 1, j : j + patchDim - 1) + patch;
        ctMat(i : i + patchDim - 1, j : j + patchDim - 1) = ctMat(i : i + patchDim - 1, j : j + patchDim - 1) + 1;
    end
end

outputImg = outputImg ./ ctMat;

end