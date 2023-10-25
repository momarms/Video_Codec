function motion_compensated_frame = blockbased_motion_compensation(input_image, blocksize, searchrange, motion_vectors)

[height, width] = size(input_image);
padded_image = padarray(input_image, [searchrange, searchrange], 'replicate', 'both');
motion_compensated_frame = zeros(height, width);

motion_vector_idx = 1;

for output_blockstart_y = 1 : blocksize : height
    for output_blockstart_x = 1 : blocksize : width
        
        input_blockstart_y = output_blockstart_y + searchrange + motion_vectors(motion_vector_idx, 1);
        input_blockstart_x = output_blockstart_x + searchrange + motion_vectors(motion_vector_idx, 2);
        
        motion_compensated_frame(output_blockstart_y : (output_blockstart_y + blocksize - 1), output_blockstart_x : (output_blockstart_x + blocksize - 1) )= padded_image(input_blockstart_y : (input_blockstart_y + blocksize - 1), input_blockstart_x : (input_blockstart_x + blocksize - 1));
        
        motion_vector_idx = motion_vector_idx + 1;
    end
end

% padded_image = padarray(input_image, [searchrange, searchrange], 'replicate', 'both');
% motion_compensated_frame = zeros(size(padded_image, 1), size(padded_image, 2));
% 
% block_rows = size(input_image, 1) / blocksize;
% block_columns = size(input_image, 2) / blocksize;
% 
% blockstart_y = searchrange + 1;
% 
% x = 1;
% 
% for i = 1 : block_rows
%     blockstart_x = searchrange + 1;
%     
%     for j = 1 : block_columns
%         motion_compensated_frame(blockstart_y : blockstart_y + blocksize - 1, blockstart_x : blockstart_x + blocksize - 1) = padded_image(blockstart_y + motion_vectors(x, 1) : blockstart_y + blocksize + motion_vectors(x, 1) - 1, blockstart_x + motion_vectors(x, 2) : blockstart_x + blocksize + motion_vectors(x, 2) - 1);
%         blockstart_x = blockstart_x+blocksize;
%         x = x + 1;
%     end
%     
%     blockstart_y = blockstart_y + blocksize;
% end
% 
% motion_compensated_frame = motion_compensated_frame(1 + searchrange : size(input_image, 1) + searchrange, 1 + searchrange : size(input_image, 2) + searchrange);
end