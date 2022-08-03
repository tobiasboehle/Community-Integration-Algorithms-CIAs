%% model
%
% $$\theta_k' = \frac{1}{N^3} \sum_{l,m,n} \sin(\theta_l-\theta_m+\theta_n-\theta_k)$$
%
% on an all-to-all higher-order network

%%


t_step = .1;
T = 20;
T = floor(T/t_step)*t_step;
time_vec = 0:t_step:T;

%%

total_particles = round(10*10.^linspace(0,4,4*4+1));
time_hok_naive = zeros(size(total_particles));
time_hok_cia = zeros(size(total_particles));

for mm = 1:length(total_particles)
    fprintf('m=%d\n',mm);
    
    N=total_particles(mm);
    ini_theta = 2*pi*rand(N,1);
    
    if total_particles(mm)<300
        tic;
        Theta_naive = simulate_hok_naive(ini_theta, time_vec);
        time_hok_naive(mm) = toc;
        fprintf("Naive Algorithm HOK: %f seconds\n", toc);
    end
    
    tic;
    Theta_cia = simulate_hok_cia(ini_theta, time_vec);
    time_hok_cia(mm) = toc;
    fprintf("CIA HOK: %f seconds\n", toc);
    
end

%%
fig = figure;
fig.Position(3:4) = [450,300];
plt(1) = loglog(total_particles, time_hok_naive, 'DisplayName', 'Higher-order Kuramoto (naive)');
hold on
plt(2) = loglog(total_particles, time_hok_cia, 'DisplayName', 'Higher-order Kuramoto (CIA)');
grid on
legend('Location', 'ne');

for pp = 1:length(plt)
    plt(pp).Marker = 'o';
    plt(pp).MarkerSize = 7;
    plt(pp).LineWidth = 1.5;
    plt(pp).MarkerEdgeColor = 'black';
    plt(pp).LineStyle = '-';
    %plt(pp).Color = 'green';
    plt(pp).MarkerFaceColor = plt(pp).Color;
end

tri(1) = loglog(total_particles([2,6,6]), time_hok_naive([2,2,6]), 'Color', plt(1).Color);
tri(2) = loglog(total_particles([3,16,16]), time_hok_cia([3,3,16]), 'Color', plt(2).Color);

for tt = 1:length(tri)
    tri(tt).LineWidth = 1.5;
    tri(tt).HandleVisibility = 'off';
    tri(tt).LineStyle = '--';
    %tri(tt).Color = 'green';
end
