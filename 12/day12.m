strmap = readlines("input.txt");
strmap = strmap(strlength(strmap) > 0);

map = char(strmap);
[start_row, start_col] = find(map == 'S');
map(map == 'S') = 'a';
[end_row, end_col] = find(map == 'E');
map(map == 'E') = 'z';
map = map - 'a';

dist = inf(size(map));
dist(end_row, end_col) = 0;

while isinf(dist(start_row, start_col))
    dist = doStep(map, dist);
end
dist(start_row, start_col)

min(dist(map == 0))

function new_dist = doStep(map, dist)
new_dist = dist;
start_ind = find(~isinf(dist));
[nrows, ncols] = size(map);
for ind = start_ind(:)'
    [row, col] = ind2sub([nrows, ncols], ind);
    if row > 1 
        if map(row, col) - map(row-1, col) <= 1
            d = dist(row, col) + 1;
            if d < new_dist(row-1, col)
                new_dist(row-1, col) = d;
            end
        end
    end
    if row < nrows 
        if map(row, col) - map(row+1, col) <= 1
            d = dist(row, col) + 1;
            if d < new_dist(row+1, col)
                new_dist(row+1, col) = d;
            end
        end
    end
    if col > 1 
        if map(row, col) - map(row, col-1) <= 1
            d = dist(row, col) + 1;
            if d < new_dist(row, col-1)
                new_dist(row, col-1) = d;
            end
        end
    end
    if col < ncols 
        if map(row, col) - map(row, col+1) <= 1
            d = dist(row, col) + 1;
            if d < new_dist(row, col+1)
                new_dist(row, col+1) = d;
            end
        end
    end
end
end