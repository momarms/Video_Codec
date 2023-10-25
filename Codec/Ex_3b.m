% Initialize
R = [];
D = [];
figure('name', 'Quantization');

% Store and display original image
input_image =  im2double(imread('flowergarden_cif_frame1.tif'));
subplot(2,2,3);
imshow(input_image);
title('Original Image');

for n = 1 : 8
    
    % Get the quantized image
    quantizer_stepsize = 1 / 2 ^ (n -1);
    quantized_image = simple_dequantizer(simple_quantizer(input_image, quantizer_stepsize), quantizer_stepsize);

    % Calculate rate and distortion
    R(n) = n;
    D(n) = psnr_of_frame(input_image, quantized_image);

    % Plot the D(R) curve
    subplot(2,2,[1,2])
    plot(R, D);
    title('Distortion - Rate Curve');
    xlabel('Rate (bits / pixel)');
    ylabel('PSNR (dB)');
    xlim([0 10]);
    ylim([0 60]);
    
    % Display quantized image
    subplot(2,2,4);
    imshow(quantized_image);
    title('Quantized Image');
    
    pause();

end