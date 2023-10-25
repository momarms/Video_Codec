function decoder_basic_intra(coded_file, decoded_yuv_file)

load(coded_file, 'width', 'height', 'transform_blocksize', 'qp', 'huffman_table', 'bitstream');

count = 0;
start_idx = 1;
end_idx = 1;
frame_nr = 1;

blocks_per_frame = (width * height) / (transform_blocksize ^ 2);
[~, runlevel_representation] = decode_signal_from_huffman_bitstream(bitstream, huffman_table);

for i = 1 : size(runlevel_representation, 1)
    if runlevel_representation(i, :) == [-1, -1]
        count = count + 1;
        end_idx = i; 
    end
    
    if count == blocks_per_frame
        runlevel_representation_per_frame = runlevel_representation(start_idx : end_idx, :);

        zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation_per_frame, transform_blocksize);
        input_levels = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, transform_blocksize, width, height);
        quantizer_matrix = get_quantisation_matrix(qp,transform_blocksize);
        zigzag_scanned = blockbased_dequantizer_from_levels(input_levels, quantizer_matrix);
        reconstructed_image = blockbased_idct_on_image(zigzag_scanned, transform_blocksize);

        reconstructed_image(reconstructed_image < 0) = 0;
        reconstructed_image(reconstructed_image > 1) = 1;
        
        imshow(reconstructed_image);
        yuv_write_one_frame(decoded_yuv_file, frame_nr, reconstructed_image);
        
        count = 0;
        frame_nr = frame_nr + 1;     
        start_idx = end_idx + 1;
    end
end
end