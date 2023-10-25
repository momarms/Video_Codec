function output_image = blockbased_deadzone_dequantizer_from_levels(input_levels, quantizer_matrix)

dequantizer = @ (input_levels) deadzone_dequantizer(input_levels, quantizer_matrix);
output_image = blockwise_processing(input_levels, size(quantizer_matrix), dequantizer);

end