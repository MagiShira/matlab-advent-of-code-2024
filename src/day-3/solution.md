In Day 3's puzzle, we are working with a sequence of instructions that control multiplication operations. Our input file contains three types of commands: do(), don't(), and mul(x,y). Our goal is to process these instructions and calculate two different sums of products, based on whether an operation is enabled or disabled.

As always, this solution must be run in the same directory as your input, which should be in a file called `input.txt`. We start by reading the contents of our input, and setup a regex pattern to identify each operation.

```matlab
fileContent = fileread('input.txt');
pattern = 'do\(\)|don''t\(\)|mul\((\d{1,3}),(\d{1,3})\)';
allMatches = regexp(fileContent, pattern, 'match');
```

The pattern we use matches either do(), don't(), or multiplication instructions in the format mul(x,y) where x and y are 1-3 digit numbers.

Today's solution is special to me- I was able to figure out the solution for Part 2 whilst setting up my Part 1 solution, as I noticed the input file had more operations than just `mul(x,y)`, and these extra operations didn't look like nonsense to me. I set up two sums one for all `mul(x,y)` operations, and one for `mul(x,y)` operations *only* when a `do()` condition is active, but in my original run, I  assued that we started with a `don't()` condition. When I got to part 2, I am *very* lucky that I read over it's instructions to double check or I would've got hit in the face with the solution cooldown. With all that being said- I am proud to say that I was ranked 61st **__globally__** for completing both parts! I digress. As I just stated, we track two different sums, `totalSumAll`, recording *all* products regardless of state, whereas `totalSumEnabled` only includes multiplications that occur when enabled, (i.e., during an active `do()` condition). To track this, I use the boolean `mulEnabled` to track the `do()` and `don't()` conditions.

```matlab
totalSumAll = 0;
totalSumEnabled = 0;
mulEnabled = true;
```

The core of our solution today is a `for` loop. For each instruction, we:
1. Check if it is a control instruction, which updates `mulEnabled`.
2. Check if it is a valid `mul(x,y)` operation.
3. If so, extract `x` and `y`, and perform `x*y`.
4. Add the result to the appropriate sum(s) based on the state of `mulEnabled`.

```matlab
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
```

As an example of how this works, consider the sequence `do()` `mul(2,3)` `don't()` `mul(4,5)`. The first multiplication (2\*3=6) would be included in both sums since it occurs while multiplication is enabled. However, the second multiplication (4*5=20) would only be included in `totalSumAll` since it occurs after `the don't()` instruction. At the end, `totalSumAll` would be 26 while `totalSumEnabled` would be 6. 
Finally, we output both our sums.
