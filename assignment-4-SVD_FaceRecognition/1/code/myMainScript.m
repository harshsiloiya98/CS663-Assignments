%% MyMainScript

tic;

%% NOTE: The dataset folders should be placed according to the paths set in the code

%% Data Preprocessing

numPeople = 32;
folderPath = "../../att_faces";
trainingSet = [];
testingSet = [];

for i = 1:numPeople
    subfolderPath = strcat(folderPath, "/s", int2str(i));
    for j = 1:10
        filePath = strcat(subfolderPath, "/", int2str(j), ".pgm");
        tempImg = imread(filePath);
        if (j < 7)
            trainingSet = cat(3, trainingSet, im2double(tempImg));
        else
            testingSet = cat(3, testingSet, im2double(tempImg));
        end
    end
end
[r, c, N] = size(trainingSet);
[~, ~, M] = size(testingSet);
trainingSet = reshape(trainingSet, [r * c, N]);
testingSet = reshape(testingSet, [r * c, M]);

%% Face recognition algorithm (dataset used - ORL)

meanImg = mean(trainingSet, 2);
for i = 1:N
    trainingSet(:, i) = trainingSet(:, i) - meanImg;
end
for j = 1:M
    testingSet(:, j) = testingSet(:, j) - meanImg;
end


K = [1 2 3 5 10 15 20 30 50 75 100 150 170];
recognitionRates = zeros(size(K));

% calculating the recognition rate for each k
for i = 1:size(K, 2)
    % change the third argument of getEigenvectors() to 'svd' or 'eig'
    % according to how you want to calculate the eigenvectors
    eV = getEigenvectors(trainingSet, K(i), 'svd');
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
        if (ceil(matchedIdx / 6) == ceil(j / 4))
            truePositives = truePositives + 1;
        end
    end
    recognitionRates(i) = truePositives / M;
end

figure;
plot(K, recognitionRates);
xlabel('K');
ylabel('Recognition rate');
title('Recognition rate vs K');

%% Yale dataset testing

numPeople = 

%%
toc;