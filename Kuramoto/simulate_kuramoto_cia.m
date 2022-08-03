function Theta = simulate_kuramoto_cia(c, time_vec, ini_theta, oms, communities, g, outsiders)

N = size(ini_theta,1);
M = length(communities);

intra_row = outsiders.intra_row;
intra_col = outsiders.intra_col;
inter_row = outsiders.inter_row;
inter_col = outsiders.inter_col;

order = (length(c)-1)/2;

Theta = zeros(N,length(time_vec));
Theta(:,1) = ini_theta;


for tt = 1:length(time_vec)-1
    th = Theta(:,tt);
    
    dth = oms;
    
    for sigma = 1:M
        th_com = th(communities{sigma});
        dth_com = zeros(size(th_com));
        
        %precompute order parameters
        r = sum(exp(1i*(-order:order).*th_com))/N;
        
        for k = 1:2*order+1
            alpha = k-order-1;
            dth_com = dth_com + c(k)*r(k)*exp(-1i*alpha*th_com);
        end
        
        dth(communities{sigma}) = dth(communities{sigma}) + dth_com;
        
    end
    
    if max(abs(imag(dth)))>1e-10
        disp("something cannot be right")
    end
    dth = real(dth);
    
    g_intra = g(th(intra_row)-th(intra_col));
    %dth_intra = vector_group_mex(g_intra,N,intra_col);
    dth_intra = vector_group(g_intra,N,intra_col);
    
    g_inter = g(th(inter_row)-th(inter_col));
    %dth_inter = vector_group_mex(g_inter, N, inter_col);
    dth_inter = vector_group(g_inter, N, inter_col);
    
    dth = dth - dth_intra + dth_inter;
    
    th = th + (time_vec(tt+1)-time_vec(tt))*dth;
    Theta(:,tt+1) = th;
end




end