% aoc day 1
clear 
clc
% read input
data = fileread("AOC2022\1\input.txt");
% split elves
ind = regexp(data, '\n\n');
ind = [1, ind, numel(data)];
split_data = cell(numel(ind)-1, 1);
sums = zeros(size(split_data));
for i = 1 : numel(ind)-1
    split_data{i} = sscanf(data(ind(i)+2 : ind(i+1)), '%d');
    sums(i) = sum(split_data{i});
end
sums(sums == max(sums)) % part 1
[value, ind_max] = maxk(sums, 3);
sum(sums(ind_max))      % part 2