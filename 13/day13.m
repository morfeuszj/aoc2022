lines = char(readlines("input.txt"));

lines(lines == '[') = '{';
lines(lines == ']') = '}';
correct = false(ceil(size(lines,1)/3),1);
for i = 1:3:size(lines,1)
    left = eval(lines(i, :));
    right = eval(lines(i + 1, :));
    correct(ceil(i/3)) = compare(left, right) == 'l';
end

sum(find(correct))
lines = lines([1:3:size(lines,1), 2:3:size(lines,1)], :);
lines(end+1, 1:5) = '{{2}}';
lines(end+1, 1:5) = '{{6}}';
% bubble sort cause i cant be bothered to do it better
sorted = false(size(lines,1) - 1, 1);
while ~all(sorted)
    for i = 1 : size(lines, 1) - 1
        left = eval(lines(i, :));
        right = eval(lines(i + 1, :));
        if compare(left, right) == 'r'
            sorted(i) = false;
            tmp = lines(i, :);
            lines(i, :) = lines(i+1, :);
            lines(i+1, :) = tmp;
        else
            sorted(i) = true;
        end
    end
end
find(strcmp(string(lines(:, 1:5)), "{{2}}")) ...
    * find(strcmp(string(lines(:, 1:5)), "{{6}}"))
function res = compare(left, right)
res = 'n';
for j = 1 : min(numel(left), numel(right))
    if isnumeric(left{j})
        if isnumeric(right{j})
            if left{j} < right{j}
                res = 'l';
            elseif left{j} > right{j}
                res = 'r';
            else
                % continue
            end
        else
            res = compare(left(j), right{j});
        end
    else
        if isnumeric(right{j})
            res = compare(left{j}, right(j));
        else
            res = compare(left{j}, right{j});
        end
    end
    if res ~= 'n'
        return
    end
end

if res == 'n' 
    if numel(left) < numel(right)
        res = 'l';
    elseif numel(left) > numel(right)
        res = 'r';
    end
end

end