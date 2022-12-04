# aoc day 3
# part 1
import numpy as np
fid = open("input.txt", 'r')
backpacks = []
n_elems = []
repeated_item = []
for line in fid:
    used_chars_1 = np.zeros(128)
    used_chars_2 = np.zeros(128)
    backpacks.append(line[:-1])
    n_elems.append(len(line) - 1)
    for character in backpacks[-1][: int(n_elems[-1] / 2)]:
        used_chars_1[ord(character)] = 1
    for character in backpacks[-1][int(n_elems[-1] / 2) :]:
        used_chars_2[ord(character)] = 1
    repeated_item.append(np.nonzero(np.logical_and(used_chars_1, used_chars_2)))
    repeated_item[-1] = repeated_item[-1][0]
fid.close()

sum_priority = 0

for item in repeated_item:
    if item[0] >= ord('a') and item[0] <= ord('z'):
        sum_priority += item[0] - ord('a') + 1
    elif item[0] >= ord('A') and item[0] <= ord('Z'):
        sum_priority += item[0] - ord('A') + 27

print(sum_priority)

# part 2
group_item = []
for iter in range(0, len(backpacks), 3):
    used_chars_1 = np.zeros(128)
    used_chars_2 = np.zeros(128)
    used_chars_3 = np.zeros(128)
    for character in backpacks[iter]:
        used_chars_1[ord(character)] = 1
    for character in backpacks[iter + 1]:
        used_chars_2[ord(character)] = 1
    for character in backpacks[iter + 2]:
        used_chars_3[ord(character)] = 1
    group_item.append(np.nonzero(np.logical_and(np.logical_and(
        used_chars_1, used_chars_2), used_chars_3)))
    group_item[-1] = group_item[-1][0]

sum_group = 0

for item in group_item:
    if item[0] >= ord('a') and item[0] <= ord('z'):
        sum_group += item[0] - ord('a') + 1
    elif item[0] >= ord('A') and item[0] <= ord('Z'):
        sum_group += item[0] - ord('A') + 27

print(sum_group)
