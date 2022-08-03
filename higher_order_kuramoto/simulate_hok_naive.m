function Theta = simulate_hok_naive(ini_theta, time_vec)
N = length(ini_theta);
Theta = zeros(N,length(time_vec));
Theta(:,1) = ini_theta;

for tt = 1:length(time_vec)-1
    th = Theta(:,tt);
    
    th1 = permute(th, [4,3,2,1]);
    th2 = permute(th, [3,2,1]);
    th3 = permute(th, [2,1]);
    
    dth = sum(sin(th1-th2+th3-th), [2,3,4])/N^3;
    
    t_step = time_vec(tt+1)-time_vec(tt);
    Theta(:,tt+1) = th + t_step+dth;
end


end