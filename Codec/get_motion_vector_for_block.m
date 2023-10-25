function motion_vector = get_motion_vector_for_block(padded_input_image, padded_previous_image, blockstart_x, blockstart_y, blocksize, searchrange)

% Take the input image block
current_block = padded_input_image(blockstart_y : blockstart_y + blocksize - 1, blockstart_x : blockstart_x + blocksize - 1);

% Do blockwise comparison with reference frame, compute minimum SAD and
% it's corresponding motion vector
sad_min = Inf;

for dm = - searchrange : searchrange
    for dn = - searchrange : searchrange
        candidate_start_x = blockstart_x + dn;
        candidate_start_y = blockstart_y + dm;
        
        candidate_block = padded_previous_image(candidate_start_y : (candidate_start_y + blocksize - 1), candidate_start_x : (candidate_start_x + blocksize - 1));
        candidate_sad = calculate_sad(current_block, candidate_block);
   
        if (candidate_sad < sad_min)
            sad_min = candidate_sad;
            motion_vector = [dm, dn];
        end
    end
end
end