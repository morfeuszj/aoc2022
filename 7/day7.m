clc
clear

fid = fopen("test.txt");

dir_graph = digraph();
dir_graph = dir_graph.addnode("/");
dir_graph.Nodes.fsize = 0;
current_node = "/";
list_mode = false;
tline = fgetl(fid); % get first line
while ischar(tline)
    if tline(1) == '$' % it is a command
        list_mode = false;
        if strcmp(tline(3:4), 'cd')
            new_node = tline(6:end);
            if strcmp(new_node, '..')
                for child = dir_graph.successors(current_node)'
                    dir_graph.Nodes.fsize(strcmp(dir_graph.Nodes.Name, current_node)) = ...
                        dir_graph.Nodes.fsize(strcmp(dir_graph.Nodes.Name, current_node)) + ...
                        dir_graph.Nodes.fsize(strcmp(dir_graph.Nodes.Name, child));
                end
                new_node = string(dir_graph.predecessors(current_node));
            end
            current_node = new_node;
        elseif strcmp(tline(3:4), 'ls')
            list_mode = true;
        else
            error('invalid command')
        end
    else % it is system response
        if strcmp(tline(1:3), 'dir')
            new_dir_name = string(tline(5:end));
            dir_graph = dir_graph.addnode(table(new_dir_name, 0, 'VariableNames',{'Name', 'fsize'}));
            dir_graph = dir_graph.addedge(current_node, new_dir_name);
        else
            [fsize, ~,~, next_ind] = sscanf(tline, '%d');
            new_file_name = string(tline(next_ind : end));
            dir_graph = dir_graph.addnode(table(new_file_name, fsize, 'VariableNames',{'Name', 'fsize'}));
            dir_graph = dir_graph.addedge(current_node, new_file_name);
        end
    end
    tline = fgetl(fid); % get next line
end
