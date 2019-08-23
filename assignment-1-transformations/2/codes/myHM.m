function finalNewImg = myHM(input_img, ref_img)
% performs histogram matching between two images

  [r1, c1, channels] = size(input_img);
  [r2, c2, ~] = size(ref_img);
  finalNewImg = zeros(r1, c1, channels);

  % number of pixels per channel
  num_pixels1 = r1 * c1;
  num_pixels2 = r2 * c2;

  % Initializing the mapping
  M = zeros(256, 1);

  for i = 1:channels
     [counts1, ~] = imhist(input_img(:, :, i));
     [counts2, ~] = imhist(ref_img(:, :, i));
     tmp_img = input_img(:, :, i);
     
     % calculating the PDFs and CDFs of histograms
     pdf1 = counts1 / num_pixels1;
     cdf1 = cumsum(pdf1);
     pdf2 = counts2 / num_pixels2;
     cdf2 = cumsum(pdf2);
     
     % calculating the mapping
     for j = 1:256
         [~, ind] = min(abs(cdf1(j) - cdf2));
         M(j) = ind - 1;
     end
     
     % applying the mapping on original image
     range = 1:num_pixels1;
     newImg = M(tmp_img(range) + 1);
     newImg = reshape(newImg, [r1, c1]);
     
     finalNewImg(:, :, i) = newImg;
  end

  % converting matrix to image
  finalNewImg = cast(finalNewImg, class(input_img));

end

% Reference - https://stackoverflow.com/questions/26763974/histogram-matching-of-two-images-without-using-histeq
