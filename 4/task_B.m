
process_img_test1b()

process_img_test2b()

function process_img_test2b()
    n_freq_pairs = 24; 
    I = imread('test2B.jpg');
    I = rgb2gray(I);
    BW = imbinarize(I);
    [B,L] = bwboundaries(BW,'noholes');

    G_train = extract_train_fourier_descriptor(n_freq_pairs);
    G_tests = extract_fourier_descriptors(n_freq_pairs, B);

    [mask, ] = predict_contour_descriptor(G_train, G_tests, 0.2);

    figure,
    imshow(imread('test2B.jpg'))
    for i = 1:numel(mask)
        if mask(i) == 1
            hold on;
            C = B{i};
            plot(C(:,2), C(:,1),'-w', 'LineWidth', 3);
        end
    end
end

function process_img_test1b()
    n_freq_pairs = 24;
    
    I = imread('test1B.jpg');
    I = rgb2gray(I);
    BW = imbinarize(I);
    [B,L] = bwboundaries(BW,'noholes');
    
    G_train = extract_train_fourier_descriptor(n_freq_pairs);
    G_tests = extract_fourier_descriptors(n_freq_pairs, B);

    [mask, ] = predict_contour_descriptor(G_train, G_tests, 0.1);

    figure,
    imshow(imread('test1B.jpg'))
    for i = 1:numel(mask)
        if mask(i) == 1
            hold on;
            C = B{i};
            plot(C(:,2), C(:,1),'-w', 'LineWidth', 3);
        end
    end
end

function [mask, dsts] = predict_contour_descriptor(G_train, G_tests, threshold)
    n_contour = size(G_tests);
    n_contour = n_contour(1);
    mask = zeros(n_contour, 1);
    dsts = zeros(n_contour, 1);
    for i = 1:n_contour
        dsts(i)= norm(abs(G_train) - abs(G_tests(i,:)'));
        if dsts(i) < threshold
            mask(i) = 1;
        end
    end
end

function G = extract_train_fourier_descriptor(n_freq_pairs)
    I = imread('trainB.png');
    I = rgb2gray(I);
    BW = imbinarize(I);
    [B,L] = bwboundaries(BW,'noholes');
    C = B{1};
    G = lowest_frequency_pairs(fourier_descriptor(C), n_freq_pairs);
    G = make_fourier_descriptor_invariant(G);
end

function Gs = extract_fourier_descriptors(n_freq_pairs, contours)
    n_contour = length(contours);
    Gs = zeros(n_contour, 2*n_freq_pairs+1);
    for k = 1:n_contour
       C = contours{k};
       if numel(C)/2 >= (2*n_freq_pairs+1)
           G = lowest_frequency_pairs(fourier_descriptor(C), n_freq_pairs);
           G = make_fourier_descriptor_invariant(G);
           Gs(k,:) = G';           
       end
    end
end

function G = fourier_descriptor(C)
    D = C(:,2) + 1i*C(:,1);
    G = fft(D);
end

function G_1 = lowest_frequency_pairs(G, n_pairs)
    N = numel(G);
    N1 = 2*n_pairs+1;
    G_1 = zeros(N1,1);
    scale = (N1/N);
    G_1(1) = scale*G(1);
    G_1(2:n_pairs+1) = scale*G(2:n_pairs+1);
    G_1(n_pairs+2:N1) = scale*G(N-n_pairs+1:N);
end

function G = make_fourier_descriptor_invariant(G)
    G(1) = 0; %translation invariant
    G = G / norm(G); %scale invariant
    G = abs(G); %rotation invariant
end

function plot_fourier_pair(G1, G2, m, M)
    K = linspace(1, M, M);
    g = G1*exp(- 1i*2*pi*m*K/M) + G2 * exp(1i*2*pi*m*K/M); 
    figure,
    plot(real(g), imag(g), '*b');
end
