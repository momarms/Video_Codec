function sad_value = calculate_sad(input_block1, input_block2)

% Calculate error in each pixel
error_matrix = input_block1 - input_block2;

% Compute SAD
sad_value = sum(abs(error_matrix), 'all');

end

