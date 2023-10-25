function permutation_matrix = generate_zigzag_permutation_matrix(width, height)

permutation_matrix = zeros(height, width);

current_ind = 1;
current_row = 1;
current_col = 1;

while current_ind <= (height * width)
    
    if current_row == 1 && mod(current_row + current_col, 2) == 0 && current_col ~= width
        permutation_matrix(current_row, current_col) = current_ind;
        current_col = current_col + 1;
        current_ind = current_ind + 1;

    elseif current_col == 1 && mod(current_row + current_col, 2) ~= 0 && current_row ~= height
        permutation_matrix(current_row, current_col) = current_ind;
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_row == height && mod(current_row + current_col, 2) ~= 0 && current_col ~= width
        permutation_matrix(current_row, current_col) = current_ind;
        current_col = current_col + 1;
        current_ind = current_ind + 1;

    elseif current_col == width && mod(current_row + current_col, 2) == 0 && current_row ~= height
        permutation_matrix(current_row, current_col) = current_ind;
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_row ~= 1 && mod(current_row + current_col, 2) == 0 && current_col ~= width
        permutation_matrix(current_row, current_col) = current_ind;
        current_col = current_col + 1;
        current_row = current_row - 1;
        current_ind = current_ind + 1;

    elseif current_col ~= 1 && mod(current_row + current_col, 2) ~= 0 && current_row ~= height
        permutation_matrix(current_row, current_col) = current_ind;
        current_col = current_col - 1;
        current_row = current_row + 1;
        current_ind = current_ind + 1;

    elseif current_col == width && current_row == height
        permutation_matrix(current_row, current_col) = current_ind;
        break

    end

end

end

