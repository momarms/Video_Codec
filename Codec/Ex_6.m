% Ex 6.6

input_yuv_file = 'flowergarden_short_cif.yuv';
width = 352;
height = 288;
number_of_frames = 5;
transform_blocksize = 8;
qp = [6 8 10 15 20];
coded_file = 'coded_file.mat';
decoded_yuv_file = 'decoded_yuv_file.yuv';

[rate,psnr,enc_time,dec_time] = get_dr_result_intra('encoder_basic_intra', 'decoder_basic_intra', ...
    input_yuv_file, qp, transform_blocksize);

%%

% Ex 6.10 - 6.14

input_yuv_file = 'flowergarden_short_cif.yuv';
% input_yuv_file = 'rugby_short_cif.yuv';
% input_yuv_file = 'shuttle_short_cif.yuv';
% input_yuv_file = 'vimto_short_cif.yuv';

width = 352;
height = 288;
number_of_frames = 5;
transform_blocksize = 8;
qp = 8;
qp_values = [6 8 10 15 20];
coded_file = 'coded_file.mat';
decoded_yuv_file = 'decoded_yuv_file.yuv';
me_searchrange = 8;
me_blocksize = 16;

[rate,psnr,enc_time,dec_time] = get_dr_result('encoder_basic', 'decoder_basic', ...
    input_yuv_file, qp_values, transform_blocksize, me_searchrange,me_blocksize);

%%

% Ex 6.15

input_yuv_file = 'rugby_short_cif.yuv';
coded_file = 'rugby_q12.mat';
width = 352;
height = 288;
number_of_frames = 5;
qp = 8;

tic;
final_encoder(input_yuv_file, coded_file, width, height, number_of_frames, qp)
toc

%%

% Ex 6.17

[~] = get_final_result('rugby_short_cif.yuv');
[~] = get_final_result('shuttle_short_cif.yuv');
[~] = get_final_result('vimto_short_cif.yuv');