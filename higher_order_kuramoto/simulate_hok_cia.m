function Theta = simulate_hok_cia(ini_theta, time_vec)

N = length(ini_theta);
Theta = zeros(N,length(time_vec));
Theta(:,1) = ini_theta;

for tt = 1:length(time_vec)-1
    th = Theta(:,tt);
    
    r = mean(exp(1i*th));
    
    dth = imag(r.^2.*conj(r).*exp(-1i*th));
    
    t_step = time_vec(tt+1)-time_vec(tt);
    Theta(:,tt+1) = th + t_step + dth;
end

end