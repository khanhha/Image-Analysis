% Load library
pkg load image
pkg load statistics

% Task 1: Gradient of Gaussian (GoG) filtering

% Generate C_x,C_y
Initial_matrix = [-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2];
C_x = Initial_matrix;
C_y = C_x';

% Set value of gamma
gamma = 0.5;

% a) Compute continuous GoG-filter kernels for convolution in x- and y-direction
G_x = (-C_x/(2*pi*gamma^4)).*exp(-(C_x.^2 + C_y.^2)/(2*gamma^2))
G_y = G_x'

% b) Apply these filters to your input image I......
I_0= imread('ampelmaennchen.jpg');
I = rgb2gray(I_0);
I = double(I)/255;
I_x = imfilter(I,G_x);
I_y = imfilter(I,G_y);

% Show Image filter by G_x,G_y
figure(1), 
subplot(1,3,1); imshow(I_x,[]), title("Filter Image By G_x");
subplot(1,3,2); imshow(I_y,[]), title("Filter Image By G_y");

% c) Compute and show the gradient magnitude
G = sqrt(I_x.^2 + I_y.^2);
figure(1),
subplot(1,3,3); imshow(G),[], title("Gradient magnitude Image");
%figure(3),imshow(G),title("Gradient magnitude Image");


% Task 2: Förstner interest operator:

% a) Compute the autocorrelation matrix ?? for each pixel

% Matrix W
W_N = ones(5);

% Calculate M
I_xx = I_x.*I_x;
I_xy = I_x.*I_y;
I_yy = I_y.*I_y;
I_xx = imfilter(I_xx,W_N);
I_xy = imfilter(I_xy,W_N);
I_yy = imfilter(I_yy,W_N);
% Initial Cornerness and Roundness Matrix
W = double(zeros(size(I)(1),(size(I)(2))));
Q = W;
for i= 1:size(I)(1)
  for j= 1:size(I)(2)
      M = [I_xx(i,j) I_xy(i,j); I_xy(i,j) I_yy(i,j)];
      t = (trace(M)/2)^2 - det(M);
      if (t>0)
        % Calculate cornerness W
        W(i,j) = trace(M)/2 - sqrt(t);
        
        % Calculate roundness Q
        Q(i,j) = 4*det(M)/(trace(M)^2);
      end 
  end
end

% Find corner point candidates
W_final = (W > 0.1);
Q_final = (Q > 0.5);

R = W_final.* Q_final;
figure(2), imshow(0.5*255*R + 0.5*I_0,[]), title("Final image")