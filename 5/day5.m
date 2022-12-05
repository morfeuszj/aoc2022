% clear
% clc

data = fileread("input.txt");
eols = regexp(data,'\n');

command_start = find(data(eols(1:end-1) + 1) == 'm', 1);
stack_data = data(1:eols(command_start - 2));

n_stacks = regexp(data(eols(command_start - 2) : eols(command_start - 1)), ...
    "[0-9]", 'match');
n_stacks = str2double(n_stacks{end});
stacks_text = cell(command_start - 2, n_stacks);
eols = [0, eols];
for row = 1 : command_start - 2
    for col = 1 : n_stacks
        stacks_text{row, col} = stack_data(eols(row) - 2 + 4 * col);
    end
end
stacks_text = stacks_text(end:-1:1, :)';
stacks = cell(n_stacks, 1);
for i = 1:n_stacks
    for j = 1:size(stacks_text, 2)
        if stacks_text{i, j} == ' '
            break
        end
        stacks{i}(j) = stacks_text{i, j};
    end
end

for i = command_start+1 : numel(eols) - 1
    line = data(eols(i) + 1 : eols(i+1));
    n = str2double(regexp(line, "(?<=move)(.*)(?=from)", "match"));
    from = str2double(regexp(line, "(?<=from)(.*)(?=to)", "match"));
    to = str2double(regexp(line, "(?<=to).*$", "match"));
%     stacks = move(stacks, from, to, n);
    stacks = move2(stacks, from, to, n);
end
answer = '';
for i = 1 : numel(stacks)
    answer(end + 1) = char(stacks{i}(end));
end
answer
function stacks = move(stacks, from, to, n)
moved_part = stacks{from}(end-n+1 : end);
stacks{from} = stacks{from}(1:end-n);
stacks{to} = [stacks{to}, flip(moved_part)];
end
function stacks = move2(stacks, from, to, n)
moved_part = stacks{from}(end-n+1 : end);
stacks{from} = stacks{from}(1:end-n);
stacks{to} = [stacks{to}, moved_part];
end
