function zigzag_scanned = encoding_to_zigzag_scanned(input_image)

height = size(input_image, 1);
width = size(input_image, 2);

current_ind = 1;
current_row = 1;
current_col = 1;

while current_ind <= (height * width)
    
    if current_row == 1 && mod(current_row + current_col, 2) == 0 && current_col ~= width
        zigzag_scanned(current_ind) = input_image(current_row, current_col);
        current_col = current_col + 1;
        current_ind = current_ind + 1;

    elseif current_col == 1 && mod(current_row + current_col, 2) ~= 0 && current_row ~= height
        zigzag_scanned(current_ind) = input_image(current_row, current_col);
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_row == height && mod(current_row + current_col, 2) ~= 0 && current_col ~= width
        zigzag_scanned(current_ind) = input_image(current_row, current_col);
        current_col = current_col + 1;
        current_ind = current_ind + 1;

    elseif current_col == width && mod(current_row + current_col, 2) == 0 && current_row ~= height
        zigzag_scanned(current_ind) = input_image(current_row, current_col);
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_row ~= 1 && mod(current_row + current_col, 2) == 0 && current_col ~= width
        zigzag_scanned(current_ind) = input_image(current_row, current_col);
        current_col = current_col + 1;
        current_row = current_row - 1;
        current_ind = current_ind + 1;

    elseif current_col ~= 1 && mod(current_row + current_col, 2) ~= 0 && current_row ~= height
        zigzag_scanned(current_ind) = input_image(current_row, current_col);
        current_col = current_col - 1;
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_col == width && current_row == height
        zigzag_scanned(current_ind) = input_image(current_row, current_col);
        break

    end

end

end

