function data = subRat (adjmx, genotypes, minds, game, w, updateRule, max_epoch, pmod,reproduce)
% function subRat (adjmx, agents, game, w, update_rule, max_epoch)
%   game - is the square game matrix
%   adjmx - N x N boolean matrix describing connectivity
%   w  - selection strength
%   update_rule is a function (adjmx,genotypes,w, fitness, pmod, reproduce --> genotypes,minds) that
%     specifies how agents are modified.
%   max_epoch - number of iterations of the simulation
%   pmod - percent modified in the update rule


for epoch = 1:max_epoch 
    [minds, fitnesses] = playGame(adjmx, genotypes, minds, game);
    [genotypes, minds] = updateRule(adjmx, genotypes, w, fitnesses, pmod, reproduce);
    %need a line to collect data
end
    
