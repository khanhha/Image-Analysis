I = imread('.\input_sat_image.jpg');
I_gray = func_1_stretch(I);
I_b = func_2_threshold(I_gray);
I_mask = func_3_morph_filter(I_b);
figure('Name','Morphological filter result'),
imshow(I_gray);
green = cat(3, zeros(size(I_gray)), ones(size(I_gray)), zeros(size(I_gray))); 
hold on, h = imshow(green); hold off;
set(h, 'AlphaData', 0.2*double(I_mask));

%conlusion
%the result is quite not satisfactory. There're still some overlapping
%between the land and river.

%limitations of this method: 
% 1. it requires a clear separation in intensity between foreground
%    background.
% 2. it ignore color information.
