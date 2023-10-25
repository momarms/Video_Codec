function output_image = decoding_from_zigzag_scanned(zigzag_scanned, width, height)

current_ind = 1;
current_row = 1;
current_col = 1;

while current_ind <= (height * width)
    
    if current_row == 1 && mod(current_row + current_col, 2) == 0 && current_col ~= width
        output_image(current_row, current_col) = zigzag_scanned(current_ind);
        current_col = current_col + 1;
        current_ind = current_ind + 1;

    elseif current_col == 1 && mod(current_row + current_col, 2) ~= 0 && current_row ~= height
        output_image(current_row, current_col) = zigzag_scanned(current_ind);
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_row == height && mod(current_row + current_col, 2) ~= 0 && current_col ~= width
        output_image(current_row, current_col) = zigzag_scanned(current_ind);
        current_col = current_col + 1;
        current_ind = current_ind + 1;

    elseif current_col == width && mod(current_row + current_col, 2) == 0 && current_row ~= height
        output_image(current_row, current_col) = zigzag_scanned(current_ind);
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_row ~= 1 && mod(current_row + current_col, 2) == 0 && current_col ~= width
        output_image(current_row, current_col) = zigzag_scanned(current_ind);
        current_col = current_col + 1;
        current_row = current_row - 1;
        current_ind = current_ind + 1;

    elseif current_col ~= 1 && mod(current_row + current_col, 2) ~= 0 && current_row ~= height
        output_image(current_row, current_col) = zigzag_scanned(current_ind);
        current_col = current_col - 1;
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_col == width && current_row == height
        output_image(current_row, current_col) = zigzag_scanned(current_ind);
        break

    end

end

end

