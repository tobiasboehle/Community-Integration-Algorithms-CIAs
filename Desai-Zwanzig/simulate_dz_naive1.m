function X = simulate_dz_naive1(A, ini_x, time_vec)

N = size(A,1);

X = zeros(N,length(time_vec));
X(:,1) = ini_x;

for tt = 1:length(time_vec)-1
    x = X(:,tt);
    
    dx = mean(A.*(x.'-x),2);
    
    X(:,tt+1) = x + (time_vec(tt+1)-time_vec(tt))*dx;
end

end