function [eigenvectors] = getEigenvectors(trainingSet, k)
% calculates the eigenvectors for the training set images using
% singular-value decomposition

[U, ~, ~] = svd(trainingSet, 'econ');
eigenvectors = U(:, 1:k);