function output_image = simple_dequantizer(quant_levels, quantizer_stepsize)

% Dequantize with the provided stepsize
output_image = quant_levels * quantizer_stepsize;

end

