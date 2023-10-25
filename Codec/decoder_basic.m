function decoder_basic(coded_file, decoded_yuv_file)

load(coded_file, 'width', 'height', 'number_of_frames', 'transform_blocksize', 'qp', 'me_blocksize', 'me_searchrange',...
    'huffman_table', 'bitstream', 'huffman_table_mv', 'bitstream_mv');

count = 0;
start_idx = 1;
end_idx = 1;
start_mv = 1;
frame_nr = 1;
frame_type = 'I';

blocks_per_frame = (width * height) / (transform_blocksize ^ 2);
motion_vectors_per_frame = (width * height) / (me_blocksize ^ 2);
[~, runlevel_representation] = decode_signal_from_huffman_bitstream(bitstream, huffman_table);
[~, motion_vectors] = decode_signal_from_huffman_bitstream(bitstream_mv, huffman_table_mv);

if frame_type == 'I'
    for i = 1 : size(runlevel_representation, 1)
        if runlevel_representation(i, :) == [-1, -1]
            count = count + 1;
            end_idx = i; 
        end

        if count == blocks_per_frame
            runlevel_representation_per_frame = runlevel_representation(start_idx : end_idx, :);

            zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation_per_frame, transform_blocksize);
            zigzag_scanned = optional_dc_prediction_inverse(zigzag_scanned);
            input_levels = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
            quantizer_matrix = get_quantisation_matrix(qp,transform_blocksize);
            zigzag_scanned = blockbased_deadzone_dequantizer_from_levels(input_levels, quantizer_matrix);
            reconstructed_image = blockbased_idct_on_image(zigzag_scanned, transform_blocksize);

            reconstructed_image(reconstructed_image < 0) = 0;
            reconstructed_image(reconstructed_image > 1) = 1;

            % imshow(reconstructed_image);
            yuv_write_one_frame(decoded_yuv_file, frame_nr, reconstructed_image);

            count = 0;
            frame_nr = frame_nr + 1;     
            start_idx = end_idx + 1;
            frame_type = 'P';
            buffer_frame = reconstructed_image;
            
            break
        end
    end
end

if frame_type == 'P'
    for i = start_idx : size(runlevel_representation, 1)
        if runlevel_representation(i, :) == [-1, -1]
            count = count + 1;
            end_idx = i; 
        end

        if count == blocks_per_frame
            runlevel_representation_per_frame = runlevel_representation(start_idx : end_idx, :);

            motion_vector = motion_vectors(start_mv : start_mv + motion_vectors_per_frame - 1, :);
            predicted_motion_compensated_frame = blockbased_motion_compensation(buffer_frame, me_blocksize, me_searchrange, motion_vector);
            zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation_per_frame, transform_blocksize);
            zigzag_scanned = optional_dc_prediction_inverse(zigzag_scanned);
            input_levels = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
            quantizer_matrix = get_quantisation_matrix(qp,transform_blocksize);
            zigzag_scanned = blockbased_deadzone_dequantizer_from_levels(input_levels, quantizer_matrix);
            inverse_transformed_image = blockbased_idct_on_image(zigzag_scanned, transform_blocksize);
            
            reconstructed_image = predicted_motion_compensated_frame + inverse_transformed_image;
            
            reconstructed_image(reconstructed_image < 0) = 0;
            reconstructed_image(reconstructed_image > 1) = 1;
            
            % imshow(reconstructed_image);
            yuv_write_one_frame(decoded_yuv_file, frame_nr, reconstructed_image);

            count = 0;
            frame_nr = frame_nr + 1;     
            start_idx = end_idx + 1;
            start_mv = start_mv + motion_vectors_per_frame;
            buffer_frame = reconstructed_image;
        end
    end
end
end