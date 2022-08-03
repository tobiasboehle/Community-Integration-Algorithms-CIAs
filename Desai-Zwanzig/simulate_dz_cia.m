function X = simulate_dz_cia(communities, ini_x, time_vec, S)

N = size(ini_x,1);
M = length(communities);
intra_row = S.intra_row;
intra_col = S.intra_col;
inter_row = S.inter_row;
inter_col = S.inter_col;

X = zeros(N,length(time_vec));
X(:,1) = ini_x;

for tt = 1:length(time_vec)-1
    x = X(:,tt);
    dx = zeros(N,1);
    
    for sigma = 1:M
        x_com = x(communities{sigma});
        r = sum(x_com)/N;
        
        dx_com = r-x_com;
        
        dx(communities{sigma}) = dx_com;
    end
    
    %calculate tilde F
    dist_intra = x(intra_row,:)-x(intra_col,:);
    %dx_intra = vector_group_mex(dist_intra, N, intra_col);
    dx_intra = vector_group(dist_intra, N, intra_col);
    
    dist_inter = x(inter_row,:)-x(inter_col,:);
    %dx_inter = vector_group_mex(dist_inter, N, inter_col);
    dx_inter = vector_group(dist_inter, N, inter_col);
    
    dx = dx - dx_intra + dx_inter;
    
    
    %dx = mean(A.*(x.'-x),2);
    
    X(:,tt+1) = x + (time_vec(tt+1)-time_vec(tt))*dx;
end

end