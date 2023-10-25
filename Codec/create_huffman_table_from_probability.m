function huffman_table = create_huffman_table_from_probability(par_probability_matrix)

%Sort the probability matrix. Lowest probability at the top 
sorted_probability_matrix = sortrows(par_probability_matrix);

%Find the unique number of codewords
nr_of_codewords = size(sorted_probability_matrix, 1);

%Create cell arrays for Huffman table and tree
huffman_table = cell(nr_of_codewords, 2);
for i = 1 : nr_of_codewords
    huffman_table{i, 2} = sorted_probability_matrix(i, 2 : end);
end

huffman_tree = cell(nr_of_codewords, 2);
for i = 1 : nr_of_codewords
    huffman_tree{i, 1} = sorted_probability_matrix(i, 1);
    huffman_tree{i, 2} = i;
end

%Fill the Huffman table and tree iteratively
while(size(huffman_tree, 1) > 1)
    for i = 1 : size(huffman_tree{1, 2}, 2)
    huffman_table{huffman_tree{1, 2}(i), 1} = [1 huffman_table{huffman_tree{1,2}(i),1}];%need a vector here
    end
    
    for i = 1 : size(huffman_tree{2,2}, 2)
    huffman_table{huffman_tree{2,2}(i), 1} = [0 huffman_table{huffman_tree{2, 2}(i), 1}];
    end

    new_huffman_tree = cell((size(huffman_tree, 1)) - 1, 2); %current huffman tree size -1
    new_huffman_tree{1,1} = huffman_tree{1,1} + huffman_tree{2,1};
    new_huffman_tree{1,2} = [huffman_tree{1,2} huffman_tree{2,2}];
    
    for i = 2 : size(huffman_tree, 1) - 1
        new_huffman_tree{i, 1} = huffman_tree{i+1, 1};
        new_huffman_tree{i, 2} = huffman_tree{i+1, 2};
    end

    huffman_tree = cell(size(new_huffman_tree)); %overwriting original huffman tree
    new_probabilities = [new_huffman_tree{:, 1}];
    [new_probabilities I] = sort(new_probabilities);
    for i = 1:size(new_huffman_tree)
        huffman_tree{i, 1} = new_probabilities(i); 
        huffman_tree{i, 2} = new_huffman_tree{I(i), 2};
    end
%show_huffman_table(huffman_table)
%show_huffman_tree(huffman_tree)
end
end