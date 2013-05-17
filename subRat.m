function [data, genotypes, minds] = subRat (adjmx, genotypes, minds, ...
    game, w, updateRule, max_epoch, pmod, reproduce, decisionRule, ...
    p_shuffle)
%[data, genotypes, minds] = subRat (adjmx, genotypes, minds, game, w, ...
%   updateRule, max_epoch, pmod, reproduce, decisionRule,p_s,alphas)
%
%This runs the subjective-objective rationality simulation by alternating
%steps of 'playGame', randomize world with probabilty [p_s], [updateRule],
%and 'collectData'.
%
%Input:
%   adjmx           - N x N boolean matrix describing connectivity
%   genotypes       - N x 2 vector where [i, 1] is the ith agent's U value and
%       [i, 2] is the V value for the game the agent thinks they are playing
%   minds           - N x 4 vector where
%       [i, 1] is the number of cooperations seen when the ith agent cooperated
%       [i, 2] is the number of defections seen when the ith agent
%           cooperated
%       [i, 3] is the number of cooperations seen when the ith agent
%           defected
%       [i, 4] is the number of defections seen when the ith agent defected
%   game            - 2 x 2 matrix that represents the game (payoff matrix)
%   w               - selection strength
%   updateRule      - a function (adjmx, genotypes, w, fitness, pmod, 
%                   reproduce --> genotypes, dead) that specifies how agents
%                   are modified
%   max_epoch       - number of iterations of the simulation
%   pmod            - percent modified in the update rule
%   reproduce       - a function (genotype --> genotype) that specifies how
%                   a child is created
%   decisionRule    - a function (genotype,mind --> strategy) that lets the
%                   agent decide if they want too cooperate or defect based
%                   on their genotype and mind
%   p_s             - probability that agents are randomly redistributed
%                   over graph at each cycle (0 for static, and 1 for
%                   inviscid); default value is 0.
%
%Output:
%   data - max_epoch x 11 matrix where (at timestep t)
%       [t, 1] is the number of mutual cooperations
%       [t, 2] is the number of unilateral defections
%       [t, 3] is the number of mutual defections
%       [t, 4] is average U
%       [t, 5] is average V
%       [t, 6] is std of U
%       [t, 7] is std of V
%       [t, 8] is average p
%       [t, 9] is average q
%       [t, 10] is std of p
%       [t, 11] is std of q
%   genotypes - the (genotypes) at the last timestep
%   minds - the (minds) at the last timestep


if (nargin < 11) || isempty(p_shuffle),
    p_shuffle = 0;
end;

data = zeros(max_epoch, 11 + 2 * (size(genotypes, 2) > 2));

edge_list = adjmx2edge_list(adjmx);

for epoch = 1:max_epoch 
    [minds, fitnesses, interactions] = playGame(edge_list, genotypes, minds, game, decisionRule);
    if (rand < p_shuffle),
        new_world_order = randperm(size(genotypes,1));
        genotypes = genotypes(new_world_order,:);
        minds = minds(new_world_order,:);
        fitnesses = fitnesses(new_world_order);
    end;
    [genotypes, change_list] = updateRule(adjmx, genotypes, w, fitnesses, pmod, reproduce);
    minds(change_list,:) = zeros(length(change_list),4); %clear the minds of newborns
    data(epoch, 1:3) = interactions;
    data(epoch, 4:11 + 2 * (size(genotypes, 2) > 2)) = collectData(genotypes, minds);
end
    
