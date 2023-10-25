function output_image = blockbased_dct_on_image(input_image, blocksize)

output_image = blockwise_processing(input_image, [blocksize, blocksize], 'dct2');

end