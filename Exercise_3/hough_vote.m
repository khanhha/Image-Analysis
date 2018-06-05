function [H,T,R] = hough_vote(input_image, grad_theta)
[w,h] = size(input_image);
d = ceil(sqrt(w^2 + h^2));
H = zeros(2*d+1,180);
T = [-90:1:90];
R = [-d:1:d];
for i=1:1:w
    for j=1:1:h
        if(input_image(i,j) > 0)
%             theta =  grad_theta(i,j);            
%             rho = i*cos((theta)) + j*sin((theta));
%             theta = round(rad2deg(theta));
%             if theta < 90
%                 H(ceil(rho+d),theta+91) = H(ceil(rho+d),theta+91) + 1;
%             end
            for theta=-90:1:89
                rho =j*cos(deg2rad(theta)) + i*sin(deg2rad(theta));
                H(round(rho+d),theta+91) = H(round(rho+d),theta+91) + 1;
            end    
        end
    end
end
end