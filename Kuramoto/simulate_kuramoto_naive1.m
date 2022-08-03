function Theta = simulate_kuramoto_naive1(A, time_vec, ini_theta, g, oms)
N = size(A,1);

Theta = zeros(N,length(time_vec));
Theta(:,1) = ini_theta;

for tt = 1:length(time_vec)-1
    th = Theta(:,tt);
    dth = oms + mean(A.*g(th.'-th),2);
    
    th = th + (time_vec(tt+1)-time_vec(tt))*dth;
    Theta(:,tt+1) = th;
end


end