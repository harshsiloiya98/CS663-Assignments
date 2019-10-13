function [eigenvectors] = getEigenvectors(X, k, method)
% calculates the eigenvectors for the training set images using
% singular-value decomposition or finding eigenvectors of X'X

if (strcmp(method, 'eig') == 1)
    L = X' * X;
    [W, D] = eig(L);
    V = normalize(X * W, 1);
    [~, ind] = sort(diag(D), 'descend');
    V = V(:, ind);
    eigenvectors = V(:, 1:k);
elseif (strcmp(method, 'svd') == 1)
    [U, ~, ~] = svd(X, 'econ');
    eigenvectors = U(:, 1:k);
end