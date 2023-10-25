function out_image = blockbased_dequantizer_from_levels(input_levels, quantizer_matrix)

% Pass the quantizer to blockwise processing function
dequantizer = @(data) scalar_dequantizer(data, quantizer_matrix);

out_image = blockwise_processing(input_levels, size(quantizer_matrix), dequantizer);

end