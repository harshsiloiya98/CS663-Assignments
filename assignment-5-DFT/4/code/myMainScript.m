%% MyMainScript

close all;
clear;
tic;
%% Your code rocolere

image=imread('barbara256.png');
%cutoff
D=60;
sigma=60;

row=size(image,1);
col=size(image,2);
mid_row=row/2;
mid_col=col/2;

new_im=zeros(2*row,2*col);
new_im(mid_row:mid_row+row-1,mid_col:mid_col+col-1)=image;
fnew_im=fftshift(fft2(new_im));

% Ideal Low Pass Filter
y=(1:2*col);
x=(1:2*row).';
nfilter=(x-row).^2+(y-col).^2 <= D^2;
figure;
imagesc(nfilter);colormap 'gray';colorbar;
fnew_im1=fnew_im.*nfilter;
fnew_im1=ifftshift(fnew_im1);
new_im=ifft2(fnew_im1);
new_im=new_im(mid_row:mid_row+row-1,mid_col:mid_col+col-1);
new_im=real(new_im);
figure;
imagesc(new_im);colormap 'gray';colorbar;

% Gaussian Low Pass Filter
y1=(1:2*col);
x1=(1:2*row).';
exponent = ((x1-row).^2 + (y1-col).^2)./(2*sigma);
nfilter = (exp(-exponent));
figure;
imagesc(nfilter);colormap 'gray';colorbar;
fnew_im2=fnew_im.*nfilter;
fnew_im2=ifftshift(fnew_im2);
new_im=ifft2(fnew_im2);
new_im=new_im(mid_row:mid_row+row-1,mid_col:mid_col+col-1);
new_im=real(new_im);
figure;
imagesc(new_im);colormap 'gray';colorbar;

toc;