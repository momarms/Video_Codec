function output_vector = decoding_from_runlevel_representation(runlevel_representation, blocksize)

output_vector = [];

for i = 1 : size(runlevel_representation, 1)
    output_vector = [output_vector, zeros(1, runlevel_representation(i, 1)), runlevel_representation(i, 2)]; %#ok<AGROW>
end
   
if size(output_vector, 2) ~= blocksize ^ 2
    output_vector = [output_vector, zeros(1, abs(size(output_vector, 2) - blocksize ^ 2))];
end

end

