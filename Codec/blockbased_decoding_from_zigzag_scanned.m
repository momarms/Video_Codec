function output_image = blockbased_decoding_from_zigzag_scanned(zigzag_scanned, block_size, width, height)

blockstart_row = 1;
zigzag_ind = 0;

for i = 1 : height / block_size
    
    blockstart_col = 1;
    
    for j = 1 : width / block_size
        
        zigzag_ind = zigzag_ind + 1;
        output_image(blockstart_row : blockstart_row + block_size - 1, blockstart_col : blockstart_col + block_size - 1) = decoding_from_zigzag_scanned(zigzag_scanned(zigzag_ind, :), block_size, block_size);
        blockstart_col = blockstart_col + block_size;
        
    end
    
    blockstart_row = blockstart_row + block_size;
    
end

end

