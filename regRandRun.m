function [data, many_genotypes, many_minds] = regRandRun(n_agents, n_epochs, ...
    n_runs, pmod, degree, game, epsilon, mutation_rate, mutation_size, boundaries)
%[data, genotypes, minds] = regRandRun(n_agents, n_epochs, pmod, game, ...
%   epsilon, mutation_rate, mutation_size, boundaries)
%input:
%   n_agents - number of agents
%   n_epochs - number of epochs per run
%   n_runs - number of continuous runs
%   pmod - percent modified in the update rule
%   degree - each agent's degree (number of connections)
%   game - 2 x 2 matrix that represents the game (payoff matrix)
%   epsilon - the chance that an agent will shake its hand
%   mutation_rate - the chance that an agent will mutate when reproducing
%   mutation_size - the maximum size of a mutation "step"
%   boundaries - 1 x 4 vector that sets the boundaries for U and V, where
%       [1] is minimum value of U
%       [2] is the maximum value of U
%       [3] is the minimum value of V
%       [4] is the maximum value of V

if (nargin < 10) || isempty(boundaries),
    boundaries = [-2, 2, -1, 3];
end;

if (nargin < 9) || isempty(mutation_size),
    mutation_size = 0.2;
end;

if (nargin < 8) || isempty(mutation_rate),
    mutation_rate = 0.05;
end;

if (nargin < 7) || isempty(epsilon),
    epsilon = 0.05;
end;

if (nargin < 6) || isempty(game),
    game = [1, -1 ; 2, 0];
end;

adjmx = full(createRandRegGraph(n_agents, degree));

genotypes = rand(n_agents, 2);
genotypes(:, 1) = genotypes(:, 1) .* (boundaries(2) - boundaries(1)) + boundaries(1);
genotypes(:, 2) = genotypes(:, 2) .* (boundaries(4) - boundaries(3)) + boundaries(3);

minds = zeros(n_agents, 4);

[data, many_genotypes, many_minds] = multiSubRat(adjmx, genotypes, minds, game, [], ...
    @deathBirth, n_epochs, pmod, ...
    @(genotype) repLocalMutate(genotype, mutation_rate, mutation_size, boundaries), ...
    @(genotype, mind) ratBayShaky(genotype, mind, epsilon), n_runs);
end