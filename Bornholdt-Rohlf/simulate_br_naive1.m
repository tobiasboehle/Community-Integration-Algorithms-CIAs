function V = simulate_br_naive1(A, steps, ini_v, mu, s)

N = length(ini_v);
V = zeros(N, steps+1);
V(:,1) = ini_v(:);

for i = 1:steps
    v = V(:,i);
    
    r = randn(N,1);
    f = A*v + mu*v + s*r;
    
    V(:,i+1) = sign(f);
    
end

end