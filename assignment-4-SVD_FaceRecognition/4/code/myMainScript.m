%% MyMainScript
tic;
clear;
clc;

A = randi(100, randi(100), randi(100));
[U, S, V] = MySVD(A);
A1 = U*S*V';
error = norm(A-A1);
disp(error);

toc;