function out_val = arbGRunVis(PD_depth,graph_location)
%out_val = arbGRunVis(PD_depth,graph_location)
%   This loads a graph from [graph_location] and run the [1, -[PD_depth]; 
%1 + [PD_depth], 0], with rational (non-Bayesian) decision making.
%
%Example run: arbGRunVis(0.1,'../RationalityData/adjHadzaF.csv')

%set some fixed initial values
boundaries = [-2, 2, -1, 3];
max_epoch = 2000;
p_death = 0.1;
mutation_size = 0.1;
mutation_rate = 0.05;
epsilon = 0.1;
p_shuffle = 0; %purely viscous

%don't use Bayes rule, use purely rational updating
alpha_values = 0;
alpha_mut_rate = 0;
decisionRule = @(genotype,mind) ratShaky(genotype, mind, epsilon);

%read the graph
adjmx = dlmread(graph_location);
n_agents = size(adjmx,1);

%create the initial genotypes and empty minds
genotypes = genoRandInit(n_agents,boundaries,alpha_values);
minds = zeros(n_agents, 4);

%convert [PD_depth] to game
game = [1, -PD_depth; 1 + PD_depth, 0];

%define reproduction rule
reproduce = @(genotype) repLocalMutate(genotype, mutation_rate, ...
        mutation_size, boundaries, alpha_mut_rate, alpha_values);

t = tic;
[d_rr,g_rr,m_rr] = subRat(adjmx,genotypes,minds,game,[],@deathBirth, ...
	max_epoch,p_death,reproduce, decisionRule,p_shuffle);
toc(t);

%Calculate the proportion of interactions that are cooperations.
prop_coop_rr = (2*d_rr(:,1) + d_rr(:,2))./(2*(d_rr(:,1) + d_rr(:,2) + d_rr(:,3)));

%Plot the proportion of interactions that are cooperations.
plot(prop_coop_rr, 'b');
hold on
fplot(@(x) 1 - epsilon, [0 max_epoch], 'k--');
fplot(@(x) epsilon, [0 max_epoch], 'k--');
axis([0, max_epoch, 0, 1]);
hold off

%Plot the genotypes as 2D histograms; in Octave needs packages: io, statistics
boundaries = [-2, 2, -1, 3];

figure;
densityPlot(g_rr(:,:), boundaries, [-PD_depth, 1 + PD_depth], [], 1);
title('Density plot of viscous run');