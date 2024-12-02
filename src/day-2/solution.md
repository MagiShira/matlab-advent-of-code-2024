Day 2 was *significantly* more involved than Day 1 was, for me. We analyze sequences of numbers to determine if they follow a given ruleset. Each sequence is required to change in a controlled way, with the differences between adjacent numbers being required to fall within a specific range. 

Again, make sure that your input data is in the same directory as this `solution.m` file and is named `input.txt`. We scan the contents of the file, and store the result in the cell array `data`, which we then convert into a string array called `lines` where each element represents a different line from the `input.txt` file.

```matlab
fileID = fopen('input.txt', 'r');
data = textscan(fileID, '%s', 'Delimiter', '\n');
fclose(fileID);
lines = string(data{1});
```

The core of our analysis for Day 2's puzzle lies in `checkSafe`, which we use to determine if a sequence follows our rules. We declare that single numbers are automatically safe, adjacent numbers must differ by more than 1 but less than 3 units, and the sequence must maintain a constant direction. 

```matlab
function isSafe = checkSafe(numbers)
    if length(numbers) <= 1
        isSafe = true;
        return;
    end
    isValid = true;
    isIncreasing = true;
    isDecreasing = true;
    for j = 1:length(numbers)-1
        diff = numbers(j+1) - numbers(j);
        if abs(diff) < 1 || abs(diff) > 3
            isValid = false;
            break;
        end
        if diff > 0
            isDecreasing = false;
        elseif diff < 0
            isIncreasing = false;
        end
    end
    isSafe = isValid && (isIncreasing || isDecreasing);
end
```

We then count sequences in **two** different ways- crazy, right? We start by counting naturally safe sequences that follow our rules completely. Then, we implement a count that has a dampener, including sequences that can *become* safe by removine __only__ one number.

```matlab
safeCount = 0;
for i = 1:length(lines)
    numbers = str2double(split(lines(i)));
    if checkSafe(numbers)
        safeCount = safeCount + 1;
    end
end

safeCountWithDampener = 0;
for i = 1:length(lines)
    numbers = str2double(split(lines(i)));
    if checkSafe(numbers)
        safeCountWithDampener = safeCountWithDampener + 1;
        continue;
    end
    isSafeWithRemoval = false;
    for j = 1:length(numbers)
        tempNumbers = numbers([1:j-1, j+1:end]);
        if checkSafe(tempNumbers)
            isSafeWithRemoval = true;
            break;
        end
    end
    if isSafeWithRemoval
        safeCountWithDampener = safeCountWithDampener + 1;
    end
end
```

Finally, we output both counts. As a general example of the principle we apply with the dampened sequence, the sequence `[1, 3, 2, 5]` wouldn't be naturally safe, but if we remove only the 2, it becomes `[1, 3, 5]`, which *is* safe.
