function [A_large, communities_large] = graph_blow_up_linear(A, communities, N_large)

N=size(A,1);
ind = randi(N, N_large,1);
A_large = A(ind,ind);
communities_large = cellfun(@(x_var) find(ismember(ind, x_var))', communities, 'UniformOutput', false);
A_org_large = A_large;
%perm_large = [communities_large{:}];


sparsity_factor = N/N_large; %the smaller this factor the sparser the intercommunity structure of the graph
mat = rand(N_large) > sparsity_factor;
mat = logical(tril(mat, -1) + tril(mat)'); %make symmetric
A_large(mat) = 0;

density_factor = sparsity_factor;
for sigma = 1:length(communities_large)
    A_part = A_org_large(communities_large{sigma}, communities_large{sigma});
    mat = rand(size(A_part)) > density_factor;
    mat = logical(tril(mat, -1) + tril(mat)'); %make symmetric
    A_part(mat) = 1;
    A_large(communities_large{sigma}, communities_large{sigma}) = A_part;
end



end
