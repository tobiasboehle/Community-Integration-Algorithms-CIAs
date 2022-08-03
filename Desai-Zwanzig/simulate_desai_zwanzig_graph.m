
rng(1);
%% test graph generation
switch 1
    case 1 %create a graph
        
        sizes = 1000*[1,2,3,4];
        k = 30;
        [A, communities, M] = generate_block_graph_linear(sizes, k);
        
    case 2 % load a real graph
        
        filename_graph = "aves-wildbird-network.edges";
        filename_communities = 'aves-wildbird-network_RBER Pots.txt';
        
        [A, communities] = read_network2(filename_graph, filename_communities);
        A = (A+A'>.5);
        
        N_large = 500;
        [A, communities] = graph_blow_up(A, communities, N_large);
        
        min_community_size = 10;
        c_sizes = cellfun(@length, communities);
        communities(c_sizes<min_community_size) = [];
        
end
N = size(A,1);
M = length(communities);

c_sizes = cellfun(@length, communities);
no_community = 1:N;
no_community([communities{:}]) = [];

ini_x = rand(N,1);

t_step = .1;
T = 20;
T = floor(T/t_step)*t_step;
time_vec = 0:t_step:T;


% solve 
% x'(k) = 1/N \sum_{j=1}^N a_{kj} (x_k - x_j)

warning("No Potential")

%%

tic;
X_slow1 = simulate_dz_naive1(A, ini_x, time_vec);
toc;

S = prepare_cia(A, communities);
tic;
X_fast = simulate_dz_cia(communities, ini_x, time_vec, S);
toc;


