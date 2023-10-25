function output_psnr = psnr_of_frame(original_image, distorted_image)

%Convert image to double
original_image = im2double(original_image);
distorted_image = im2double(distorted_image);

% Max signal power
s = 1;

% Calculate the MSE
mse = mse_of_frame(original_image, distorted_image);

% Compute PSNR
output_psnr = 10 * log10((s ^ 2) / (mse));

end

