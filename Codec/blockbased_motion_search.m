function motion_vectors = blockbased_motion_search(input_image, previous_image, blocksize, searchrange)

[height, width] = size(input_image);
motion_vectors = [];

padded_current = padarray(input_image, [searchrange, searchrange], 'replicate', 'both');
padded_reference = padarray(previous_image, [searchrange, searchrange], 'replicate', 'both');

for blockstart_y = searchrange + 1 : blocksize : height - blocksize + searchrange + 1
    for blockstart_x = searchrange + 1 : blocksize : width - blocksize + searchrange + 1
        this_motion_vector = get_motion_vector_for_block(padded_current, padded_reference, blockstart_x, blockstart_y, blocksize, searchrange);
        motion_vectors = [motion_vectors; this_motion_vector];
    end
end
 
% 
% block_rows = size(input_image, 1) / blocksize;
% block_columns = size(input_image, 2) / blocksize;
% 
% blockstart_y = searchrange + 1;
% 
% for i = 1 : block_rows
%     blockstart_x = searchrange + 1;
%     
%     for j = 1 : block_columns
%         mv = get_motion_vector_for_block(padded_current, padded_reference, blockstart_x, blockstart_y, blocksize, searchrange);
%         motion_vectors = [motion_vectors; mv];
%         blockstart_x = blockstart_x + blocksize;
%     end
%     
%     blockstart_y = blockstart_y + blocksize; 
% end
end