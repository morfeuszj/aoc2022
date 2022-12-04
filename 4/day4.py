# AoC 2022 day 4
import re
fid = open("4/input.txt", 'r')
full_overlap = 0
any_overlap = 0
for line in fid:
    numbers = [int(i) for i in re.split("[,\-]", line[:-1])]
    if ((numbers[0] >= numbers[2] and numbers[1] <= numbers[3]) or 
        (numbers[0] <= numbers[2] and numbers[1] >= numbers[3])):
        full_overlap += 1
    if (numbers[1] >= numbers[2] and numbers[0] <= numbers[3]):
        any_overlap += 1
fid.close()
print(full_overlap)
print(any_overlap)