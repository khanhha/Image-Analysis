function I_out = func_3_morph_filter(I_in)
    I_out = I_in;
    str = strel('rectangle',[20,20]);
    I_out = imclose(I_out, str);
    I_out = imopen(I_out, str); 
end