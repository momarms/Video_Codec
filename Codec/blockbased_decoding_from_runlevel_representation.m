function zigzag_scanned = blockbased_decoding_from_runlevel_representation(runlevel_representation, blocksize)

zigzag_scanned = [];
block_start = 0;

for i = 1 : size(runlevel_representation, 1)
  if runlevel_representation(i, :) == [-1, -1] %#ok<BDSCA>
      block_end = i - 1;
      current_block = runlevel_representation(block_start + 1 : block_end, :);
      zigzag_scanned = [zigzag_scanned; decoding_from_runlevel_representation(current_block, blocksize)]; %#ok<AGROW>
      block_start = i;
  end
end

end