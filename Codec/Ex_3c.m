% Initialize
R = [];
D = [];
figure('name', 'Quantization');

% Store and display original image
input_image =  im2double(imread('flowergarden_cif_frame1.tif'));
subplot(2,2,1.5);
imshow(input_image);
title('Original Image');

% Get the quantized image and display it
n = 8;
quantizer_stepsize = 1 / 2 ^ (n -1);
quantized_image = simple_dequantizer(simple_quantizer(input_image, quantizer_stepsize), quantizer_stepsize);

subplot(2,2,3);
imshow(quantized_image);
title('8-Bit Quantized Image');

% Calculate quantizer matrix
n0 = 3;
q0 = 1 / 2 ^ (n0 -1);
n1 = 6;
q1 = 1 / 2 ^ (n1 -1);
quantizer_matrix = design_quantizer_matrix(q0, q1);

% Get the matrix quantized image and display it
matrix_quantized_image = scalar_dequantizer(scalar_quantizer(input_image, quantizer_matrix), quantizer_matrix);

subplot(2,2,4);
imshow(matrix_quantized_image);
title('Matrix Quantized Image');