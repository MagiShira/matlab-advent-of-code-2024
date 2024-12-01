> We are asked to compare two lists of numbers in two different ways:
> 1. How different are they based on their sorted positions (i.e., their total distance), and
> 2. How similar are they based on shared values (i.e., their similarity score).

Day 1 was relatively easy. We are analyzing two lists of numbers, which should be in a file in the same directory as solution.m named 'input.txt'. We setup the program to read data by importing 'input.txt' into a matrix we called 'data'.

We then create two lists from this data, `left_list` from the first column, and `right_list` from the second. We calculate a similarity score by taking a number from the left list, counting how many times it appears in the right list, multiplying the number by its count of appearances, and adding the product to the running total.
```matlab
similarity_score = 0;
for i = 1:length(left_list)
    current_num = left_list(i);
    appearances = sum(right_list == current_num);
    similarity_score = similarity_score + (current_num * appearances);
end
```

We calculate the total distance by sorting both lists, finding the absolute differences between the corresponding elements, and summing all the differences.
```matlab
sorted_left = sort(left_list);
sorted_right = sort(right_list);
differences = abs(sorted_left - sorted_right);
total_distance = sum(differences);
```

Then, we print both metrics.


