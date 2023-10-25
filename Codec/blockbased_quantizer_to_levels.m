function out_levels = blockbased_quantizer_to_levels(input_image, quantizer_matrix)

% Pass the quantizer to blockwise processing function
quantizer = @(data) scalar_quantizer(data, quantizer_matrix);

out_levels = blockwise_processing(input_image, size(quantizer_matrix), quantizer);

end