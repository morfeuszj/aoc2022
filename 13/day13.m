lines = char(readlines("input.txt"));

lines(lines == '[') = '{';
lines(lines == ']') = '}';
correct = false(size(lines,1),1);
for i = 1:3:size(lines,1)
    left = eval(lines(i, :));
    right = eval(lines(i + 1, :));
    correct(ceil(i/3)) = compare(left, right);
end
% find(correct)
sum(find(correct))

function res = compare(left, right)
res = false;
for j = 1 : min(numel(left), numel(right))
    if isnumeric(left{j})
        if isnumeric(right{j})
            if left{j} < right{j}
                res = true;
                return
            elseif left{j} > right{j}
                res = false;
                return
            else
                % continue
            end
        else
            res = compare(left(j), right{j});
            if res 
                return
            end
        end
    else
        if isnumeric(right{j})
            res = compare(left{j}, right(j));
            if res
                return
            end
        else
            res = compare(left{j}, right{j});
            if res
                return
            end
        end
    end
end

if ~res && numel(left) < numel(right)
    res = true;
end

end