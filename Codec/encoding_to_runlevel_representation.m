function runlevel_representation = encoding_to_runlevel_representation(input_vector)

runlevel_representation = [];
ind = find(input_vector);

for i = 1 : size(ind, 2)
    
    if i == 1
        if ind(1) == 1
            run = 0;
            level = input_vector(ind(1));

        elseif ind(1) > 1
            run = ind(1) - 1;
            level = input_vector(ind(1));
        end
        
        runlevel_representation = [run, level];
        
    elseif i > 1
        previous = ind(i - 1);
        current = ind(i);
        run = current - previous - 1;
        level = input_vector(current); 
        
        runlevel_representation = [runlevel_representation; run, level]; %#ok<AGROW>
    end
end

end

