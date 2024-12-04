On Day 4, we are tasked with finding patterns in a 2D grid, "XMAS" in part 1, and a special "X-MAS" pattern in part 2.

Unfortunately, I ended up sleeping past 9 PM Pacific when today's problem opened, so my solve was in the 10k rankings. Nevertheless, as always, this solution expects to be run in the same folder as your input, which should be a text file named `input.txt`.

First, we read our data and prepare it as a grid, by importing `input.txt` as a single string, removing any newlines, and reshaping the string into a square grid. We acomplish this by taking the square root of the input length to determine the grid size, and using the `reshape()` function in MATLAB with `inputStr` and `gridSize` as arguments to form a perfect square grid.

```matlab
inputStr = fileread('input.txt');
inputStr = inputStr(inputStr ~= newline);
gridSize = sqrt(length(inputStr));
grid = reshape(inputStr, gridSize, gridSize)';
```

After this, we define our directions as a matrix where each row represents a direction vector, as shown below. The first element in each row (i.e., 0 for the right direction) corresponds to movement across rows, or vertical movement. The second element (i.e., 1 for the right direction) represents movement across columns, or horizontal movement.

```matlab
directions = [
    0 1;   % right
    1 0;   % down
    1 1;   % down-right diagonal
    -1 1;  % up-right diagonal
];
```

We then initialize our counter and declare our target phrase.

```matlab
xmasCount = 0;
target = 'XMAS';
targetLen = length(target);
revTarget = target(end:-1:1); % 'SAMX'
```

The core of our solution today uses nested loops to check every possible starting position and direction of the input file. We loop through every position in the grid to check in each of our four defined directions to see if our target, `XMAS` or its reverse, `SAMX` appears.

```matlab
for i = 1:gridSize
    for j = 1:gridSize
        for d = 1:size(directions, 1)
            di = directions(d, 1);
            dj = directions(d, 2);
            if (i + (targetLen-1)*di >= 1) && (i + (targetLen-1)*di <= gridSize) && ...
               (j + (targetLen-1)*dj >= 1) && (j + (targetLen-1)*dj <= gridSize)
                word = '';
                for k = 0:targetLen-1
                    word(k+1) = grid(i + k*di, j + k*dj);
                end
                if strcmp(word, target) || strcmp(word, revTarget)
                    xmasCount = xmasCount + 1;
                end
            end
        end
    end
end
```

Part 2 has us looking for a specific pattern where `MAS` (or `SAM`0 form an X shape on the grid with `A` in the center, as shown below.

```
M  M
 A
S  S
```

We initialize a new counter and declare our new target phrase.

```matlab
xmas2Count = 0;
target2 = 'MAS';
revTarget2 = target2(end:-1:1); % 'SAM'
```

Then, we set up another set of nested loops. Firstly, we set up one that only checks for interior positions (avoiding the edges,) and searches for positions with an  `A`. We then look for valid X-patterns.

```matlab
for i = 2:(gridSize-1)
    for j = 2:(gridSize-1)
        if grid(i,j) ~= 'A'
            continue;
        end
	for direction1 = 1:2
            for direction2 = 1:2
                diagonal1 = [grid(i-1,j-1), grid(i,j), grid(i+1,j+1)];
                diagonal2 = [grid(i-1,j+1), grid(i,j), grid(i+1,j-1)];
                target1 = target2;
                if direction1 == 2
                    target1 = revTarget2;
                end
                target2_temp = target2;
                if direction2 == 2
                    target2_temp = revTarget2;
                end
                if strcmp(diagonal1, target1) && strcmp(diagonal2, target2_temp)
                    xmas2Count = xmas2Count + 1;
                end
            end
        end
```

Finally, we output our results, `xmasCount` and `xmas2Count`.
