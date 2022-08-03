clear
path = mfilename("fullpath");
path = fileparts(path);
path = fileparts(path);
addpath(genpath(path));
rng(1);
%% graph generation
switch 2
    case 1 %create a graph
        
        sizes = 10*[1,2,3,4]; %lambda in notation of paper
        k = 30;
        [A, communities, ~] = generate_block_graph_linear(sizes, k);
        
    case 2 % load real world network
        
        filename_graph = "aves-wildbird-network.edges";
        filename_communities = 'aves-wildbird-network_RBER Pots.txt';
        
        [A, communities] = read_network2(filename_graph, filename_communities);
        
        N_large = 500;
        [A, communities] = graph_blow_up_linear(A, communities, N_large);
        
end

n = 2; %dimension. needs to be fixed. Cannot be changed. 
N = size(A,1);


%% model parameter
min_community_size = 10;
c_sizes = cellfun(@length, communities);
communities(c_sizes<min_community_size) = [];
M = length(communities);
no_community = 1:N;
no_community([communities{:}]) = [];

ini_x = rand(N,n,1);
ini_v = 0.5*randn(N,n,1);

t_step = .1;
T = 50;
T = floor(T/t_step)*t_step;
time_vec = 0:t_step:T;

K = 10;
sigma = 1;
beta = .2;

eta = @(y) K./(sigma^2+y.^2).^beta;

%% naive integration
tic;
[X1,V1] = simulate_cs_naive1(A, time_vec, ini_x, ini_v, eta);
tim = toc;
fprintf("Naive Algorithm 1: %f seconds\n", tim);

%% higher dimensional trigonometric integration

order = 5; %p in paper notation
L = 10;

%compute Fourier Expansion of \tilde \eta
if ~exist('c', 'var') || false
    tic;
    c = Fourier_expand(eta, L, order, n);
    tim = toc;
    fprintf("Fourier-expansion time: %f seconds\n", tim);
end

S = prepare_cia(A, communities);
tic;
[X_cia, V_cia] = simulate_cs_cia(time_vec, ini_x, ini_v, c, communities, order, L, eta, S);
tim = toc;
fprintf("CIA: %f seconds\n",tim);
supnorm_sin = squeeze(max(abs(X1-X_cia), [], [1,2]));

%% start and end and medium 

colors = {'red', 'green', 'blue', 'yellow', 'cyan', 'magenta'};
num_col = length(colors);

photo_time_index = [1, floor(length(time_vec)/5), length(time_vec)]; %index the vector time_vec
%photo_time_index = [1, 41, 1001, 5001];

fig = figure();

X_sol = X_cia;
V_sol = V_cia;

ms = 15;
as = 'on'; warning('AutoScale is on. The length of the arrows do not correspond to the modulus of the velocity')
%as = 'off';

for ii = 1:length(photo_time_index)
    X_time = X_sol(:,:,photo_time_index(ii));
    V_time = V_sol(:,:,photo_time_index(ii));
    %ax = subplot(1,length(photo_time_index),ii, 'Parent', fig);
    fig = figure; fig.Position(3:4) = [300,250]; ax = axes(fig);
    hold(ax, 'on');
    for sigma = 1:M
        col_ind = mod(sigma-1, num_col)+1;
        plot(ax, X_time(communities{sigma},1), X_time(communities{sigma},2), '.', 'MarkerSize', ms, 'Color', colors{col_ind});
        quiver(ax, X_time(communities{sigma},1),X_time(communities{sigma},2), V_time(communities{sigma},1), V_time(communities{sigma},2), 'Color', colors{col_ind}, 'AutoScale', as);
    end
    if ~isempty(no_community)
        plot(ax, X_time(no_community,1), X_time(no_community,2), '.', 'MarkerSize', ms, 'Color', 'black');
        quiver(ax, X_time(no_community,1), X_time(no_community,2), V_time(no_community,1), V_time(no_community,2), 'Color', 'black', 'AutoScale', as);
    end
    title(ax, sprintf("T=%g", time_vec(photo_time_index(ii))));
    %daspect(ax, [1,1,1]);
end

%% video
return
figure; clf;
cla; hold on;

fast_sol = X2;

for sigma = 1:M
    col_ind = mod(sigma-1, num_col)+1;
    p_slow(sigma) = plot(fast_sol(communities{sigma},1,1), fast_sol(communities{sigma},2,1), 'o', 'MarkerSize', 5, 'Color', colors{col_ind});
    p_fast(sigma) = plot(X_cia(communities{sigma},1,1), X_cia(communities{sigma},2,1), '.', 'MarkerSize', 5, 'Color', colors{col_ind});
end
if ~isempty(no_community)
    p_slow(M+1) = plot(fast_sol(no_community,1,1), fast_sol(no_community,2,1), 'o', 'MarkerSize', 5, 'Color', 'black');
    p_fast(M+1) = plot(X_cia(no_community,1,1), X_cia(no_community,2,1), '.', 'MarkerSize', 5, 'Color', 'black');
end

mi = min(fast_sol, [], 'all');
ma = max(fast_sol, [], 'all');
xlim([mi, ma]);
ylim([mi, ma]);


grid minor

speed = 10;

for tt = 1:length(time_vec)
    for sigma = 1:M
        p_slow(sigma).XData = fast_sol(communities{sigma},1,tt);
        p_slow(sigma).YData = fast_sol(communities{sigma},2,tt);
        p_fast(sigma).XData = X_cia(communities{sigma},1,tt);
        p_fast(sigma).YData = X_cia(communities{sigma},2,tt);
    end
    if ~isempty(no_community)
        p_slow(M+1).XData = fast_sol(no_community,1,tt);
        p_slow(M+1).YData = fast_sol(no_community,2,tt);
        p_fast(M+1).XData = X_cia(no_community,1,tt);
        p_fast(M+1).YData = X_cia(no_community,2,tt);
    end
    pause(t_step/speed);
end
