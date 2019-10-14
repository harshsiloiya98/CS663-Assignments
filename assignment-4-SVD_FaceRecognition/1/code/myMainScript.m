%% MyMainScript
clc;
clear;
tic;

%% NOTE: The dataset folders should be placed according to the folder paths set in the code

%% Data Preprocessing

numPeople = 32;
folderPath = "../../att_faces";
trainingSet = [];
trainIdentityMap = [];
testingSet = [];
testIdentityMap = [];

for i = 1:numPeople
    subfolderPath = strcat(folderPath, "/s", int2str(i));
    for j = 1:10
        filePath = strcat(subfolderPath, "/", int2str(j), ".pgm");
        tempImg = imread(filePath);
        if (j < 7)
            trainingSet = cat(3, trainingSet, im2double(tempImg));
            trainIdentityMap = [trainIdentityMap i];
        else
            testingSet = cat(3, testingSet, im2double(tempImg));
            testIdentityMap = [testIdentityMap i];
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

% change the last argument of myFaceRecog to 'svd' or 'eig' according to
% how you want to calculate the eigenvectors
recognitionRates = myFaceRecog(trainingSet, trainIdentityMap, testingSet, testIdentityMap, K, 'svd');

figure;
plot(K, recognitionRates);
xlabel('K');
ylabel('Recognition rate');
title('Recognition rate vs K (ORL)');

%% Yale dataset testing

folderPath = "../../CroppedYale";
subfolders = dir(folderPath);
dirFlags = [subfolders.isdir];
subfolders = subfolders(dirFlags);
% removing '.' and '..' directories
subfolders = subfolders(3:end);
trainingSet = [];
trainIdentityMap = [];
testingSet = [];
testIdentityMap = [];

% reading the images
for i = 1:length(subfolders)
    subfolderPath = strcat(folderPath, "/", subfolders(i).name);
    files = dir(fullfile(subfolderPath, '*.pgm'));
    for j = 1:length(files)
        filePath = strcat(subfolderPath, "/", files(j).name);
        tempImg = imread(filePath);
        if (j < 41)
            trainingSet = cat(3, trainingSet, im2double(tempImg));
            trainIdentityMap = [trainIdentityMap i];
        else
            testingSet = cat(3, testingSet, im2double(tempImg));
            testIdentityMap = [testIdentityMap i];
        end
    end
end

% data preprocessing
[r, c, N] = size(trainingSet);
[~, ~, M] = size(testingSet);
trainingSet = reshape(trainingSet, [r * c, N]);
testingSet = reshape(testingSet, [r * c, M]);

meanImg = mean(trainingSet, 2);
for i = 1:N
    trainingSet(:, i) = trainingSet(:, i) - meanImg;
end
for j = 1:M
    testingSet(:, j) = testingSet(:, j) - meanImg;
end

K = [1 2 3 5 10 15 20 30 50 60 65 75 100 200 300 500 1000];

% change the last argument of myFaceRecog to 'svd' or 'eig' according to
% how you want to calculate the eigenvectors
recognitionRates = myFaceRecog(trainingSet, trainIdentityMap, testingSet, testIdentityMap, K, 'svd');

figure;
plot(K, recognitionRates);
xlabel('K');
ylabel('Recognition rate');
title('Recognition rate vs K (Yale)');

%%
toc;