%% MyMainScript
clc;
clear;
tic;

%% NOTE: The dataset folders should be placed according to the folder paths set in the code

%% Data Preprocessing

numPeople = 32;
folderPath = ('../../att_faces');
trainingSet = [];
trainIdentityMap = [];

for i = 1:numPeople
    subfolderPath = strcat(folderPath, '/s', int2str(i));
    for j = 1:10
        filePath = strcat(subfolderPath, '/', int2str(j), '.pgm');
        tempImg = imread(filePath);
        if (j < 7)
            trainingSet = cat(3, trainingSet, im2double(tempImg));
            trainIdentityMap = [trainIdentityMap i];
        end
    end
end
[r, c, N] = size(trainingSet);
trainingSet = reshape(trainingSet, [r * c, N]);

meanImg = mean(trainingSet, 2);
for i = 1:N
    trainingSet(:, i) = trainingSet(:, i) - meanImg;
end

K = [2, 10, 20, 50, 75, 100, 125, 150, 175];

%% Foriming Reconstructed Image

for i = 1:size(K,2)
    k=K(i);
    [U, ~, ~] = svd(trainingSet, 'econ');
    eigenvectors = U(:, 1:k);
    alpha_ik = eigenvectors'*trainingSet(:,1);
    outputImg = meanImg + eigenvectors*alpha_ik;
    outputImg = reshape(outputImg,112,92);
    figure;
    imshow(outputImg); title( strcat('Reconstructed Image at K = ', int2str(k)) );
end

%% Plotting 25 Eigenvectors

k=25;
[U, ~, ~] = svd(trainingSet, 'econ');
eigenvectors = U(:, 1:k);
figure;
for i=1:k
    eigenfaces=reshape(eigenvectors(:,i), 112,92);
    subplot(5,5,i);
    imagesc(eigenfaces); colormap 'gray'; title( strcat('eigenface ', int2str(i)) );
end

toc;
