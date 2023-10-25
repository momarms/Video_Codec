function final_encoder(input_yuv_file, coded_file, width, height, number_of_frames, qp)

transform_blocksize = 8;
me_blocksize = 16;
me_searchrange = 8;

[~, ~] = encoder_basic(input_yuv_file, coded_file, width, height, number_of_frames, transform_blocksize, qp, me_blocksize, me_searchrange);

end