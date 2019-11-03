function [] = displayImage(image, imgtitle)

figure
imagesc(mat2gray(image));
colormap(gray(200));
daspect([1 1 1]);
axis on;
title(imgtitle);

end