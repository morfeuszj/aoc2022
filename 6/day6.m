data = fileread("input.txt");

n1 = 4;
n2 = 14;

for i = n2:numel(data)
    used_chars = data(i-n2+1:i);
    if numel(unique(used_chars)) == n2
        break
    end
end
i