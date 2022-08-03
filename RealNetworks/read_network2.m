function [A, comms] = read_network2(filename_graph, filename_communities)

fclose('all');

fil = fopen(filename_graph);
nodes = 2;
A = zeros(2);
while true
    line = fgetl(fil);
    if isnumeric(line)
        break
    end
    
    edge = str2num(line);
    
    if isempty(edge)
        continue
    end
    
    if min(edge(1), edge(2))<.5
        continue
    end
    
    nodes = max([edge(1:2), nodes]);
    if size(A,1)<nodes
        add_size = max(nodes-size(A,1), 1000);
        A = blkdiag(A, zeros(add_size));
    end
    A(edge(1), edge(2))=true;
end
fclose(fil);
A = A(1:nodes, 1:nodes);

A = double(A+A'>0);

% if all(A == tril(A), 'all') || all(A == triu(A), 'all')
%     A = A+A.';
% end
% 
% if max(A, [], 'all')>1
%     warning("A contains values > 1")
% end

%%
if nargin > 1
    fil = fopen(filename_communities);
    
    if ~isnumeric(filename_communities) & fil>2
        comms_temp = {};
        while true
            line = fgetl(fil);
            if isnumeric(line)
                break
            end
            comms_temp{end+1} = str2num(line);
        end
        
        m = min(cellfun(@min, comms_temp));
        if m < 1
            comms_temp = cellfun(@(x) x+1, comms_temp, 'UniformOutput', false);
        end
        perm = [comms_temp{:}];
        inv_perm = zeros(size(perm));
        inv_perm(perm) = 1:nodes;

        A = A(perm,perm);
        comms = cell(size(comms_temp));
        for i = 1:length(comms)
            comms{i} = inv_perm(comms_temp{i});
        end
        
    else
        comms = {};
        %perm = [];
    end
    if ~isnumeric(filename_communities)
        fclose(fil);
    end
else
    comms = {};
    %perm = [];
end



end