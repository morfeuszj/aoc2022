input = readtable("input.txt", 'ReadVariableNames',false);
attack = cell2mat(input.Var1) - 'A' + 1;
defense = cell2mat(input.Var2) - 'X' + 1;
% test
% attack = ['A';'B';'C'] - 'A' + 1;
% defense = ['Y';'X';'Z'] - 'X' + 1;
score_shape = sum(defense);
outcome = mod(defense - attack, 3);
score_outcome = 3 * sum(outcome == 0) + 6 * sum(outcome == 1);
score_shape + score_outcome
% part 2
elf_outcome = defense - 2;
elf_defense = mod(elf_outcome + attack, 3);
elf_defense(elf_defense == 0) = 3;
elf_score_shape = sum(elf_defense);
elf_score_outcome = 3 * sum(elf_outcome == 0) + 6 * sum(elf_outcome == 1);
elf_score_shape + elf_score_outcome