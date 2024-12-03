fileContent = fileread('input.txt');

pattern = 'do\(\)|don''t\(\)|mul\((\d{1,3}),(\d{1,3})\)';
allMatches = regexp(fileContent, pattern, 'match');

totalSumAll = 0;
totalSumEnabled = 0;
mulEnabled = true;

for i = 1:length(allMatches)
    currentInstr = allMatches{i};
    
    if strcmp(currentInstr, 'do()')
        mulEnabled = true;
    elseif strcmp(currentInstr, 'don''t()')
        mulEnabled = false;
    else
        numbers = regexp(currentInstr, 'mul\((\d{1,3}),(\d{1,3})\)', 'tokens');
        num1 = str2double(numbers{1}{1});
        num2 = str2double(numbers{1}{2});
        
        product = num1 * num2;
        
        totalSumAll = totalSumAll + product;
        
        if mulEnabled
            totalSumEnabled = totalSumEnabled + product;
        end
    end
end

fprintf('All operations: %d, Enabled operations: %d', totalSumAll, totalSumEnabled);
