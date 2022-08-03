function V = simulate_br_cia(communities, steps, ini_v, mu, s, outsiders)


N = length(ini_v);
V = zeros(N, steps+1);
V(:,1) = ini_v(:);
M = length(communities);

intra_row = outsiders.intra_row;
intra_col = outsiders.intra_col;
inter_row = outsiders.inter_row;
inter_col = outsiders.inter_col;

for i = 1:steps
    v = V(:,i);
    r = randn(N,1);
    f = zeros(N,1);
    
    for sigma = 1:M
        f(communities{sigma}) = sum(v(communities{sigma}));
    end
    
    v_intra = v(intra_col,:);
    %f_intra = vector_group_mex(v_intra, N, intra_row)*N;
    f_intra = vector_group(v_intra, N, intra_row)*N;
    
    v_inter = v(inter_col,:);
    %f_inter = vector_group_mex(v_inter, N, inter_row)*N;
    f_inter = vector_group(v_inter, N, inter_row)*N;
    
    f = f - f_intra + f_inter;
    
    f = f+mu*v+s*r;
    
    V(:,i+1) = sign(f);
end


end