function [minds, fitnesses, interactions] = playGame(edge_list, genotypes, minds, game, decisionRule)
%playGame(adjmx, genotypes, minds, base_fitnesses, game)
%	Agents given by (genotypes,minds) populate the vertices of the graphs given by (adjmx) and
%	play (game) between each other to determine (fitnesses) and update (minds).
%   (decision) is a function (genotype,mind --> strat) that decides if the
%   agent will cooperate or defect.
fitnesses = zeros(size(genotypes,1),1);
n_edges = size(edge_list,1);
interactions = zeros(3,1);

edge_list = edge_list(randperm(n_edges),:); %permute the order of interactions

for i = 1:n_edges, %play along each edge
    a1 = edge_list(i,1);
    a2 = edge_list(i,2);
    
    %make the decisions and record
    a1_decision = decisionRule(genotypes(a1,:),minds(a1,:));
    a2_decision = decisionRule(genotypes(a2,:),minds(a2,:));
    interactions(a1_decision + a2_decision - 1) = interactions(a1_decision + a2_decision - 1) + 1;
    
    %give fitness rewards
    fitnesses(a1) = fitnesses(a1) + game(a1_decision,a2_decision);
    fitnesses(a2) = fitnesses(a2) + game(a2_decision,a1_decision);
    
    %update brains
    minds(a1,(a1_decision - 1)*2 + a2_decision) = minds(a1,(a1_decision - 1)*2 + a2_decision) + 1;
    minds(a2,(a2_decision - 1)*2 + a1_decision) = minds(a2,(a2_decision - 1)*2 + a1_decision) + 1;
end;
