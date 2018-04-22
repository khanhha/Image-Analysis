%Difficulties in choosing a good threshold:
%   - there isn't a clear separation in intensity between the river region and the land.
%     therefore, it's almost impossible to binarize image without small artifacts. 
function I_b = func_2_threshold(I)
    test_ranges = [0.1, 0.3, 0.5, 0.7, 0.9];
    figure('Name','threshold result'),
    for i = 1:numel(test_ranges)
        I_tmp = imbinarize(I, test_ranges(i));
        subplot(2,3,i), imshow(I_tmp), title(strcat('threshold = ', num2str(test_ranges(i))));
    end
    t = graythresh(I);
    I_b = imbinarize(I, t);
    subplot(2,3,6), imshow(I_b), title(strcat('otso threshold = ',num2str(t)));
end