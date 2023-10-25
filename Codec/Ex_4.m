% Ex 4.1
[y_reference, y_current] = create_mv_test_matrix;
sad = calculate_sad(y_reference(5 : 6, 3 : 4), y_current(5 : 6, 3 : 4));

% Ex 4.2

% Pad the image with reference to the given blocksize
blocksize = 2;
searchrange = 8;
blockstart_x = 3;
blockstart_y = 5;
padded_current_image = padarray(y_current, [searchrange, searchrange], 'replicate', 'both');
padded_reference_image = padarray(y_reference, [searchrange, searchrange], 'replicate', 'both');

% Test motion vector
motion_vector = get_motion_vector_for_block(padded_current_image, padded_reference_image, blockstart_x + searchrange, blockstart_y + searchrange, blocksize, searchrange);

%Plot and compare the two images
figure('name', 'Motion Estimation');
subplot(1, 2, 1);
imshow(padded_reference_image, [0 255]);
title('Reference Image');
subplot(1, 2, 2);
imshow(padded_current_image, [0 255]);
title('Current Image');

%%

% Ex 4.3

height = 288;
width = 352;
dx = 2;
dy = 2;
blocksize = 16;
searchrange = 8;

[img1, img2] = create_synthetic_images(height, width, dx, dy);
motion_vectors = blockbased_motion_search(img1, img2, blocksize, searchrange);
plot_motion_vectors(height, width, blocksize, searchrange, motion_vectors);

%%

% Ex 4.4

height = 288;
width = 352;
input_image_reference = yuv_read_one_frame('flowergarden_short_cif.yuv', 1, height, width);
input_image_current = yuv_read_one_frame('flowergarden_short_cif.yuv', 2, height, width);
blocksize = 16;
searchrange = 8;

motion_compensated_frame = verify_motion_compensation;
motion_vectors = blockbased_motion_search(input_image_current, input_image_reference, blocksize, searchrange);
plot_motion_vectors(height, width, blocksize, searchrange, motion_vectors);
output_image = blockbased_motion_compensation(input_image_reference, blocksize, searchrange, motion_vectors);

load('flower_motion.mat')
error_flower_motion = sum(motion_vectors_flower - motion_vectors, 'all');

error = sum(output_image - motion_compensated_frame, 'all');

find(output_image ~= motion_compensated_frame);
t = find(motion_vectors ~= motion_vectors_flower);