function [recognitionRates] = myFaceRecog(trainingSet, numTrain, testingSet, numTest, K, method)
% face recognition algorithm implementation

recognitionRates = zeros(size(K));
M = size(testingSet, 2);

% calculating the recognition rate for each k
for i = 1:size(K, 2)
    eV = getEigenvectors(trainingSet, K(i), method);
    trainProjection = eV' * trainingSet;
    testProjection = eV' * testingSet;
    truePositives = 0;
    for j = 1:size(testProjection, 2)
        minSqDiff = Inf;
        matchedIdx = 0;
        for k = 1:size(trainProjection, 2)
            sqDiff = norm(testProjection(:, j) - trainProjection(:, k))^2;
            if (sqDiff < minSqDiff)
                minSqDiff = sqDiff;
                matchedIdx = k;
            end
        end
        % numTrain - no. of images of a particular person considered for training
        % numTest - no. of images of a particular person considered for testing
        if (ceil(matchedIdx / numTrain) == ceil(j / numTest))
            truePositives = truePositives + 1;
        end
    end
    recognitionRates(i) = truePositives / M;
end

end