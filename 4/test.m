FS = 2000; % sampling frequency
T = 1/FS;  % sampling period
L = 2000;  % signal length
t = (0:L-1)*T;

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
X_ = S + 2*randn(size(t));

X1 = sin(2*pi*50*t);
X2 = sin(2*pi*100*t);
X3 = sin(2*pi*150*t);
X = X1+X2+X3;

n = 2^nextpow2(L);
F = fft(X_, n)/n;

P1 = (F);
P1 = P1(1:n/2+1);
P1(2:end-1) = 2*P1(2:end-1);

X_1 = ifft(F);

subplot(3,1,1); plot(t(1:100), X1(1:100), 'b-')
subplot(3,1,2); plot(t(1:100), X2(1:100), 'b-')
subplot(3,1,3); plot(t(1:100), X3(1:100), 'b-')

NFFT = n;
f=FS/2*linspace(-1,1,NFFT);
figure, plot(f,2*abs(F))

