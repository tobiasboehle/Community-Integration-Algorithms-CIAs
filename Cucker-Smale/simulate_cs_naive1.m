function [X,V] = simulate_cs_naive1(A, time_vec, ini_x, ini_v, eta)

d = size(ini_x,2);
N=size(A,1);
X = zeros(N, d, length(time_vec));
V = zeros(N, d, length(time_vec));

X(:,:,1) = ini_x;
V(:,:,1) = ini_v;

A_p = permute(A, [1,3,2]);

for tt = 1:length(time_vec)-1
    x = X(:,:,tt);
    v = V(:,:,tt);
    
    dist = vecnorm(x-permute(x, [3,2,1]), 2, 2);
    G = eta(dist);
    v_diff = permute(v, [3,2,1])-v;
    vp =  sum(A_p.*G.*v_diff, 3)/N;
    
    t_step = time_vec(tt+1)-time_vec(tt);
    v_new = v + t_step * vp;
    x_new = x + t_step * v;
    
    X(:,:,tt+1) = x_new;
    V(:,:,tt+1) = v_new;
    
end

end