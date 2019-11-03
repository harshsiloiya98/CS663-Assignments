%% MyMainScript

clc;
clear;
tic;
%% Your code here

% I and J
I = zeros(300,300);
I(50:100,50:120) = 255;
J = zeros(300,300);
J(120:170,20:90) = 255;

FI = fft2(I);
FJ = fft2(J);
Output = (FI .* conj(FJ)) ./ abs(FI.*FJ);
Inv = ifft2(Output);
[r,c] = find(Inv == max(max(Inv)));


% Adding noise to I and J
I2 = I + randn(size(I))*20;
J2 = J + randn(size(J))*20;

FI2 = fft2(I2);
FJ2 = fft2(J2);
Output2 = (FI2 .* conj(FJ2)) ./ abs(FI2.*FJ2);
Inv1 = ifft2(Output2);
[r1,c1] = find(Inv1 == max(max(Inv1)));

% Displaying logs
figure(1);
imagesc(log(1+abs(Output)));
figure(2);
imagesc(log(1+abs(Output2)));


toc;
