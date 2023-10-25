function [coded_bits, mse_per_frame] = encoder_basic_intra(input_yuv_file, coded_file, width, height, number_of_frames, transform_blocksize, qp)

mse_per_frame = [];
runlevel_all_frames = [];

for i = 1 : number_of_frames
    [output_image_Y, ~, ~] = yuv_read_one_frame(input_yuv_file, i, width, height);

    transformed_image = blockbased_dct_on_image(output_image_Y, transform_blocksize);
    quantizer_matrix = get_quantisation_matrix(qp, transform_blocksize);
    quantized_image = blockbased_quantizer_to_levels(transformed_image, quantizer_matrix);
    % quantized_image = blockbased_deadzone_quantizer_to_levels(transformed_image, quantizer_matrix);
    zigzag_scanned = blockbased_encoding_to_zigzag_scanned(quantized_image, transform_blocksize);
    runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);

    zigzag_scanned_reconstructed = blockbased_decoding_from_runlevel_representation(runlevel_representation, transform_blocksize);
    input_levels_reconstructed = blockbased_decoding_from_zigzag_scanned(zigzag_scanned_reconstructed, transform_blocksize, width, height);
    zigzag_scanned_reconstructed = blockbased_dequantizer_from_levels(input_levels_reconstructed, quantizer_matrix);
    reconstructed_image = blockbased_idct_on_image(zigzag_scanned_reconstructed, transform_blocksize);
    
    reconstructed_image(reconstructed_image < 0) = 0;
    reconstructed_image(reconstructed_image > 1) = 1;
    
    mse_per_frame = [mse_per_frame; mse_of_frame(output_image_Y, reconstructed_image)];
    runlevel_all_frames = [runlevel_all_frames; runlevel_representation];
end

huffman_table = create_huffman_table_from_signal(runlevel_all_frames);
bitstream = bitstream_init();
bitstream = encode_signal_to_huffman_bitstream(bitstream, huffman_table, runlevel_all_frames);

save(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream');

coded_bits = bitstream_get_length(bitstream);

end