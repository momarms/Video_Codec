clc

%Ex 2.1 to 2.6

%Load the input signal
load('input_signal_huffman.mat');

%Generate Huffman table
huffman_table = create_huffman_table_from_signal(input_signal);

%Display Huffman table
show_huffman_table(huffman_table);
%show_huffman_tree(huffman_tree);

%--------------------------------------------------------------------------
%Ex 2.7 to 2.11

%Verify encoder and decoder

