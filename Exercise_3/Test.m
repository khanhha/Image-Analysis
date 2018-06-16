I  = imread('input_ex3.jpg');
I = rgb2gray(I);
%BW = edge(I,'canny');
BW = zeros(size(I));
BW = imresize(BW,[512 512]);

%BW = draw_line(BW, [1 256], [512 256]);
%BW = draw_line(BW, [256 1], [256 512]);
%BW = draw_line(BW, [1 1], [512 512]);
BW = draw_line(BW, [1 512], [512 1]);
BW(1:4, 1:4) = 256;
figure, 
subplot(1,2,1); imshow(BW,[])

[H,T1,R1] = hough_vote(BW,[]);
%[H,T1,R1] = hough(BW);

subplot(1,2,2); imshow(H,[],'XData',T1,'YData',R1,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
P  = houghpeaks(H,2,'threshold',ceil(0.005*max(H(:))));
x = T1(P(:,2)); 
y = R1(P(:,1));
plot(x,y,'s','color','white');

function [I_out] = draw_line(I, p0, p1)
I_out = I;
dif = p1-p0;
step = norm(dif);
dif = dif/norm(dif);
for i = 0:step
    p0 = round(p0+dif);
    for j = 1:2
        if p0(j) <= 0
            p0(j) = 1;
        elseif p0(j)> 512
            p0(j) = 512;
        end
    end
    I_out(p0(1), p0(2)) = 255;
end

% for i = p0(1):p1(1)
%     for j = p0(2):p1(2)
%         I_out(i,j) = 255;
%     end
% end
end