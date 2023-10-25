function quant_levels = simple_quantizer(input_image, quantizer_stepsize)

% Quantize the image with provided stepsize
quant_levels = round(input_image / quantizer_stepsize);

end

