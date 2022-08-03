clear
path = fileparts(mfilename("fullpath"));
cd(path);
addpath(genpath(path));

%% parameter initialization
rng(1);
clear;

t_step = .1;
T = 20;
T = floor(T/t_step)*t_step;
time_vec = 0:t_step:T;

%% Cucker Smale params
d = 2;
K = 10;
sigma = 1;
beta = .2;
eta = @(y) K./(sigma^2+y.^2).^beta;

%compute Fourier Expansion of \tilde \eta
order = 5; %p in paper notation
L = 10;
tic;
c_cucker_smale = Fourier_expand(eta, L, order, d);
tim = toc;
fprintf("Fourier-expansion time: %f seconds\n", tim);

%% Kuramoto params:
g = @(x) sin(x);
c_kuramoto = Fourier_expand_kuramoto(g,3);

%% desai zwanzig params

%% simulations

total_particles = round(100*10.^linspace(0,4,4*4+1));
%total_particles = round(100*10.^linspace(3,4,1*4+1));
%total_particles = round(100*10.^linspace(0,1,1*4+1));

time_cs_naive       = zeros(size(total_particles));
time_kuramoto_naive = zeros(size(total_particles));
time_dz_naive       = zeros(size(total_particles));
time_br_naive       = zeros(size(total_particles));

time_cs_cia       = zeros(size(total_particles));
time_kuramoto_cia = zeros(size(total_particles));
time_dz_cia       = zeros(size(total_particles));
time_br_cia       = zeros(size(total_particles));


time_limit = 3e2; 
%time_limit = 2;

for mm = 1:length(total_particles)
    fprintf('\nm=%d, N=%d\n',mm, total_particles(mm));
    N = total_particles(mm);

    %cucker-smale
    cs_ini_x = rand(N,2);
    cs_ini_v = 0.5*randn(N,2);

    %kuramoto
    ini_theta = 2*pi*rand(N,1);
    oms = randn(N,1);

    %desai-zwanzig
    dz_ini_x = randn(N,1);

    %bornhold-rholf
    br_ini_v = (rand(N,1)<.5)*2-1;
    steps = 100;
    mu = 1;
    s = .1;

    base_sizes = [1,2,3,4];
    sizes = round(base_sizes/sum(base_sizes)*total_particles(mm)); %this is lambda in the notation of the paper.
    k = 30;
    
    memory_limit = 4; %in GiB
    if N^2*4 < memory_limit * 2^30
        [A, communities, M] = generate_block_graph_linear(sizes, k);

        tic;
        S = prepare_cia(A, communities);
        fprintf("Prepare Time: %f seconds\n", toc);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % naive algorithms

        %cucker smale
        if max(time_cs_naive) < time_limit
            tic;
            [X_naive1, V_naive1] = simulate_cs_naive1(A, time_vec, cs_ini_x, cs_ini_v, eta);
            tim = toc;
            time_cs_naive(mm) = tim;
            fprintf("Naive Algorithm 1 Cucker-Smale: %f seconds\n",tim);
        end

        %kuramoto
        if max(time_kuramoto_naive) < time_limit
            tic;
            Theta_naive1 = simulate_kuramoto_naive1(A, time_vec, ini_theta, g, oms);
            tim = toc;
            time_kuramoto_naive(mm) = tim;
            fprintf("Naive Algorithm 1 Kuramoto: %f seconds\n",tim);
        end

        %desai zwanzig
        if max(time_dz_naive) < time_limit
            tic;
            X_naive1 = simulate_dz_naive1(A, dz_ini_x, time_vec);
            tim = toc;
            time_dz_naive(mm) = tim;
            fprintf("Naive Algorithm 1 Desai-Zwanzig: %f seconds\n",tim);
        end

        %bornhold rohlf
        if max(time_br_naive) < time_limit
            tic;
            V_naive1 = simulate_br_naive1(A,steps, br_ini_v, mu, s);
            tim = toc;
            time_br_naive(mm) = tim;
            fprintf("Naive Algorithm 1 Bornhold-Rohlf: %f seconds\n",tim);
        end

    else
        warning("Creating a graph with %d nodes exceeds memory capacities. Naive algorithms do not work. A test graph is created instead. \n", N);

        %create test graph
        M = length(sizes);
        vec = [0, cumsum(sizes)];
        start = vec(1:M)+1;
        ende = vec(2:end);
        communities = arrayfun(@(x,y) x:y, start, ende, 'UniformOutput', false);

        outsider_len = k*N;
        S = create_test_sparsity(N, sizes, outsider_len);

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % CIAs

    %cucker smale
    if max(time_cs_cia) < time_limit
        tic;
        [X_cia, V_cia] = simulate_cs_cia(time_vec, cs_ini_x, cs_ini_v, c_cucker_smale, communities, order, L, eta, S);
        tim = toc;
        time_cs_cia(mm) = tim;
        fprintf("CIA Cucker-Smale: %f seconds\n",tim);
    end

    %kuramoto
    if max(time_kuramoto_cia) < time_limit
        tic;
        Theta_cia = simulate_kuramoto_cia(c_kuramoto, time_vec, ini_theta, oms, communities, g, S);
        tim = toc;
        time_kuramoto_cia(mm) = tim;
        fprintf("CIA Kuramoto: %f seconds\n",tim);
    end

    %desai zwanzig
    if max(time_dz_cia) < time_limit
        tic;
        X_cia = simulate_dz_cia(communities, dz_ini_x, time_vec, S);
        tim = toc;
        time_dz_cia(mm) = tim;
        fprintf("CIA Desai-Zwanzig: %f seconds\n",tim);
    end

    %bornhold-rohlf
    if max(time_br_cia) < time_limit
        tic;
        V = simulate_br_cia(communities, steps, br_ini_v, mu, s, S);
        tim = toc;
        time_br_cia(mm) = tim;
        fprintf("CIA Bornhold-Rohlf: %f seconds\n",tim);
    end

