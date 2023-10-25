function [bitstream, signal] = decode_signal_from_huffman_bitstream(bitstream, huffman_table, nr_of_symbols)

switch nargin
    case 2
        nr_of_symbols = 2 ^ 128;   
end

nr_of_huffman_entries = size(huffman_table, 1);
huffman_length = zeros(size(nr_of_huffman_entries));
hyper_symbol_count = 0;
signal = [];

for i = 1 : nr_of_huffman_entries
    huffman_length(i) = size(huffman_table{i, 1}, 2);
end

min_bits = min(huffman_length);
max_bits = max(huffman_length);

for i = 1 : nr_of_symbols

    symbol_found = false;
    current_nr_of_bits = min_bits;
    
    while ((current_nr_of_bits <= max_bits) && (symbol_found == false))
       
        [this_huffman, new_bitstream] = bitstream_read_bits(bitstream, current_nr_of_bits);
        
        if (isempty(this_huffman))
            disp('End of bitstream reached.')
            break
        end
        
        symbol_row = find(huffman_length == current_nr_of_bits);
        
        for j = 1 : size(symbol_row, 2)
            if this_huffman == huffman_table{symbol_row(j), 1}
                this_symbol = huffman_table{symbol_row(j), 2};
                signal = [signal; this_symbol];
                bitstream = new_bitstream;
                symbol_found = true;
                hyper_symbol_count = hyper_symbol_count + 1;
                break  
            end
        end
            
        current_nr_of_bits = current_nr_of_bits + 1;  
    end
    
    if (symbol_found == false)
        break
    end
end

if hyper_symbol_count < nr_of_symbols 
    disp('An error has occured while reading the bitstream.')
end

end