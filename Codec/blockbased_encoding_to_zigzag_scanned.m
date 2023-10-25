function zigzag_scanned = blockbased_encoding_to_zigzag_scanned(input_image, block_size)

zigzag_scanned = [];
blockstart_row = 1;

for i = 1 : size(input_image, 1) / block_size
    
    blockstart_col = 1;
    
    for j = 1 : size(input_image, 2) / block_size
        
        image_block = input_image(blockstart_row : blockstart_row + block_size - 1, blockstart_col : blockstart_col + block_size - 1);
        zigzag_scanned = [zigzag_scanned; encoding_to_zigzag_scanned(image_block)];
        blockstart_col = blockstart_col + block_size;
        
    end
    
    blockstart_row = blockstart_row + block_size;
    
end

end

