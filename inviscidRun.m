function [data, genotypes, minds] = inviscidRun(n_agents, n_epochs, ...
    pmod, game, epsilon, mutation_rate, mutation_size, boundaries)
%[data, genotypes, minds] = inviscidRun(n_agents, n_epochs, pmod, game, ...
%   epsilon, mutation_rate, mutation_size, boundaries)
%input:
%   n_agents - number of agents
%   n_epochs - number of epochs
%   pmod - percent modified in the update rule
%   game - 2 x 2 matrix that represents the game (payoff matrix)
%   epsilon - the chance that an agent will shake its hand
%   mutation_rate - the chance that an agent will mutate when reproducing
%   mutation_size - the maximum size of a mutation "step"
%   boundaries - 1 x 4 vector that sets the boundaries for U and V, where
%       [1] is minimum value of U
%       [2] is the maximum value of U
%       [3] is the minimum value of V
%       [4] is the maximum value of V

if (nargin < 8) || isempty(boundaries),
    boundaries = [-2, 2, -2, 2];
end;

if (nargin < 7) || isempty(mutation_size),
    mutation_size = 0.2;
end;

if (nargin < 6) || isempty(mutation_rate),
    mutation_rate = 0.05;
end;

if (nargin < 5) || isempty(epsilon),
    epsilon = 0.05;
end;

if (nargin < 4) || isempty(game),
    game = [1, -1 ; 2, 0];
end;

adjmx = ones(n_agents) - eye(n_agents);
genotypes = rand(n_agents, 2);
genotypes(:, 1) = genotypes(:, 1) .* (boundaries(2) - boundaries(1)) + boundaries(1);
genotypes(:, 2) = genotypes(:, 2) .* (boundaries(4) - boundaries(3)) + boundaries(3);

minds = zeros(n_agents, 4);

[data, genotypes, minds] = subRat(adjmx, genotypes, minds, game, [], ...
    @deathBirth, n_epochs, pmod, ...
    @(genotype) repLocalMutate(genotype, mutation_rate, mutation_size, boundaries), ...
    @(genotype, mind) ratBayShaky(genotype, mind, epsilon));
end

