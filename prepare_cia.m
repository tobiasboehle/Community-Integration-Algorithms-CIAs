function S = prepare_cia(A,communities)

N = size(A,1);

M = length(communities);
c_sizes = cellfun(@length, communities);
B_cell = arrayfun(@ones, c_sizes, 'UniformOutput', false);
B_temp = blkdiag(B_cell{:});
B=zeros(N);
vec = [0, cumsum(c_sizes)];
for sigma = 1:M
    B(communities{sigma}, communities{sigma}) = B_temp(vec(sigma)+1:vec(sigma+1),vec(sigma)+1:vec(sigma+1));
end
S_mat = sparse(A-B);

intra_edges_ind = find(S_mat<-1/2);
inter_edges_ind = find(S_mat>1/2);
[intra_row, intra_col] = ind2sub(size(S_mat), intra_edges_ind);
[inter_row, inter_col] = ind2sub(size(S_mat), inter_edges_ind);

S.intra_row = intra_row;
S.intra_col = intra_col;
S.inter_row = inter_row;
S.inter_col = inter_col;


end