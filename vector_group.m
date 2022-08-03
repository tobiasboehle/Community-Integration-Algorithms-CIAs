function vp = vector_group(c, N, col)

d = size(c,2);
vp = zeros(N,d);
for j = 1:length(col)
    vp(col(j),:) = vp(col(j),:) + c(j, :)/N;
end

end