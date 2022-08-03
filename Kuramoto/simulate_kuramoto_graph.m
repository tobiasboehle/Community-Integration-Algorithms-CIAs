%rng(1);
%% test graph generation
switch 1
    case 1 %create a graph
        
        sizes = 10*[1,2,3,4];
        k = 30;
        [A, communities, M] = generate_block_graph_linear(sizes, k);
        
    case 2 % load a real graph
        
        filename_graph = "aves-wildbird-network.edges";
        filename_communities = 'aves-wildbird-network_RBER Pots.txt';
        
        [A, communities] = read_network2(filename_graph, filename_communities);
        A = (A+A'>.5);
        
        N_large = 500;
        [A, communities] = graph_blow_up_linear(A, communities, N_large);
        
        min_community_size = 10;
        c_sizes = cellfun(@length, communities);
        communities(c_sizes<min_community_size) = [];
        
end
N = size(A,1);
M = length(communities);

c_sizes = cellfun(@length, communities);
no_community = 1:N;
no_community([communities{:}]) = [];

ini_theta = 2*pi*rand(N,1);

t_step = .1;
T = 20;
T = floor(T/t_step)*t_step;
time_vec = 0:t_step:T;

g = @(x) sin(x);
oms = randn(N,1);

% solve 
% \theta'(k) = oms(k) + K/N \sum_{j=1}^N a_{kj} g(\theta_k - \theta_j)


%%
tic;
Theta_naive = simulate_kuramoto_naive1(A, time_vec, ini_theta, g, oms);
toc;
%%
c = Fourier_expand_kuramoto(g,3);
S = prepare_cia(A, communities);
tic;
Theta_cia = simulate_kuramoto_cia(c, time_vec, ini_theta, oms, communities, g, S);
toc;