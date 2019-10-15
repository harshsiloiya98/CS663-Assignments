function [recognitionRates1, recognitionRates2] = myFaceRecog(trainingSet, trainIdentityMap, testingSet, testIdentityMap, K, method)
% face recognition algorithm implementation
% output argument 1 - recognition rates w.r.t. all the k eigenvectors
% output argument 2 - recognition rates w.r.t. all k except the largest 3

recognitionRates1 = zeros(size(K));
recognitionRates2 = zeros(size(K));
M = size(testingSet, 2);

% calculating the recognition rate for each k
for i = 1:size(K, 2)
    eV = getEigenvectors(trainingSet, K(i), method);
    trainProjection = eV' * trainingSet;
    testProjection = eV' * testingSet;
    truePositives1 = 0;
    truePositives2 = 0;
    % recognition rate is calculated by counting the number of true
    % positives (i.e. the matched image is of the same person as that of
    % the probe image) divided by the total number of probes conducted
    for j = 1:size(testProjection, 2)
        minSqDiff1 = Inf;
        minSqDiff2 = Inf;
        matchedIdx1 = 0;
        matchedIdx2 = 0;
        for k = 1:size(trainProjection, 2)
            % calculating the Euclidean distance between the two images
            sqDiff = norm(testProjection(:, j) - trainProjection(:, k))^2;
            if (sqDiff < minSqDiff1)
                minSqDiff1 = sqDiff;
                matchedIdx1 = k;
            end
            % for eigenvectors excluding the 3 largest values
            sqDiff = norm(testProjection(4:end, j) - trainProjection(4:end, k))^2;
            if (sqDiff < minSqDiff2)
                minSqDiff2 = sqDiff;
                matchedIdx2 = k;
            end
        end
        % to check if the matched image is of the same person as that of
        % the test image
        if (trainIdentityMap(matchedIdx1) == testIdentityMap(j))
            truePositives1 = truePositives1 + 1;
        end
        if (trainIdentityMap(matchedIdx2) == testIdentityMap(j))
            truePositives2 = truePositives2 + 1;
        end
    end
    recognitionRates1(i) = truePositives1 / M;
    recognitionRates2(i) = truePositives2 / M;
end

end