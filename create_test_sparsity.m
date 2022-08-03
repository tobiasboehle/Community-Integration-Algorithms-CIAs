function S = create_test_sparsity(N, sizes, outsider_len)

lower_triangle_elements = N*(N-1)/2;
num_derivate = floor(outsider_len/2);
ind = randi(lower_triangle_elements, num_derivate, 1); %indices with respect to lower triangle

col_temp = floor(-(-(N+.5) + sqrt((N+.5)^2+2*(1-ind-N))));
ind_new = ind + col_temp.*(col_temp-1)/2; %indices are now with respect to full matrix

[row,col] = ind2sub([N,N], ind_new);

%make symmetric
row_all = [row; col];
col_all = [col; row];

cumsiz = [0,cumsum(sizes)];
comm_vec = 1:length(sizes);
intra_logi = any((cumsiz(comm_vec) < row_all) & (row_all <= cumsiz(comm_vec+1)) ...
    & (cumsiz(comm_vec) < col_all) & (col_all <= cumsiz(comm_vec+1)), 2);

S.intra_row = row_all(intra_logi);
S.intra_col = col_all(intra_logi);
S.inter_row = row_all(~intra_logi);
S.inter_col = col_all(~intra_logi);

end
