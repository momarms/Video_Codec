function output_image = blockbased_idct_on_image(input_image, blocksize)

output_image = blockwise_processing(input_image, [blocksize, blocksize], 'idct2');

end