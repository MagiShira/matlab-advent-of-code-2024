fileID = fopen('input.txt', 'r');
data = textscan(fileID, '%s', 'Delimiter', '\n');
fclose(fileID);

lines = string(data{1});

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

fprintf('Natural: %d, Dampener: %d\n', safeCount, safeCountWithDampener);
