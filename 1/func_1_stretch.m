function I_out = func_1_stretch(I_rgb)
    I_org = rgb2gray(I_rgb);
    
    %Before stretch
    %   most of image intensity values take up just a small range of the
    %   full uint8 range. [155, 255] in the range of [0, 255]
    figure('Name','stretch result'), 
    subplot(2,2,1), imshow(I_org);
    subplot(2,2,2), imhist(I_org);
   
    I_out = my_imstretch(I_org);
    
    %After stretch
    %   image intensity values are distributed over the whole range of [0 255]
    subplot(2,2,3), imshow(I_out);
    subplot(2,2,4), imhist(I_out);
end

function I = my_imstretch(I_org)
    I = I_org;
    limits = stretchlim(I)*255.0;
    I = double(I);
    I(I<=limits(1)) = 0.0;
    I(I>=limits(2)) = 255.0;
    range = limits(2) - limits(1); 
    in_range_idx = I>limits(1) & I < limits(2);
    I(in_range_idx) = ((I(in_range_idx) - limits(1))/range)*255.0;    
    I = uint8(I);
end