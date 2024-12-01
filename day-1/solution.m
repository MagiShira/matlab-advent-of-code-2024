data = readmatrix('input.txt');
similarity_score = 0;
left_list = data(:,1);
right_list = data(:,2);

for i = 1:length(left_list)
    current_num = left_list(i);
    
    appearances = sum(right_list == current_num);
    
    similarity_score = similarity_score + (current_num * appearances);
end

sorted_left = sort(left_list);
sorted_right = sort(right_list);

differences = abs(sorted_left - sorted_right);

total_distance = sum(differences);

fprintf('Total distance: %d, Similarity score: %d', total_distance, similarity_score)
