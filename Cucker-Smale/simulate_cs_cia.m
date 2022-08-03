function [X,V] = simulate_cs_cia(time_vec, ini_x, ini_v, c, communities, order, L, eta, S)

N = size(ini_x,1);
d = size(ini_x,2);
M = length(communities);

intra_row = S.intra_row;
intra_col = S.intra_col;
inter_row = S.inter_row;
inter_col = S.inter_col;

X = zeros(N,d,length(time_vec));
X(:,:,1) = ini_x;
V = zeros(N,d,length(time_vec));
V(:,:,1) = ini_v;

order_vec = -order:order;
alpha1 = permute(order_vec, [1,3,2]);
alpha2 = permute(order_vec, [1,3,4,2]);

c_perm = permute(c, [3,4,1,2]);

for tt = 1:length(time_vec)-1
    x = X(:,:,tt);
    v = V(:,:,tt);
    
    vp_block = zeros(N,d);
    
    for sigma = 1:M
        x_com_imag = x(communities{sigma}, :)*1i*pi/L;
        v_com = v(communities{sigma}, :);
        
        %precompute:
        w = exp(x_com_imag(:, 1).*alpha1+x_com_imag(:, 2).*alpha2);
        u = sum(w)/N;
        h = sum(w.*v_com)/N;
        
        %calculate vp in \hat F
        mat = c_perm.*conj(w).*(h-u.*v_com);
        vp_block(communities{sigma},:) = sum(mat, [3,4]);
    end
    
    
    if max(abs(imag(vp_block)))>1e-10
        disp("something went wrong")
    end
    vp_block = real(vp_block);    
    
    dist_intra = vecnorm(x(intra_row,:)-x(intra_col,:),2,2);
    g_intra = eta(dist_intra);
    v_diff_intra = v(intra_col,:)-v(intra_row,:);
    c_intra = g_intra.*v_diff_intra;
    %vp_intra = vector_group_mex(c_intra, N, intra_row);
    vp_intra = vector_group(c_intra, N, intra_row);
    
    dist_inter = vecnorm(x(inter_row,:)-x(inter_col,:),2,2);
    g_inter = eta(dist_inter);
    v_diff_inter = v(inter_col,:)-v(inter_row,:);
    c_inter = g_inter.*v_diff_inter;
    %vp_inter = vector_group_mex(c_inter, N, inter_row);
    vp_inter = vector_group(c_inter, N, inter_row);
    
    %add together
    vp = vp_block - vp_intra + vp_inter;
    
    t_step = time_vec(tt+1)-time_vec(tt);
    x_new = x + t_step * v;
    v_new = v + t_step * vp;
    X(:,:,tt+1) = x_new;
    V(:,:,tt+1) = v_new;
end

end