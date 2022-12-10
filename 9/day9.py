import numpy as np

fid = open("9/test.txt", 'r')
H = np.zeros([1,2], np.int16)
T = H.copy()
visited = T.copy()
for line in fid:
    dir = line[0]
    if dir == 'U':
        dir = [0,1]
    elif dir == 'D':
        dir = [0,-1]
    elif dir == 'R':
        dir = [1,0]
    elif dir == 'L':
        dir = [-1,0]
    else:
        print("unknown command")
    n = int(line[2:])
    for i in range(n):
        old_H = H
        H = H + dir
        if np.any(np.abs(H - T) > 1):
            T = old_H
        if not((T[:, None] == visited).all(-1).any(-1)): # row-wise is T member of visited
            visited = np.vstack([visited, T])

print(np.size(visited, 0))
fid.close()
#%% part 2
fid = open("9/input.txt", 'r')
H = np.zeros([1,2], np.int16)
rope = np.zeros([9,2], np.int16)
visited = np.zeros([1,2], np.int16)

for line in fid:
    dir = line[0]
    if dir == 'U':
        dir = [0,1]
    elif dir == 'D':
        dir = [0,-1]
    elif dir == 'R':
        dir = [1,0]
    elif dir == 'L':
        dir = [-1,0]
    else:
        print("unknown command")
    n = int(line[2:])
    for i in range(n):
        old_H = H
        H = H + dir
        if np.any(np.abs(H - rope[0,:]) > 1):
            rope[0,:] = old_H
        for i in range(1,9):
            if np.any(np.abs(rope[i,:] - rope[i-1,:]) > 1):
                rope[i,:] = rope[i,:] + np.sign(rope[i-1,:] - rope[i,:])
        if not((rope[-1, None] == visited).all(-1).any(-1)): # row-wise is T member of visited
            visited = np.vstack([visited, rope[-1, :]])
fid.close()
# print(visited)
print(np.size(visited, 0))