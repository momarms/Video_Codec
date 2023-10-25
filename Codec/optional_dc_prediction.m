function zigzag_scanned = optional_dc_prediction(zigzag_scanned)

previous = zigzag_scanned (1, 1);

for i = 2 : size(zigzag_scanned, 1)
    current = zigzag_scanned(i, 1);
    zigzag_scanned(i, 1) = current - previous;
    previous = current;
end
end

