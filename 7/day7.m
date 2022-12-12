clc
clear

fid = fopen("input.txt");

dir_graph = digraph();
dir_graph = dir_graph.addnode(1);
dir_graph.Nodes.fname = '/';
dir_graph.Nodes.fsize = 0;
dir_graph.Nodes.uid = 1;
current_node = 1;
list_mode = false;
tline = fgetl(fid); % get first line
while ischar(tline)
    if isempty(current_node)
        disp('dupa')
    end
    if tline(1) == '$' % it is a command
        list_mode = false;
        if strcmp(tline(3:4), 'cd')
            new_node = tline(6:end);
            if strcmp(new_node, '..')
                new_node = dir_graph.predecessors(current_node);
                current_node = new_node;
            elseif strcmp(new_node, '/')
                current_node = 1;
            else
                children = dir_graph.successors(current_node);
                current_node = children(strcmp(dir_graph.Nodes.fname(children), new_node));
            end
        elseif strcmp(tline(3:4), 'ls')
            list_mode = true;
        else
            error('invalid command')
        end
    else % it is system response
        if strcmp(tline(1:3), 'dir')
            new_dir_name = string(tline(5:end));
            dir_graph = dir_graph.addnode(table(new_dir_name, 0, dir_graph.numnodes()+1, ...
                'VariableNames',{'fname', 'fsize', 'uid'}));
            dir_graph = dir_graph.addedge(current_node, dir_graph.numnodes());
        else
            [fsize, ~,~, next_ind] = sscanf(tline, '%d');
            new_file_name = string(tline(next_ind : end));
            dir_graph = dir_graph.addnode(table(new_file_name, fsize, dir_graph.numnodes()+1, ...
                'VariableNames',{'fname', 'fsize', 'uid'}));
            dir_graph = dir_graph.addedge(current_node, dir_graph.numnodes());
        end
    end
    tline = fgetl(fid); % get next line
end

dir_graph_copy = dir_graph;

while dir_graph_copy.numnodes > 0
    leaves = find(dir_graph_copy.outdegree() == 0)';
    for current_node = leaves
        parent = dir_graph_copy.predecessors(current_node);
        if isempty(parent)
            continue
        end
        parent = dir_graph_copy.Nodes.uid(parent);
        dir_graph.Nodes.fsize(parent) = dir_graph.Nodes.fsize(parent) + ...
            dir_graph_copy.Nodes.fsize(current_node);
        dir_graph.Nodes.visited(current_node) = true;
    end
    dir_graph_copy = dir_graph_copy.rmnode(leaves);
end

sum(dir_graph.Nodes.fsize(dir_graph.Nodes.fsize < 100000 & dir_graph.outdegree > 0))