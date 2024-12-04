inputStr = fileread('input.txt');
inputStr = inputStr(inputStr ~= newline);
gridSize = sqrt(length(inputStr));

grid = reshape(inputStr, gridSize, gridSize)';

% Part 1
directions = [
    0 1;   % right
    1 0;   % down
    1 1;   % down-right diagonal
    -1 1;  % up-right diagonal
];

xmasCount = 0;
target = 'XMAS';
targetLen = length(target);
revTarget = target(end:-1:1); % 'SAMX'

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

% Part 2
xmas2Count = 0;
target2 = 'MAS';
revTarget2 = target2(end:-1:1); % 'SAM'

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
    end
end

fprintf('XMAS Count: %d, X-MAS Count: %d\n', xmasCount, xmas2Count);