end


%% save simulation results
time_str = string(datetime('now', 'Format', 'yyyy-MM-dd_HH-mm-ss'));
savename = sprintf("%s_model_comparison.mat", time_str);
h = whos();
names = cellfun(@string,{h.name});
%exclude variables
logi = ~any(names == ["A";"br_ini_v";"cs_ini_v";"cs_ini_x";"dz_ini_x";"ini_theta";"oms";...
    "Theta_cia";"Theta_naive1";"V";"V_cia";"V_naive1";"X_cia";"X_naive1";""],1);
variables = cellstr(names(logi));
dirname = "Model_Comparison_Results";
if ~isfolder(dirname)
    mkdir(dirname)
    fprintf("Folder %s created\n", dirname);
end
save(fullfile(dirname, savename), variables{:});

%% plot

fig = figure();
fig.Position(3:4) = [580,340];
ax = axes(fig);

plt(1,1) = loglog(ax, total_particles, time_cs_naive, 'DisplayName', 'Cucker-Smale (naive)');
hold(ax, 'on');
plt(1,2) = loglog(ax, total_particles, time_kuramoto_naive, 'DisplayName', 'Kuramoto (naive)');
plt(1,3) = loglog(ax, total_particles, time_dz_naive, 'DisplayName', 'Desai-Zwanzig (naive)');
plt(1,4) = loglog(ax, total_particles, time_br_naive, 'DisplayName', 'Bornholdt-Rohlf (naive)');

plt(2,1) = loglog(ax, total_particles, time_cs_cia, 'DisplayName', 'Cucker-Smale (CIA)');
plt(2,2) = loglog(ax, total_particles, time_kuramoto_cia, 'DisplayName', 'Kuramoto (CIA)');
plt(2,3) = loglog(ax, total_particles, time_dz_cia, 'DisplayName', 'Desai-Zwanzig (CIA)');
plt(2,4) = loglog(ax, total_particles, time_br_cia, 'DisplayName', 'Bornholdt-Rohlf (CIA)');

c1 = plt(1,1).Color;
c2 = plt(1,2).Color;

for pp = 1:numel(plt)
    plt(pp).MarkerSize = 7;
    plt(pp).LineWidth = 1.5;
    plt(pp).MarkerEdgeColor = 'black';
    plt(pp).LineStyle = '-';
end
for pp = 1:2
    plt(pp,1).Marker = 'o';
    plt(pp,2).Marker = 's';
    plt(pp,3).Marker = 'd';
    plt(pp,4).Marker = '*';
end
for pp = 1:4
    plt(1,pp).Color = c1;
    plt(1,pp).MarkerFaceColor = c1;

    plt(2,pp).Color = c2;
    plt(2,pp).MarkerFaceColor = c2;
end

grid(ax, 'minor');
legend(ax, 'Location', 'se', 'NumColumns',2);

%add triangles
if length(total_particles)>=14
    tri(1) = loglog(ax, total_particles([3,3,7]), time_cs_naive([3,7,7]), 'Color', c1);
    tri(2) = loglog(ax, total_particles([6,14,14]), time_br_cia([6,6,14]), 'Color', c2);

    for tt = 1:length(tri)
        tri(tt).HandleVisibility = 'off';
        tri(tt).LineStyle = '--';
        tri(tt).LineWidth = 1;
    end
end