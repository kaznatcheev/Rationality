function [data,genotypes,minds] = simpleRun(n_agents,n_epochs,game_point,alpha_values,evo_UV_flag,plot_flags)
%[data,genotypes,minds] = simpleRun(n_agents,n_epochs,game_point,...
%   alpha_values,evo_UV_flag,plot_flags)
%
%The goal of simpleRun is to provide a way to quickly test run the code
%and look at its outputs. [evo_UV_flag] sets a flag on if we want the
%subjective game perception to evolve, by default set to 1.

if (nargin < 6) || isempty(plot_flags)
    plot_flags = [1 1 1 1]
end;

if (nargin < 5) || isempty(evo_UV_flag)
    evo_UV_flag = 1;
end;

game = [1 game_point(1); game_point(2), 0];

%set the default parameters
degree = 3;
boundaries = [-2, 2, -1, 3];
p_death = 0.05;
mutation_rate = 0.05;
mutation_size = 0.1;
if (alpha_values == 0)
    alpha_mut_rate = 0;
else
    alpha_mut_rate = 0.05;
end;
p_shuffle = 0;
epsilon = 0.1;

%First we make a random graph of degree
adjmx = full(createRandRegGraph(n_agents, degree));

if evo_UV_flag,
    genotypes = genoRandInit(n_agents,boundaries,alpha_values);
else
    genotypes = genoRandInit(n_agents,[game_point(1), game_point(1), game_point(2), game_point(2)],alpha_values);
end;

if plot_flags(1),
    figure('position', [250 500 1500 500]);
    subplot(1,2,1);
    densityPlot(genotypes,boundaries,game_point,[],1,0);
    title('Density plot of genotypes at start');
end;

minds = zeros(n_agents, 4);

%pick the reproduce rule
if evo_UV_flag,
    reproduce = @(genotype) repLocalMutate(genotype, mutation_rate, ...
        mutation_size, boundaries, alpha_mut_rate, alpha_values);
else
    reproduce = @(genotype) repSetMutate(genotype, mutation_rate, ...
        game_point, alpha_mut_rate, alpha_values);
end;

[data,genotypes,minds] = subRat(adjmx, genotypes, minds, game, [], ...
    @deathBirth, n_epochs, p_death,reproduce,...
    @(genotype,mind) ratBayShaky(genotype, mind, epsilon), p_shuffle);

if plot_flags(1),
    subplot(1,2,2);
    densityPlot(genotypes,boundaries,game_point,[],1,0);
    title(strcat('Density plot of genotypes at epoch ', int2str(n_epochs)));
end;

%plot p and q
if plot_flags(2),
    figure;
    hold;
    plot(data(:,8) + data(:,10)/sqrt(n_agents),'b');
    plot(data(:,8) - data(:,10)/sqrt(n_agents),'b');
    plot(data(:,9) + data(:,11)/sqrt(n_agents),'r');
    plot(data(:,9) - data(:,11)/sqrt(n_agents),'r');

    axis([1 n_epochs 0 1]); 
    title('Agents minds');

    grid;
    hold;
end;
    
%plot proportion of cooperation
if plot_flags(3),
    prop_coop = plotCoop(data(:,1:3), epsilon, game_point, [], 0, 'b');
end;

%plot alphas
if plot_flags(4),
    figure;
    hold on;
    plot(data(:,12) + data(:,13) / sqrt(n_agents), 'b');
    plot(data(:,12) - data(:,13) / sqrt(n_agents), 'b');
    
    axis([1 n_epochs 0 1]);
    title('Agent alphas');
    
    grid;
    hold off;
end;
end

