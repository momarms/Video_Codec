function output_mse = mse_of_frame(original_image, distorted_image)

% Convert image to double format
original_image = im2double(original_image);
distorted_image = im2double(distorted_image);

% Compute squared error
error = (original_image - distorted_image) .^ 2;

% Calculate mean to get MSE
output_mse = mean(error(:));

end

