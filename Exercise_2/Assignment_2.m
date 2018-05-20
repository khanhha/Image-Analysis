% Load library
pkg load image
pkg load statistics

% Task 1: Gradient of Gaussian (GoG) filtering

% Generate C_x,C_y
Initial_matrix = [-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2;-2 -1 0 1 2];
C_x = Initial_matrix
C_y = C_x'

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
figure(1), imshow(I_x), title("Filter Image By G_x");
figure(2), imshow(I_y), title("Filter Image By G_y");

% c) Compute and show the gradient magnitude
G = sqrt(I_x.^2 + I_y.^2);
figure(3),imshow(G),title("Gradient magnitude Image");


% Task 2: Förstner interest operator:

% a) Compute the autocorrelation matrix ?? for each pixel

% Matrix W
W = ones(7);

% Calculate M
I_xx = I_x.*I_x;
I_xy = I_x.*I_y;
I_yy = I_y.*I_y;
I_xx = imfilter(I_xx,W);
I_xy = imfilter(I_xy,W);
I_yy = imfilter(I_yy,W);
figure(4),imshow(I_xx),title("I_xx");
figure(5),imshow(I_xy),title("I_xy");
figure(6),imshow(I_yy),title("I_yy");
% Initial Cornerness and Roundness Matrix
E = double(zeros(size(I)(1),(size(I)(2))));
F = E;
for i= 1:size(I)(1)
  for j= 1:size(I)(2)
      M = [I_xx(i,j) I_xy(i,j); I_xy(i,j) I_yy(i,j)];
      t = (trace(M)/2)^2 - det(M);
      if (t>0)
        % Calculate cornerness E
        E(i,j) = trace(M)/2 - sqrt(t);
        
        % Calculate roundness F
        F(i,j) = 4*det(M)/(trace(M)^2);
      end 
  end
end

%E_final = (E > 0.05);
%F_final = (F > 0.5);

R = E.* F;
figure(7),imshow(R),title("detected image")
figure(8), imshow(0.5*255*R + 0.5*I_0), title("Final image")