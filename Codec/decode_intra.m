function decode_intra(coded_file, decoded_yuv_file)

load(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream');

[~, runlevel_representation] = decode_signal_from_huffman_bitstream(bitstream, huffman_table);
zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation, transform_blocksize);
% zigzag_scanned = optional_dc_prediction_inverse(zigzag_scanned);
input_levels = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
quantizer_matrix = get_quantisation_matrix(qp,transform_blocksize);
zigzag_scanned = blockbased_dequantizer_from_levels(input_levels, quantizer_matrix);
% zigzag_scanned = blockbased_deadzone_dequantizer_from_levels(input_levels, quantizer_matrix);
idct_image = blockbased_idct_on_image(zigzag_scanned, transform_blocksize);

idct_image(idct_image < 0) = 0;
idct_image(idct_image > 1) = 1;

yuv_write_one_frame(decoded_yuv_file, 1, idct_image);

end