

sizes = 200*[1,2,3,4];
k = 2;
[A, communities, M] = generate_block_graph_linear(sizes, k);

N = size(A,1);
M = length(communities);

c_sizes = cellfun(@length, communities);
no_community = 1:N;
no_community([communities{:}]) = [];

S = prepare_cia(A, communities);

ini_v = (rand(N,1)<.5)*2-1;

steps = 100;
mu = -5;
s = 0.1;

%%

tic;
V_naive1 = simulate_br_naive1(A, steps, ini_v, mu, s);
fprintf("Naive Algorithm Bornhold-Rohlf: %f seconds\n",toc);

tic;
V_cia = simulate_br_cia(communities, steps, ini_v, mu, s, S);
fprintf("CIA Bornhold-Rohlf: %f seconds\n",toc);

max(abs(V_naive1-V_cia),[],'all');
fprintf("The Results of the two algorithms may not agree since there is randomness involved.\n");