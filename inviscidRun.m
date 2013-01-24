function [data, genotypes, minds] = inviscidRun(n_agents, n_epochs, ...
    pmod, game, epsilon, mutation_rate, mutation_size, boundaries)
%[data, genotypes, minds] = inviscidRun(n_agents, n_epochs, pmod, game, ...
%   epsilon, mutation_rate, mutation_size, boundaries)

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

