
% a. Read the input image and convert it to a grayscale image
I_0 = imread('input_ex3.jpg');
I_1 = rgb2gray(I_0);
I = double(I_1)/255;
figure(1),
subplot(2,4,1),imshow(I_0),title('Original Image')
subplot(2,4,2),imshow(I,[]),title('Grayscale Image')

% b. Apply a GoG filter  in order to derive gradient....
Initial_matrix = [-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2];
Cx = Initial_matrix;
Cy = Cx';
sigma = 0.5;
Gx = (-Cx/(2*pi*sigma)).*exp(-(Cx.^2 + Cy.^2)/(2*sigma^2));
Gy = Gx';
Ix = imfilter(I,Gx);
Iy = imfilter(I,Gy);
G = sqrt(Ix.^2 + Iy.^2);
grad_theta =  atan(Iy./Ix);
figure(1),
subplot(2,4,3),imshow(Ix,[]),title("Ix")
subplot(2,4,4),imshow(Iy,[]),title("Iy")
subplot(2,4,5),imshow(G,[]),title("gradient magnitude")

% c. Find and apply an appropriate threshold on the gradient magnitude
threshold_image = imbinarize(G);
figure(1),
subplot(2,4,6),imshow(threshold_image,[]),title("binary edge mask 1111")

% d. Implement a function for Hough line detection.
BW = edge(I_1,'canny');
figure(2),
%subplot(1,3,1),imshow(BW),title("Test Image 1");

[H,T,R] = hough_vote(BW);
%[H,T,R] = hough(BW);
subplot(1,2,1), imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P  = houghpeaks(H,60,'threshold',ceil(0.005*max(H(:))));
x = T(P(:,2)); 
y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
subplot(1,2,2), imshow(BW), hold on
 max_len = 0;
 for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % determine the endpoints of the longest line segment 
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
     max_len = len;
     xy_long = xy;
   end
 end

