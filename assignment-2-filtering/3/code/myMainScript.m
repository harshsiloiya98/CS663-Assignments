%% MyMainScript

tic;
%% Your code here
clear;
clc;


%% Barbara
image1 = load('../data/barbara.mat');
image1 = mat2gray(image1.imageOrig);

% Scale
image1 = imgaussfilt(image1,0.66);
image1 = image1(1:2:end,1:2:end);

% Corrupt
corruptImage1 = image1 + randn(size(image1)) .* 0.05;

% Filter
filteredImage1 = myPatchBasedFiltering(corruptImage1, 25, 9, 0.52);

% Display
figure('Name', 'Patch-Based Filtering on Image 1');
subplot(1,3,1), imshow(image1), colorbar, title('Original Image');
subplot(1,3,2), imshow(corruptImage1), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filteredImage1), colorbar, title('Filtered Image');

% RSMD
rsmd1 = myRSMD(filteredImage1, image1);

% Sigma vs RSMD
% sigmas1 = 0.4:0.01:0.6;
% rsmds1 = zeros(length(sigmas1),1);
% for i=1:length(sigmas1)
%     fprintf("Barbara, i = %d\n",i);
%     filteredImage = myPatchBasedFiltering(corruptImage1, 25, 9, sigmas1(i));
%     rsmds1(i) = myRSMD(filteredImage, image1);
% end
% Result after loop
% rsmds1 = [0.0334186339478700;0.0326613395058128;0.0319748580634693;0.0313605956327032;0.0308190186326683;0.0303498261970094;0.0299520671721776;0.0296242232341400;0.0293642796718792;0.0291697977585430;0.0290379929116533;0.0289658154767867;0.0289500278546907;0.0289872723379239;0.0290741266887174;0.0292071474175343;0.0293829028305750;0.0295979988726073;0.0298491007522895;0.0301329526437853;0.0304463967648959];


%% Grass

image2 = imread('../data/grass.png');
image2 = mat2gray(image2);

% Scale
% image2 = imgaussfilt(image2,0.66);
% image2 = image2(1:2:end,1:2:end);

% Corrupt
corruptImage2 = image2 + randn(size(image2)) .* 0.05;

% Filter
filteredImage2 = myPatchBasedFiltering(corruptImage2, 25, 9, 0.51);

% Display
figure('Name', 'Patch-Based Filtering on Image 2');
subplot(1,3,1), imshow(image2), colorbar, title('Original Image');
subplot(1,3,2), imshow(corruptImage2), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filteredImage2), colorbar, title('Filtered Image');

% RSMD
rsmd2 = myRSMD(filteredImage2, image2);

% Sigma vs RSMD
% sigmas2 = 0.4:0.01:0.6;
% rsmds2 = zeros(length(sigmas2),1);
% for i=1:length(sigmas2)
%     fprintf("Grass, i = %d\n",i);
%     filteredImage = myPatchBasedFiltering(corruptImage2, 25, 9, sigmas2(i));
%     rsmds2(i) = myRSMD(filteredImage, image2);
% end
% Result after loop
% rsmds2 = [0.0387828693989083;0.0379806462298825;0.0372322229787855;0.0365449681879085;0.0359256753459344;0.0353805526803212;0.0349151034500254;0.0345339356591201;0.0342405491631215;0.0340371461536828;0.0339245016501462;0.0339019175739306;0.0339672697748588;0.0341171436503309;0.0343470421531570;0.0346516414701305;0.0350250656612330;0.0354611524956313;0.0359536879580230;0.0364965948603662;0.0370840696969849];


%% HoneyComb

image3 = imread('../data/honeyCombReal.png');
image3 = mat2gray(image3);

% Scale
% image3 = imgaussfilt(image3,0.66);
% image3 = image3(1:2:end,1:2:end);

% Corrupt
corruptImage3 = image3 + randn(size(image3)) .* 0.05;

% Filter
filteredImage3 = myPatchBasedFiltering(corruptImage3, 25, 9, 0.53);

% Display
figure('Name', 'Patch-Based Filtering on Image 3');
subplot(1,3,1), imshow(image3), colorbar, title('Original Image');
subplot(1,3,2), imshow(corruptImage3), colorbar, title('Corrupted Image');
subplot(1,3,3), imshow(filteredImage3), colorbar, title('Filtered Image');

% RSMD
rsmd3 = myRSMD(filteredImage3, image3);

% Sigma vs RSMD
% sigmas3 = 0.4:0.01:0.6;
% rsmds3 = zeros(length(sigmas3),1);
% for i=1:length(sigmas3)
%     fprintf("HoneyComb, i = %d\n",i);
%     filteredImage = myPatchBasedFiltering(corruptImage3, 25, 9, sigmas3(i));
%     rsmds3(i) = myRSMD(filteredImage, image3);
% end
% Result after loop
% rsmds3 = [0.0382398255311505;0.0375449067719751;0.0368888630977747;0.0362773805521543;0.0357154148700108;0.0352070862413218;0.0347556122427602;0.0343632818845472;0.0340314714970196;0.0337606999824391;0.0335507173725541;0.0334006176955786;0.0333089656144569;0.0332739263105774;0.0332933893383929;0.0333650791783229;0.0334866475479329;0.0336557449129333;0.0338700708711554;0.0341274049854613;0.0344256210518470];

 
%% Display mask used to make patches isotropic

mask = ones(25,25);
rCenter = 13;
cCenter = 13;
for r=1:25
    for c=1:25
        mask(r,c) = mask(r,c) * exp(-((rCenter-r)^2+(cCenter-c)^2)/100);
    end
end
figure('Name', 'Mask');
imshow(mask);



%%

toc;

function rsmd = myRSMD(image1, image2)
    rsmd = image1(:) - image2(:);
    rsmd = rsmd .^ 2;
    rsmd = sum(rsmd);
    rsmd = rsmd / size(image1(:),1);
    rsmd = sqrt(rsmd);
end

