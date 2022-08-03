function [A, communities, M] = generate_block_graph_linear(sizes, k)

N=sum(sizes);
sz_cell = arrayfun(@ones, sizes, 'UniformOutput', false);
A_temp = blkdiag(sz_cell{:});

lower_triangle_elements = N*(N-1)/2;

num_derivate = floor(k*N/2);
if num_derivate < lower_triangle_elements
    ind = datasample(1:lower_triangle_elements, num_derivate, 'Replace', false);
else
    ind = randi(lower_triangle_elements, num_derivate,1);
end
for col = 0:N-1
    ind(ind>N*col) = ind(ind>N*col) + col+1;
end

[row,col] = ind2sub(size(A_temp), ind);
ind_transpose = sub2ind(size(A_temp), col,row);
A_temp(ind) = 1-A_temp(ind);
A_temp(ind_transpose) = 1-A_temp(ind_transpose);

M = length(sizes);
vec = [0, cumsum(sizes)];
start = vec(1:M)+1;
ende = vec(2:end);
communities_temp = arrayfun(@(x,y) x:y, start, ende, 'UniformOutput', false);

A = A_temp;
communities = communities_temp;

% communities = cell(size(communities_temp));
% perm = randperm(N);
% inv_perm = zeros(size(perm));
% inv_perm(perm) = 1:N;
% A = A_temp(inv_perm,inv_perm);
% for i = 1:length(communities)
%     communities{i} = perm(communities_temp{i});
% end

end