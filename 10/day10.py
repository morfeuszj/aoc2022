import numpy as np

X = [1]
T = 0

fid = open("10/input.txt", 'r')

for line in fid:
    if line[:4] == "noop":
        T = T + 1
        X.append(X[-1])
    elif line[:4] == "addx":
        X.append(X[-1])
        X.append(X[-1] + int(line[4:]))
        T = T + 2
fid.close()
sum = 0
for i in range(20,221,40):
    sum = sum + X[i-1] * i
print(sum)
power = np.reshape(X[:-1], (6, 40))
timing = np.reshape(np.mod(np.arange(240), 40), (6,40))
# print((np.abs(timing - power) <= 1) * 1)

for i in range(6):
    line = " " * 40
    for j in range(40):
        if np.abs(timing[i,j] - power[i,j]) <= 1:
            line = list(line)
            line[j] = '#'
    print(''.join(line))
