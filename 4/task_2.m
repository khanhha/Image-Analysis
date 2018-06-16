n = 24;
I = imread('trainB.png');
I = rgb2gray(I);
BW = imbinarize(I);
[B,L] = bwboundaries(BW,'noholes');
D_0 = B{1};
D = D_0(:,2) + 1i*D_0(:,1);
F0 = fft(D);

N = numel(F0);
N1 = 2*n+1;
F = zeros(N1,1);
scale = (N1/N);
F(1) = scale*F0(1);
F(2:n+1) = scale*F0(2:n+1);
F(n+2:N1) = scale*F0(N-n+1:N);

%translation invariant
F(1) = 0;
%scale invariant
F(2:N1) = F(2:N1)/norm(F);
%rotation invariant

% norm_F = 0;
% for i = 2:numel(F)
%     norm_F = norm_F + norm(F(i))*norm(F(i));
% end
% norm_F = sqrt(norm_F)
% for i = 2:numel(F)
%     F(i) = F(i)/norm_F;
% end

%F(3:n) = 0;
D_1 = ifft(F);
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
plot(real(D_1), imag(D_1), 'w', 'LineWidth', 2)

I_test_1 = imread('test1B.jpg');
I_test_1 = rgb2gray(I_test_1);
BW_test_1 = imbinarize(I_test_1);
[B,L] = bwboundaries(BW_test_1,'noholes');
for k = 1:length(B)
   boundary = B{k};
   %fft(boundary(:,2)+boundary(:,1));
end

figure,
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
