import numpy as np

forest = np.genfromtxt('8/input.txt', delimiter = 1)

visible = np.zeros_like(forest)
nrows = np.size(forest, 0)
ncols = np.size(forest, 1)

# check visibility in rows
for i in range(nrows):
    max_height_l = -1
    max_height_r = -1
    for j in range(ncols):
        if forest[i, j] > max_height_l:
            visible[i, j] = 1
            max_height_l = forest[i,j]
        if forest[i, -j-1] > max_height_r:
            visible[i, -j-1] = 1
            max_height_r = forest[i, -j-1]
# check visibility in cols
for j in range(ncols):
    max_height_t = -1
    max_height_b = -1
    for i in range(nrows):
        if forest[i, j] > max_height_t:
            visible[i, j] = 1
            max_height_t = forest[i,j]
        if forest[-i-1, j] > max_height_b:
            visible[-i-1, j] = 1
            max_height_b = forest[-i-1, j]

print(np.sum(visible))

# part 2
l_sight = np.zeros_like(forest)
r_sight = np.zeros_like(forest)
t_sight = np.zeros_like(forest)
b_sight = np.zeros_like(forest)

for row in range(nrows):
    for col in range(ncols):
        for i in range(col+1, ncols):
            if forest[row, i] >= forest[row, col]:
                r_sight[row, col] = i - col
                break
            r_sight[row, col] = ncols - col - 1
        for i in range(1, col+1):
            if forest[row, col-i] >= forest[row, col]:
                l_sight[row, col] = i
                break
            l_sight[row, col] = col
        for i in range(row+1, nrows):
            if forest[i, col] >= forest[row, col]:
                b_sight[row, col] = i - row
                break
            b_sight[row, col] = nrows - row - 1
        for i in range(1, row+1):
            if forest[row-i, col] >= forest[row, col]:
                t_sight[row, col] = i
                break
            t_sight[row, col] = row

print(np.max(l_sight * r_sight * t_sight * b_sight))