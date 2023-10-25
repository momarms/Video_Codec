function [coded_bits, mse_per_frame] = encoder_basic(input_yuv_file, coded_file, width, height, number_of_frames, transform_blocksize, qp, me_blocksize, me_searchrange)

motion_vectors_all_frames = [];
mse_per_frame = [];
runlevel_all_frames = [];
frame_type = 'I';

if frame_type == 'I'
    [output_image_Y, ~, ~] = yuv_read_one_frame(input_yuv_file, 1, width, height);
    
    transformed_image = blockbased_dct_on_image(output_image_Y, transform_blocksize);
    quantizer_matrix = get_quantisation_matrix(qp, transform_blocksize);
    quantized_image = blockbased_deadzone_quantizer_to_levels(transformed_image, quantizer_matrix);
    zigzag_scanned = blockbased_encoding_to_zigzag_scanned(quantized_image, transform_blocksize);
    zigzag_scanned = optional_dc_prediction(zigzag_scanned);
    runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);

    zigzag_scanned_reconstructed = blockbased_deadzone_dequantizer_from_levels(quantized_image, quantizer_matrix);
    reconstructed_image = blockbased_idct_on_image(zigzag_scanned_reconstructed, transform_blocksize);
    
    reconstructed_image(reconstructed_image < 0) = 0;
    reconstructed_image(reconstructed_image > 1) = 1;
    
    mse_per_frame = [mse_per_frame; mse_of_frame(output_image_Y, reconstructed_image)];
    runlevel_all_frames = [runlevel_all_frames; runlevel_representation];
    
    buffer_frame = reconstructed_image;
    frame_type = 'P';
end

if frame_type == 'P'
    for i = 2 : number_of_frames
        [output_image_Y, ~, ~] = yuv_read_one_frame(input_yuv_file, i, width, height);
        
        motion_vectors = blockbased_motion_search(output_image_Y, buffer_frame, me_blocksize, me_searchrange);
        motion_vectors_all_frames = [motion_vectors_all_frames; motion_vectors];
        predicted_motion_compensated_frame = blockbased_motion_compensation(buffer_frame, me_blocksize, me_searchrange, motion_vectors);
        
        error_frame = output_image_Y - predicted_motion_compensated_frame;
        
        transformed_image = blockbased_dct_on_image(error_frame, transform_blocksize);
        quantizer_matrix = get_quantisation_matrix(qp,transform_blocksize);
        quantized_image = blockbased_deadzone_quantizer_to_levels(transformed_image, quantizer_matrix);
        zigzag_scanned = blockbased_encoding_to_zigzag_scanned(quantized_image, transform_blocksize);
        zigzag_scanned = optional_dc_prediction(zigzag_scanned);
        runlevel_representation = blockbased_encoding_to_runlevel_representation(zigzag_scanned);

        zigzag_scanned_predicted = blockbased_deadzone_dequantizer_from_levels(quantized_image, quantizer_matrix);
        predicted_image = blockbased_idct_on_image(zigzag_scanned_predicted, transform_blocksize);
        predicted_image = predicted_image + predicted_motion_compensated_frame;

        predicted_image(predicted_image < 0) = 0;
        predicted_image(predicted_image > 1) = 1;

        mse_per_frame = [mse_per_frame; mse_of_frame(output_image_Y, predicted_image)];
        runlevel_all_frames = [runlevel_all_frames; runlevel_representation];
        
        buffer_frame = predicted_image;
    end
end

huffman_table = create_huffman_table_from_signal(runlevel_all_frames);
bitstream = bitstream_init();
bitstream = encode_signal_to_huffman_bitstream(bitstream, huffman_table, runlevel_all_frames);

huffman_table_mv = create_huffman_table_from_signal(motion_vectors_all_frames);
bitstream_mv = bitstream_init();
bitstream_mv = encode_signal_to_huffman_bitstream(bitstream_mv, huffman_table_mv, motion_vectors_all_frames);

save(coded_file, 'width', 'height', 'number_of_frames', 'transform_blocksize', 'qp', 'me_blocksize', 'me_searchrange',...
    'huffman_table', 'bitstream', 'huffman_table_mv', 'bitstream_mv');

coded_bits = bitstream_get_length(bitstream);

end