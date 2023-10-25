function output_levels = blockbased_deadzone_quantizer_to_levels(input_image, quantizer_matrix)

quantizer = @ (input_image) deadzone_quantizer(input_image, quantizer_matrix);
output_levels = blockwise_processing(input_image, size(quantizer_matrix), quantizer);

end