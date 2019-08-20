function [] = myLinearContrastStretching(img)
% Enhances the intensity contrast of the image

[r, c, channels] = size(img);
out = zeros(r, c, channels);

% looping through the channels
for i = 1:channels
    maxvalue = max(max(img(:, :, i)));
    minvalue = min(min(img(:, :, i)));
    out(:, :, i) = (img(:, :, i) - minvalue) / (maxvalue - minvalue);
end

imshow(out);
axis image;
axis on;

end