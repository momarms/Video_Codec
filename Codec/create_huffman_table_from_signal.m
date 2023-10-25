function huffman_table = create_huffman_table_from_signal(input_signal)

%Count the number of hypersymbols
[x, y, z] = unique (input_signal, 'rows'); %#ok<ASGLU>
%x is the number of unique symbols
%y is the first occurence of the symbols
%z denotes the symbol in terms of an integer


symbol_count = zeros (size(x, 1), 1); %#ok<PREALL>
symbol_count = accumarray(z, 1);

%Create a probability matrix
probability_matrix = [symbol_count / sum(symbol_count), x];

%Create a Huffman table using the probability matrix
huffman_table = create_huffman_table_from_probability(probability_matrix);

end